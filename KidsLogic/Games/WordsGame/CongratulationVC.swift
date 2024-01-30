//
//  CongratulationVC.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 11/05/22.
//

import UIKit
import SDWebImage
import AVKit
import SwiftConfettiView

class CongratulationVC: UIViewController{
    
    //MARK: - Outlets
    @IBOutlet weak var ConfettiView: SwiftConfettiView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCoin: UILabel!
    @IBOutlet weak var imgObject: UIImageView!

    //MARK: - Properties
    var isQuitPressed : ((String) -> ())?
    let speechSynthesizer = AVSpeechSynthesizer()
    var isHintUsed = false
    var arrTextSpeech = [String]()
    var count : Int = 0
    var modelPuzzleDetails = ClsPuzzleData(fromDictionary: [:])
    var arrPuzzleStageData = [ClsPuzzleData]()
    var vc :DetailVC?
    
    //MARK: - viewController Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfettiView.type = .diamond
        ConfettiView.colors = [UIColor(named: "APP_BLACK_COLOR")!,UIColor(named: "APP_GREEN_COLOR")!, UIColor(named: "APP_ORANGE_COLOR")!,UIColor(named: "APP_RED_COLOR")!,UIColor(named: "TEXT_COLOR")!]
        ConfettiView.intensity = 0.75
        let lowerName = modelPuzzleDetails.catName?.lowercased() ?? ""
        self.arrTextSpeech = lowerName.map({ String($0) })
        
        lblCoin.text = "10"
        if isHintUsed == false{
            let coin = (getInt(key: USER_COIN) ?? 0) + 10
            setInt(value: coin, key: USER_COIN)
        }
     
        lblTitle.text = modelPuzzleDetails.catName
        self.imgObject.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imgObject.sd_setImage(with: URL(string: modelPuzzleDetails.catImage ?? ""), placeholderImage: UIImage(named: "ic_homeIcon1"), options: .highPriority, context: nil)
        
        speechSynthesizer.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        count = 0
        ConfettiView.startConfetti()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playAudioStartUp(isPlay: false)
        if getInt(key: SPEAK_KEYWORD) == 0{
            speechSynthesizer.stopSpeaking(at: .word)
            print(self.arrTextSpeech.joined())
            speechSynthesizer.speak(AVSpeechUtterance(string: self.arrTextSpeech.joined()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if getInt(key: SOUND_OFF) == 0{
                playAudioCongratulationUp(isPlay: true)
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        speechSynthesizer.pauseSpeaking(at: .immediate)
        ConfettiView.stopConfetti()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let vc = vc{
            if let isupgrade = getInt(key: isUpgradePlan), isupgrade == 1{
            }else{
              
            }
        }
    }
}

//MARK: - ACTION
extension CongratulationVC{
    @IBAction func btnQuitAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("DISMISSED")
            self.isQuitPressed?("1")
        }
    }
    
    @IBAction func btnContinueAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.isQuitPressed?("2")
        }
    }
}

//MARK: - AV Speech Synthesizer Delegate Method
extension CongratulationVC:AVSpeechSynthesizerDelegate{
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        
    }
        
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {

    }
}
