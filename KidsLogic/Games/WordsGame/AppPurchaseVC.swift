//
//  AppPurchaseVC.swift
//  WordPuzzle
//
//  Created by MAC on 27/09/22.
//

import UIKit
import SwiftyStoreKit

class AppPurchaseVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var viewProImage: UIView!
    @IBOutlet weak var viewProVersion: UIView!
    
    //MARK: - viewController Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        viewProVersion.applyShadowWithColorHeight(.gray, opacity: 1, radius: 5)
        viewProImage.applyShadowWithColorHeight(.gray, opacity: 1, radius: 5)
        // Do any additional setup after loading the view.
        
        getInAppPurchasePrice()
    }
}

//MARK: - Method
extension AppPurchaseVC{
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
                print("Purchase Success: \(product.productId)")
                setInt(value: 1, key: isUpgradePlan)
                self.navigationController?.popViewController(animated: true)
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
}

//MARK: - ACTION
extension AppPurchaseVC{
    @IBAction func btnBackPopAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpgradeAction(_ sender: UIButton) {
        purchasePlan(plan: IN_APP_PURCHASE_BUNDLE_ID)
    }
    
    @IBAction func btnRestorePurchaseAction(_ sender:UIButton) {
        SHOW_CUSTOM_LOADER()
        SwiftyStoreKit.restorePurchases { (results) in
            HIDE_CUSTOM_LOADER()
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
            }
            else if results.restoredPurchases.count > 0 {
                for purchase in results.restoredPurchases {
                    // fetch content from your server, then:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                }
                
                print("Restore Success: \(results.restoredPurchases)")
                setInt(value: 1, key: isUpgradePlan)
                self.navigationController?.popViewController(animated: true)
                
//                DispatchQueue.main.async {
//                    self.navigationController?.backToViewController(vc: HomeVC())
//                }
            }
            else {
                print("Nothing to Restore")
                displayAlertWithMessage("You do not have any plan to restore")
            }
        }
    }
}
