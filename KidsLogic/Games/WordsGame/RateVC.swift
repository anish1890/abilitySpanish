//
//  RateVC.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 17/05/22.
//

import UIKit

class RateVC: UIViewController {

    //MARK: - viewController Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()

    }  
}

//MARK: - Action
extension RateVC{
    @IBAction func btnRateUSAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            AppStoreReviewManager.requestReviewIfAppropriate()
        }
    }
    
    @IBAction func btnLaterAction(_ sender: Any) {
        self.dismissVC()
    }
}
