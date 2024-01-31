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
            ["Title": "Despertarse", "Image": "Wake up", "Desc_Data": "Despertarse"],
            ["Title": "Levantarse", "Image": "Get up", "Desc_Data": "Levantarse"],
            ["Title": "Cepillar mis dientes", "Image": "Clean my teeth", "Desc_Data": "Cepillar mis dientes"],
            ["Title": "Ducharse", "Image": "Have a shower", "Desc_Data": "Ducharse"],
            ["Title": "Vestirse", "Image": "Get dressed", "Desc_Data": "Vestirse"],
            ["Title": "Desayunar", "Image": "Have Breakfast", "Desc_Data": "Desayunar"],
            ["Title": "Ir a la escuela", "Image": "Go to school", "Desc_Data": "Ir a la escuela"],
            ["Title": "Almorzar", "Image": "Have lunch", "Desc_Data": "Almorzar"],
            ["Title": "Hacer la tarea", "Image": "Do homework", "Desc_Data": "Hacer la tarea"],
            ["Title": "Cenar", "Image": "Have dinner", "Desc_Data": "Cenar"],
            ["Title": "Ir a la cama", "Image": "Go to bed", "Desc_Data": "Ir a la cama"]
        ]
    }
}
