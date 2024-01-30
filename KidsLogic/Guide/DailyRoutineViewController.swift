//
//  DailyRoutineViewController.swift
//  AbilityToHelp
//
//  Created by Anish on 1/28/24.
//

import UIKit
import AVFoundation
import QuartzCore

class DailyRoutineViewController: UIViewController,AVSpeechSynthesizerDelegate {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var btnPrevi: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var passArrDataSelected: [[String: Any]]?
    var selectedSubCatIndex: Int = 0
    var arrGetSubCatDetailsData: [Any] = []
    
    
    lazy var synthesizer: AVSpeechSynthesizer = {
        let synth = AVSpeechSynthesizer()
        synth.delegate = self
        return synth
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.alphabetDetailsArray()
        arrGetSubCatDetailsData = passArrDataSelected!
        // Do any additional setup after loading the view.
        if let Str_ImageName = (self.arrGetSubCatDetailsData[self.selectedSubCatIndex] as? [String: Any])?["Image"] as? String {
            imgSelected.image = UIImage(named: Str_ImageName)
            imgSelected.layer.cornerRadius = 10
            imgSelected.clipsToBounds = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.displaySelected(self.selectedSubCatIndex)
        }
    }
    @IBAction func btn_click_Prev(_ sender: Any) {
        // Implement your action for the previous button
        synthesizer.stopSpeaking(at: .immediate)
        
        if selectedSubCatIndex > 0 {
            selectedSubCatIndex -= 1
            displaySelected(selectedSubCatIndex)
        } else {
            displaySelected(selectedSubCatIndex)
        }
    }

    @IBAction func btn_click_next(_ sender: Any) {
        synthesizer.stopSpeaking(at: .immediate)

         if selectedSubCatIndex < (arrGetSubCatDetailsData.count - 1) {
             selectedSubCatIndex += 1
             displaySelected(selectedSubCatIndex)
         } else {
             displaySelected(selectedSubCatIndex)
         }
    }

    @IBAction func btn_click_Replay(_ sender: Any) {
        // Implement your action for the replay button
        synthesizer.stopSpeaking(at: .immediate)
          displaySelected(selectedSubCatIndex)
    }

    func displaySelected(_ indexVal: Int) {
        guard let title = (arrGetSubCatDetailsData[indexVal] as? [String: Any])?["Title"] as? String else {
            return
        }
        lblName.text = title
        
        if UI_USER_INTERFACE_IDIOM() == .phone {
            lblName.font = UIFont.boldSystemFont(ofSize: 35)
        } else {
            lblName.font = UIFont.boldSystemFont(ofSize: 50)
        }
        
        if let imageName = (arrGetSubCatDetailsData[indexVal] as? [String: Any])?["Image"] as? String {
            imgSelected.image = UIImage(named: imageName)
            imgSelected.layer.cornerRadius = 10
            imgSelected.clipsToBounds = true
        }
        
        let leftWobble = CGAffineTransform(rotationAngle: radians(15.0))
        let rightWobble = CGAffineTransform(rotationAngle: radians(0.0))
        
        imgSelected.transform = leftWobble
        
        UIView.animate(withDuration: 0.125, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.imgSelected.transform = rightWobble
        }, completion: nil)
        
        speakWord((arrGetSubCatDetailsData[indexVal] as? [String: Any])?["Desc_Data"] as? String)
        shakeView()
    }

    func radians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / 180)
    }

    func speakWord(_ word: String?) {
        if let word = word {
            GlobleConstants.theAppDelegate.speakWord(word)
        }
    }

    func shakeView() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: imgSelected.center.x - 5, y: imgSelected.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: imgSelected.center.x + 5, y: imgSelected.center.y))
        imgSelected.layer.add(shake, forKey: "position")
    }
   
    
    func alphabetDetailsArray() {
        self.passArrDataSelected = [
            ["Title": "Wake up", "Image": "Wake up", "Desc_Data": "Wake up"],
            ["Title": "Get up", "Image": "Get up", "Desc_Data": "Get up"],
            ["Title": "Clean my teeth", "Image": "Clean my teeth", "Desc_Data": "Clean my teeth"],
            ["Title": "Have a shower", "Image": "Have a shower", "Desc_Data": "Have a shower"],
            ["Title": "Get dressed", "Image": "Get dressed", "Desc_Data": "Get dressed"],
            ["Title": "Have Breakfast", "Image": "Have Breakfast", "Desc_Data": "Have Breakfast"],
            ["Title": "Go to school", "Image": "Go to school", "Desc_Data": "Go to school"],
            ["Title": "Have lunch", "Image": "Have lunch", "Desc_Data": "Have lunch"],
            ["Title": "Do homework", "Image": "Do homework", "Desc_Data": "Do homework"],
            ["Title": "Have dinner", "Image": "Have dinner", "Desc_Data": "Have dinner"],
            ["Title": "Go to bed", "Image": "Go to bed", "Desc_Data": "Go to bed"]
        ]
    }
}
