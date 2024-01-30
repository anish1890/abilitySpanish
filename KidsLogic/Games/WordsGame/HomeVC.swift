//
//  HomeVC.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 04/05/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore
import SDWebImage
import GoogleMobileAds
import MessageUI
import Localize_Swift

class HomeVC: UIViewController{

    //MARK: - Outlets
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var imgBottomIcon: UIImageView!
    @IBOutlet weak var imgBottomHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var imgBGHome: UIImageView!
    @IBOutlet weak var imgHomeLogoIcon: UIImageView!
    @IBOutlet weak var viewHome: UIView!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var vwBanner:UIView!
    @IBOutlet weak var heightOfBanner:NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    
    //MARK: - Properties
    var backPressed = ""
    var ref: DatabaseReference?
    var arrCategory = [CategoryModel]()
    private var appOpen: GADAppOpenAd?
    private var interstitial: GADInterstitialAd?
    var bannerView = GADBannerView()
    
    //MARK: - Override methods or viewController Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        if !isConnectedToInternet()
        {
            appDelegate.ShowInternetErrorScreen {
                self.setUI()
                
            }
            return
        }
        
//        if let isupgrade = getInt(key: isUpgradePlan), isupgrade == 1{
//        }else{
//            if(appDelegate.modelConfig.isShowiOSAds){
//                setupAds()
//            }else{
//                heightOfBanner.constant = 0
//            }
//        }
        
        setUI()
        
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
        lblTitle.text = "Category".localized()
        btnStart.setTitle("Start".localized(), for: .normal)
    }
    
    //MARK: - CUSTOM METHODS
    
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
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

//MARK: - ACTION
extension HomeVC{
    @IBAction func btnSettingAction(_ sender: UIButton) {
//        let arr:[String] = [String]()
//        print(arr[0])
//        return
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.vc = self
        vc.isRateUsPressed = {press in
            if press{
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "RateVC") as! RateVC
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnStartAction(_ sender: UIButton) {
//        upDownLeaf()
        collectionCategory.reloadData()
        backPressed = "1"
        UIView.animate(withDuration: 0.3, animations: {
            self.imgBGHome.frame.origin.y -= 90 /// go up
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.viewCategory.isHidden = false
                self.imgHomeLogoIcon.isHidden = true
                self.viewHome.isHidden = true
            }
        }) { _ in
        }
    }
    
    @IBAction func btnBackPopAction(_ sender: UIButton) {
        if backPressed == "1"{
            backPressed = ""
            UIView.animate(withDuration: 0.3, animations: {
                self.imgBGHome.frame.origin.y += 90 /// go up
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.viewCategory.isHidden = true
                    self.imgHomeLogoIcon.isHidden = false
                    self.viewHome.isHidden = false
                }
            }) { _ in
                UIView.animate(withDuration: 0.4, animations: {
                })
            }
        }else{}
    }
}

//MARK: - Method
extension HomeVC{
    func setUI() {
        if getInt(key: USER_COIN) == nil {
            setInt(value: 200, key: USER_COIN)
        }
        
        collectionCategory.delegate = self
        collectionCategory.dataSource = self
        
        collectionCategory.register(UINib(nibName: "HomeCategoryCell", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCell")
//        collectionCategory.applyCornerRadius(16.0)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.scrollDirection = .vertical
        collectionCategory.collectionViewLayout = flowLayout
    }
    
    func addAds(){

    }
    
    func show(){
        if let ad = appOpen {
            ad.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
    }
    
    func sendFeedback(){
        if MFMailComposeViewController.canSendMail(){
            sendEmail()
        } else {
            print("Mail services are not available")
        }
    }
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        composeVC.setToRecipients([FeedbackEmail])
        composeVC.setSubject(feedbackSubject)
        composeVC.setMessageBody(feedbackMessageBody, isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func upDownLeaf() {
        UIView.animate(withDuration: 0.3, animations: {
                self.imgBottomIcon.frame.origin.y += 50 /// go down
        }) { _ in
            UIView.animate(withDuration: 0.4, animations: {
                self.imgBottomIcon.frame.origin.y -= 50 /// go up
            })
        }
    }
    
    func interstitialAddAds(){

    }
    
    func show(_ type:GoogleAddType){
        switch type {
        case .Interstitial:
            if let ad = interstitial {
                ad.present(fromRootViewController: self)
            } else {
              print("Ad wasn't ready")
            }
        case .Rewarded:
            break;
        case .AppOpen:
            break;
        }
    }
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.arrPuzzleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCell", for: indexPath) as! HomeCategoryCell
        
        let model = appDelegate.arrPuzzleData[indexPath.row]
        
        cell.lblTitle.text = model.name
        cell.imgItem.sd_setImage(with: URL(string: model.image ?? ""), placeholderImage: UIImage(named: "ic_homeIcon1"), options: .highPriority, context: nil)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: ((self.collectionCategory.width / 2) - 10) , height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let isupgrade = getInt(key: isUpgradePlan), isupgrade == 1{
        }else{
            if(appDelegate.modelConfig.isShowiOSAds){
                let adsPresentCount = getInt(key: ADS_PRESENT_COUNT) ?? 1
                if adsPresentCount == appDelegate.modelConfig.adsPresentCount{
                    setInt(value: 1, key: ADS_PRESENT_COUNT)
                    interstitialAddAds()
                    return
                }else{
                    setInt(value: adsPresentCount + 1, key: ADS_PRESENT_COUNT)
                }
            }
        }
        
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "PuzzleStageVC") as! PuzzleStageVC
        let model = appDelegate.arrPuzzleData[indexPath.row]
        vc.puzzleModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Google Ads fullScreenContentDelegate Method
extension HomeVC:GADFullScreenContentDelegate{
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad will present full screen content.
      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
      }
}

//MARK: - MF Mail Compose View Controller Delegate
extension HomeVC:MFMailComposeViewControllerDelegate{
    private func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


//MARK: - Banner Delegate

extension HomeVC:GADBannerViewDelegate {
    
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
