//
//  SettingVC.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 11/05/22.
//

import UIKit
import SwiftyStoreKit
import MediaPlayer
import Localize_Swift

class SettingVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnPuzzelUsingImageOrSound: UIButton!
    @IBOutlet weak var btnAddFreeOrNot: UIButton!
    @IBOutlet weak var lblPopUpTitle: UILabel!
    @IBOutlet weak var btRateUs: UIButton!
    @IBOutlet weak var btnSendFeedback: UIButton!
    @IBOutlet weak var btnInviteFriends: UIButton!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var btnResetPuzzle: UIButton!
    @IBOutlet weak var btnLanguage: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - Properties
    var vc:UIViewController?
    var isRateUsPressed : ((Bool) -> ())?
    
    //MARK: - viewController Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
//        getInAppPurchasePrice
        btnSound.isSelected = getInt(key: SOUND_OFF) == 1
        btnPuzzelUsingImageOrSound.isSelected = getInt(key: PUZZEL_USING_IMAGE_OR_SOUND) != 1
        
        if let notificationSwitch = getInt(key: NOTIFICATION_SWITCH),notificationSwitch == 0{
            btnNotification.isSelected = true
            btnAddFreeOrNot.isHidden = true
        }else{
            btnNotification.isSelected = false
            btnAddFreeOrNot.isHidden = false
        }
        setText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name("LCLLanguageChangeNotification"), object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("LCLLanguageChangeNotification"), object: nil)
    }
    
    @objc func setText(){
        lblTitle.text = "Setting".localized()
        btRateUs.setTitle("Rate Us".localized(), for: .normal)
        btnSendFeedback.setTitle("Send Feedback".localized(), for: .normal)
        btnInviteFriends.setTitle("Invite Friends".localized(), for: .normal)
        btnPrivacyPolicy.setTitle("Privacy Policy".localized(), for: .normal)
        btnResetPuzzle.setTitle("Reset Puzzle".localized(), for: .normal)
        btnLanguage.setTitle("Language".localized(), for: .normal)
        
        btRateUs.titleLabel?.font = UIFont(name: "HelveticaRoundedLTStd-Bd", size: Localize.currentLanguage() == "fr" ? 14 : 16) ?? btRateUs.titleLabel?.font
        btnSendFeedback.titleLabel?.font = UIFont(name: "HelveticaRoundedLTStd-Bd", size: Localize.currentLanguage() == "fr" ? 14 : 16) ?? btnSendFeedback.titleLabel?.font
        btnInviteFriends.titleLabel?.font = UIFont(name: "HelveticaRoundedLTStd-Bd", size: Localize.currentLanguage() == "fr" ? 14 : 16) ?? btnInviteFriends.titleLabel?.font
        btnPrivacyPolicy.titleLabel?.font = UIFont(name: "HelveticaRoundedLTStd-Bd", size: Localize.currentLanguage() == "fr" ? 14 : 16) ?? btnPrivacyPolicy.titleLabel?.font
        btnResetPuzzle.titleLabel?.font = UIFont(name: "HelveticaRoundedLTStd-Bd", size: Localize.currentLanguage() == "fr" ? 14 : 16) ?? btnResetPuzzle.titleLabel?.font
        btnLanguage.titleLabel?.font = UIFont(name: "HelveticaRoundedLTStd-Bd", size: Localize.currentLanguage() == "fr" ? 14 : 16) ?? btnLanguage.titleLabel?.font
        
    }
}

