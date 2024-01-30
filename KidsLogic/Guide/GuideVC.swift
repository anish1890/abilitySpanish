//
//  GuideVC.swift
//  AbilityToHelp
//
//  Created by Anish on 1/27/24.
//

import UIKit

class GuideVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clsoe(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func gotoPage(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArticlesViewController") as! ArticlesViewController
        print(sender.tag)
        vc.selectedTag = sender.tag
       navigationController?.pushViewController(vc, animated: true)
    }
    

}
