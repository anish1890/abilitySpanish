//
//  LanguageSelectionPopUpVC.swift
//  WordPuzzle
//
//  Created by Mac on 16.10.23.
//

import UIKit
import Localize_Swift

class LanguageSelectionPopUpVC: UIViewController {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLang1: UILabel!
    @IBOutlet weak var lblLang2: UILabel!
    @IBOutlet weak var lblLang3: UILabel!
    @IBOutlet weak var btnLang1: UIButton!
    @IBOutlet weak var btnLang2: UIButton!
    @IBOutlet weak var btnLang3: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getInAppPurchasePrice
        if Localize.currentLanguage() == "en"{
            btnLang1.isSelected = true
            btnLang2.isSelected = false
            btnLang3.isSelected = false
        }else if Localize.currentLanguage() == "ur"{
            btnLang1.isSelected = false
            btnLang2.isSelected = true
            btnLang3.isSelected = false
        }else if Localize.currentLanguage() == "fr"{
            btnLang1.isSelected = false
            btnLang2.isSelected = false
            btnLang3.isSelected = true
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
        lblTitle.text = "Language".localized()
        lblLang1.text = "english".localized()
        lblLang2.text = "urdu".localized()
        lblLang3.text = "french".localized()
        btnCancel.setTitle("Cancel".localized(), for: .normal)
    }
    
    
    @IBAction func btnLangSelection(_ sender: UIButton) {
        _ = [btnLang1,btnLang2,btnLang3].map { btn in
            btn?.isSelected = btn?.tag == sender.tag
            Localize.setCurrentLanguage(sender.tag == 1 ? "en" : sender.tag == 2 ? "ur" : "fr")
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
