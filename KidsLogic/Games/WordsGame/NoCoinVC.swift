//
//  NoCoinVC.swift
//  WordPuzzle
//
//  Created by MAC on 26/09/22.
//

import UIKit

class NoCoinVC: UIViewController {

    //MARK: - Properties
    var completionHandler:(()->())?
    
    //MARK: - viewController Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: - ACTION
extension NoCoinVC{
    @IBAction func btnIncreaseCoinClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if let completionHandler = completionHandler{
            completionHandler()
        }
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
