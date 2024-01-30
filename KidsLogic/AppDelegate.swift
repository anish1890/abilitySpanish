//
//  AppDelegate.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//

import UIKit
import AVKit
import MediaPlayer
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import OneSignal
import SwiftyStoreKit
import FirebaseRemoteConfig
import FirebaseDatabase
import Alamofire
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var audioPlayer = AVAudioPlayer()
    
    var ref = DatabaseReference.init()
    var dicMainData = NSDictionary()
    var modelConfig = ClsRemoteConfig(fromDictionary: [:])
    var arrPuzzleData = [ClsPuzzleModel]()
    let reachabilityManager = NetworkReachabilityManager()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        self.copyDatabaseIfNeeded()
        getRemoteConfig()
        IQKeyboardManager.shared.enable = true
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func copyDatabaseIfNeeded() {
        let fileManager = FileManager.default
        let dbPath = getDBPath()
        
        if !fileManager.fileExists(atPath: dbPath) {
            if let defaultDBPath = Bundle.main.path(forResource: "preschool", ofType: "db") {
                do {
                    try fileManager.copyItem(atPath: defaultDBPath, toPath: dbPath)
                } catch {
                    assertionFailure("Failed to copy database file with error: \(error.localizedDescription)")
                }
            } else {
                assertionFailure("Default database file not found in the app bundle.")
            }
        }
    }

    func getDBPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return (paths[0] as NSString).appendingPathComponent("preschool.db")
    }
    
    var synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()

        func speakWord(_ wordStr: String) {
            synthesizer.stopSpeaking(at: .immediate)
            synthesizer = AVSpeechSynthesizer()
            
            let speechUtterance = AVSpeechUtterance(string: wordStr)
            speechUtterance.volume = 1.0
            speechUtterance.pitchMultiplier = 0.8
            speechUtterance.rate = 0.27
            
            // Uncomment the line below and update the language code as needed
            // speechUtterance.voice = AVSpeechSynthesisVoice(language: "hi-IN")
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            
            synthesizer.speak(speechUtterance)
        }
    func ShowInternetErrorScreen(completionHandler:@escaping (()->())){
        let vc = mainStoryboard.instantiateViewController(withIdentifier: String(describing: NoInternetConnectionVC.self)) as! NoInternetConnectionVC
        vc.modalPresentationStyle = .overFullScreen
        vc.completionHandler = completionHandler
        appDelegate.window?.visibleViewController?.present(vc, animated: true, completion: nil)
    }
    func getRemoteConfig(){
        SHOW_CUSTOM_LOADER()
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate { changed, error in
                    if let dictConfig = RemoteConfig.remoteConfig()
                        .configValue(forKey: "config_ios").jsonValue as? [String : Any] {
                        self.modelConfig = ClsRemoteConfig(fromDictionary: dictConfig)
                        self.checkIfUpdatedDataFirebase()
                       
                    }else{
                        HIDE_CUSTOM_LOADER()
                        displayAlertWithMessage("Error: \(error?.localizedDescription ?? "No error available.")")
                    }
                }
            } else {
                HIDE_CUSTOM_LOADER()
                if !isConnectedToInternet()
                {
                    self.ShowInternetErrorScreen {
                        self.getRemoteConfig()
                    }
                    return
                }
                print("Config not fetched")
                displayAlertWithMessage("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
    func checkIfUpdatedDataFirebase(){
        if let dictMain = getCustomObject(key: FIREBASE_DATA) as? NSDictionary, dictMain.count != 0 {
            if getInt(key: IS_UPDATE_FIREBASE_INFO) != nil{
                if(getInt(key: IS_UPDATE_FIREBASE_INFO) == self.modelConfig.updateFirebaseJson){
                    HIDE_CUSTOM_LOADER()
                    if let data = getPuzzleModelObject(key: PUZZLE_DATA){
                        arrPuzzleData = []
                        arrPuzzleData = data.map { model in
                            let mdata = getPuzzleDataObject(key: "\(ARRAY_PUZZLE_STAGES)_ID_\(model.id ?? 0)")
                            print("\(ARRAY_PUZZLE_STAGES)_ID_\(model.id ?? 0) ok")
                            if !(mdata?.isEmpty ?? true){
                                model.data = mdata
                            }
                            return model
                        }
//                        arrPuzzleData = data
                        self.dicMainData = dictMain
                        
                    }else{
                        getStoryFromFirebase()
                    }
                }else{
                    getStoryFromFirebase()
                }
            }else{
                getStoryFromFirebase()
            }
        }else{
            getStoryFromFirebase()
        }
        
    }
    
    func getStoryFromFirebase() {
        if !isConnectedToInternet()
        {
            ShowInternetErrorScreen {
                self.getStoryFromFirebase()
            }
            return
        }
        ref = Database.database().reference()
        
        ref.child("puzzle").observe(.value, with: { (snapshot) in
            if snapshot.childrenCount>0{
                self.arrPuzzleData = []
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    if let data = data.value as? [String: Any] {

                        let dict = ClsPuzzleModel(fromDictionary: data)
                        var dicData = getPuzzleDataObject(key: "\(ARRAY_PUZZLE_STAGES)_ID_\(dict.id ?? 0)")
                        if dict.data.count == dicData?.count{
                            dict.data = dicData
                        }else{
                            for i in 0..<(dicData?.count ?? 0){
                                var isEqual = false
                                var data = dicData![i]
                                for j in 0..<(dict.data.count){
                                    if dicData![i].catId == dict.data[j].catId{
                                        isEqual = true
                                        data = dict.data[j]
                                        break;
                                    }
                                }
                                if isEqual{
                                    dicData![i] = data
                                }
                            }

                        }
                        self.arrPuzzleData.append(dict)
                    }
                }
                setPuzzleModelObject(value: self.arrPuzzleData, key: PUZZLE_DATA)
            }
        })
        
        self.ref = Database.database().reference()
        ref.observeSingleEvent(of: .value) { snapshot in
            if let dic = snapshot.value as? NSDictionary {
                HIDE_CUSTOM_LOADER()
                setCustomObject(value: dic, key: FIREBASE_DATA)
                setInt(value: self.modelConfig.updateFirebaseJson, key: IS_UPDATE_FIREBASE_INFO)
                self.dicMainData = dic
               
                
            }else{
                HIDE_CUSTOM_LOADER()
                displayAlertWithMessage(ALERT_SOME_THINGS)
            }
        }
    }
}

