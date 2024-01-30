//
//  PrivacyPolicyVC.swift
//  WordPuzzle
//
//  Created by MAC on 28/09/22.
//

import UIKit
import WebKit
import GoogleMobileAds

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var vwBanner:UIView!
    @IBOutlet weak var heightOfBanner:NSLayoutConstraint!
    
    var bannerView = GADBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let url = URL(string: appDelegate.modelConfig.iOSPrivacyPolicy)
            webView.load(URLRequest(url: url!))
        if let isupgrade = getInt(key: isUpgradePlan), isupgrade == 1{
        }else{
            if(appDelegate.modelConfig.isShowiOSAds){
                setupAds()
            }else{
                heightOfBanner.constant = 0
            }
        }
    }
    
    //MARK: - Functions
    func setupAds(){
        bannerView = GADBannerView(adSize: bannerSize)
        bannerView.adUnitID = GBBannerID
        bannerView.rootViewController = self
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.load(GADRequest())
        bannerView.delegate = self
        vwBanner.addSubview(bannerView)
        vwBanner.isHidden = true
        bannerView.centerXAnchor.constraint(equalTo: vwBanner.centerXAnchor).isActive = true
        bannerView.centerYAnchor.constraint(equalTo: vwBanner.centerYAnchor).isActive = true
    }
}

//MARK: - Banner Delegate

extension PrivacyPolicyVC:GADBannerViewDelegate {
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
        vwBanner.isHidden = false
        heightOfBanner.constant = 50
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        heightOfBanner.constant = 0
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print("bannerViewDidRecordImpression")
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDIsmissScreen")
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
    
}