//MARK: - ACTION
extension SettingVC{
    @IBAction func btnRateUsAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.isRateUsPressed?(true)
        }
    }
    
    @IBAction func btnNoAdsAction(_ sender: UIButton) {
//        purchasePlan(plan: IN_APP_PURCHASE_BUNDLE_ID)
        dismissVC()
        let next = mainStoryboard.instantiateViewController(withIdentifier: String(describing: AppPurchaseVC.self))
        vc?.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func btnSendFeedbackAction(_ sender: UIButton) {
        dismissVC()
        if let vc = vc as? HomeVC{
            vc.sendFeedback()
        }
    }
    
    @IBAction func btnInviteFriendsAction(_ sender: UIButton) {
        dismissVC()
        if let vc = vc {
            AppSupport.shareApp(inController: vc)
        }
    }
    
    @IBAction func btnPrivacyPolicyAction(_ sender: UIButton) {
        dismissVC()
        let next = mainStoryboard.instantiateViewController(withIdentifier: String(describing: PrivacyPolicyVC.self))
        vc?.navigationController?.pushViewController(next, animated: true)
    }
    
    
    @IBAction func btnResetPuzzelAction(_ sender: UIButton) {
        removeAllKeyFromDefault()
        //appDelegate.getRemoteConfig()
    }
    
    @IBAction func btnQuitAction(_ sender: UIButton) {
        dismissVC()
    }
    
    @IBAction func btnNotificationAction(_ sender: UIButton) {
        if let notificationSwitch = getInt(key: NOTIFICATION_SWITCH),notificationSwitch == 0{
            setInt(value: 1, key: NOTIFICATION_SWITCH)
            //appDelegate.registerNotification()
        }
        else{
            setInt(value: 0, key: NOTIFICATION_SWITCH)
            UIApplication.shared.unregisterForRemoteNotifications()
        }
        btnNotification.isSelected = getInt(key: NOTIFICATION_SWITCH) != 1
    }
    
    @IBAction func btnMuteAction(_ sender: UIButton) {
        if getInt(key: SOUND_OFF) == 1{
            sender.isSelected = false
            setInt(value: 0, key: SOUND_OFF)
            setInt(value: 0, key: SPEAK_KEYWORD)
            playAudioStartUp(isPlay: true)
            (MPVolumeView().subviews.filter{ NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as? UISlider)?.setValue(1, animated: false)
        }else{
            sender.isSelected = true
            playAudioStartUp(isPlay: false)
            setInt(value: 1, key: SOUND_OFF)
            setInt(value: 1, key: SPEAK_KEYWORD)
            (MPVolumeView().subviews.filter{ NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as? UISlider)?.setValue(0, animated: false)
        }
    }
    
    @IBAction func btnAddFreeOrNotAction(_ sender: UIButton) {
        if let notificationSwitch = getInt(key: ADD_FREE_OR_NOT),notificationSwitch == 0{
            setInt(value: 1, key: ADD_FREE_OR_NOT)
//            appDelegate.registerNotification()
        }
        else{
            setInt(value: 0, key: ADD_FREE_OR_NOT)
            UIApplication.shared.unregisterForRemoteNotifications()
        }
        btnPuzzelUsingImageOrSound.isSelected = getInt(key: ADD_FREE_OR_NOT) != 1
    }
    
    @IBAction func btnPuzzelUsingImageOrSoundAction(_ sender: UIButton) {
        if let notificationSwitch = getInt(key: PUZZEL_USING_IMAGE_OR_SOUND),notificationSwitch == 0{
            setInt(value: 1, key: PUZZEL_USING_IMAGE_OR_SOUND)
//            appDelegate.registerNotification()
        }
        else{
            setInt(value: 0, key: PUZZEL_USING_IMAGE_OR_SOUND)
            UIApplication.shared.unregisterForRemoteNotifications()
        }
        btnPuzzelUsingImageOrSound.isSelected = getInt(key: PUZZEL_USING_IMAGE_OR_SOUND) != 1
    }
    
    @IBAction func btnLanguageAction(_ sender: UIButton) {
//        let actionsheet = UIAlertController(title: "Select Language".localized(), message: "", preferredStyle: .actionSheet)
//        let english = UIAlertAction(title: "english".localized(), style: .default) { _ in
//            Localize.setCurrentLanguage("en")
//            Localize.load()
//        }
//        let urdu = UIAlertAction(title: "urdu".localized(), style: .default) { _ in
//            Localize.setCurrentLanguage("ur")
//        }
//        let french = UIAlertAction(title: "french".localized(), style: .default) { _ in
//            Localize.setCurrentLanguage("fr")
//        }
//        let cancle = UIAlertAction(title: "Cancel".localized(), style: .cancel){ _ in
//        }
//        actionsheet.addAction(english)
//        actionsheet.addAction(urdu)
//        actionsheet.addAction(french)
//        actionsheet.addAction(cancle)
//        self.present(actionsheet, animated: true)
        
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "LanguageSelectionPopUpVC") as! LanguageSelectionPopUpVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: - Method
extension SettingVC{
   
    func purchasePlan(plan:String) {
        print("plan \(plan)")
        SHOW_CUSTOM_LOADER()
        SwiftyStoreKit.purchaseProduct(plan, completion: { result in
            HIDE_CUSTOM_LOADER()
            switch result {
            case .success(let product):
                // fetch content from your server, then:
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                self.dismiss(animated: true, completion: nil)
                print("Purchase Success: \(product.productId)")
//                setInt(value: 1, key: isUpgradePlan)
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        })
    }
    
    func getInAppPurchasePrice() {
        SwiftyStoreKit.retrieveProductsInfo([IN_APP_PURCHASE_BUNDLE_ID]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(result.error)")
            }
        }
    }
}
