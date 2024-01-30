//
//  NoInternetConnectionVC.swift
//  WordPuzzle
//
//  Created by MAC on 26/09/22.
//

import UIKit

class NoInternetConnectionVC: UIViewController {

    //MARK: - Properties
    var completionHandler:(()->())?
    
    //MARK: - viewController Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: - ACTION
extension NoInternetConnectionVC{
    @IBAction func btnTryAgainClick(_ sender: UIButton) {
        if isConnectedToInternet(){
            if let completionHandler = completionHandler{
                completionHandler()
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
