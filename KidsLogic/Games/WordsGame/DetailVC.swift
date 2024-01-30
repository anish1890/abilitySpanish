//
//  DetailVC.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 08/05/22.
//

import UIKit
import AVFoundation
import SDWebImage
import MediaPlayer
import AVFoundation
import GoogleMobileAds

class DetailVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var btnSpeakHint: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTotalCoin: UILabel!
    @IBOutlet weak var lblHintCoinAlpabet: UILabel!
    @IBOutlet weak var lblHintCoinKey: UILabel!
    @IBOutlet weak var imgObject: UIImageView!
    @IBOutlet weak var collectionViewAlphabet: UICollectionView!
    @IBOutlet weak var collectionViewRandomAlpha: UICollectionView!
    @IBOutlet weak var collectionRandomAlphaHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionSelectedAlphaHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ViewSoundPlay: UIView!
    @IBOutlet weak var btnSoundPlay: UIButton!
    @IBOutlet weak var lblFree: UILabel!
    
    //MARK: - Properties
    var arrName = [String]()
    var arrTextSpeech = [String]()
    var arrRandomAlpha = [String]()
    var arrTemp = [String]()
    let speechSynthesizer   = AVSpeechSynthesizer()
    var count : Int = 0
    var isBackPressed : ((Bool) -> ())?
    var totalCount = ""
    var puzzleID = Int()
    var puzzleTitle = ""
    var isWrongName = "0"
    var isHintButtonPressed = false
    var isWordSlectThenHintPress = false
    var pressedHint = false
    var puzzleStageIndex : Int = 0
    var currentPuzzleStageIndex : Int = 0
    var modelPuzzleDetails = ClsPuzzleData(fromDictionary: [:])
    var arrPuzzleStageData = [ClsPuzzleData]()
    var puzzleModel = ClsPuzzleModel(fromDictionary: [:])
    private var rewardedAd: GADRewardedAd?
    private var interstitial: GADInterstitialAd?
    var player = AVPlayer()
    var soundURL:URL?
    
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
//        interstitialAddAds()
        
        setUI()
        imgObject.applyShadowWithColorHeight(.gray, opacity: 0.5, radius: 5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblTotalCoin.text = "\(getInt(key: USER_COIN) ?? 0)"
        self.collectionViewRandomAlpha.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)
        self.collectionViewAlphabet.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        speechSynthesizer.pauseSpeaking(at: .immediate)
        self.collectionViewRandomAlpha.removeObserver(self, forKeyPath: "contentSize")
        self.collectionViewAlphabet.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is UICollectionView{
            if (object as! UICollectionView) == collectionViewRandomAlpha{
                print("contentSize:= \(collectionViewRandomAlpha.contentSize.height)")
                self.collectionRandomAlphaHeight.constant = collectionViewRandomAlpha.contentSize.height
                if self.collectionRandomAlphaHeight.constant <= 0 {
                    self.collectionRandomAlphaHeight.constant = 0.0
                }
            }else{
                print("contentSize:= \(collectionViewAlphabet.contentSize.height)")
                self.collectionSelectedAlphaHeight.constant = collectionViewAlphabet.contentSize.height
                if self.collectionSelectedAlphaHeight.constant <= 0 {
                    self.collectionSelectedAlphaHeight.constant = 0.0
                }
            }
        }
    }
    
    
    
    
}

//MARK: - ACTION
extension DetailVC{
    @IBAction func btnFreeAction(_ sender: UIButton) {
        rewardAddAds()
    }
    
    @IBAction func btnKeyHintAction(_ sender: UIButton) {
        arrTemp.removeAll()
        let coin = (getInt(key: USER_COIN) ?? 0) - 20
        if coin < 0{
            noCoinVCPresent()
            return
        }else{
            setInt(value: coin, key: USER_COIN)
            lblTotalCoin.text = "\(getInt(key: USER_COIN) ?? 0)"
            isHintButtonPressed = true
            self.arrName = self.arrTextSpeech
            self.collectionViewAlphabet.reloadData()
        }
    }
    
    @IBAction func btnClearExtraWordAction(_ sender: UIButton) {
        pressedHint = true
        let coin = (getInt(key: USER_COIN) ?? 0) - 10
        if coin < 0{
            noCoinVCPresent()
            return
        }else{
            setInt(value: coin, key: USER_COIN)
            lblTotalCoin.text = "\(getInt(key: USER_COIN) ?? 0)"
        }
        
        if isWordSlectThenHintPress{
            for i in 0..<arrName.count {
                arrName[i] = ""
            }

            for j in 0..<self.arrTemp.count{
                if let p = arrRandomAlpha.firstIndex(of: "") {
                    arrRandomAlpha[p] = arrTemp[j]
                }
            }
            
            for i in 0..<arrRandomAlpha.count{
                if arrTextSpeech.contains(arrRandomAlpha[i].lowercased()){
                    print("Cntain")
                }else{
                    print("Not Cntain")
                    arrRandomAlpha[i] = ""
                }
            }
            
            self.collectionViewAlphabet.reloadData()
        }else{
            for i in 0..<arrRandomAlpha.count{
                if arrTextSpeech.contains(arrRandomAlpha[i].lowercased()){
                    print("Cntain")
                }else{
                    print("Not Cntain")
                    arrRandomAlpha[i] = ""
                }
            }
        }
        arrTemp.removeAll()
        collectionViewRandomAlpha.reloadData()
    }
    
    @IBAction func btnRestartAction(_ sender: UIButton) {
        generateRandomAlpha()
        self.arrTemp.removeAll()
        collectionViewRandomAlpha.reloadData()
        collectionViewAlphabet.reloadData()
    }
    
    @IBAction func btnBackPopAction(_ sender: UIButton) {
        isBackPressed?(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSpeakHintAction(_ sender: UIButton) {
        if getInt(key: SPEAK_KEYWORD) == 1{
            sender.isSelected = false
            setInt(value: 0, key: SPEAK_KEYWORD)
        }else{
            sender.isSelected = true
            setInt(value: 1, key: SPEAK_KEYWORD)
        }
    }
    
    @IBAction func btnSoundPlayAction(_ sender: UIButton) {
        player.seek(to: .zero)
        player.play()
    }
}

//MARK: - Method
extension DetailVC{
    func setUI() {
        print("Details : \(modelPuzzleDetails.catId ?? 0),\(modelPuzzleDetails.catName ?? "")")
        setData()
        ViewSoundPlay.isHidden = getInt(key: PUZZEL_USING_IMAGE_OR_SOUND) == 0 ? modelPuzzleDetails.catSound==nil ? true : false : true
        btnSpeakHint.isSelected = getInt(key: SPEAK_KEYWORD) == 1
        speechSynthesizer.delegate = self
        generateRandomAlpha()
        if let sound = modelPuzzleDetails.catSound,let url = URL(string: sound){
            let playerItem = CachingPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player.automaticallyWaitsToMinimizeStalling = false
        }
        collectionViewRandomAlpha.register(UINib(nibName: "DetailNameCell", bundle: nil), forCellWithReuseIdentifier: "DetailNameCell")
        let flowLayout = UICollectionViewFlowLayout()
        if UIScreen.main.bounds.height >= 650{
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.minimumLineSpacing = 10
        }else{
            flowLayout.minimumInteritemSpacing = 5
            flowLayout.minimumLineSpacing = 5
        }
        flowLayout.scrollDirection = .vertical
        collectionViewRandomAlpha.collectionViewLayout = flowLayout
        collectionViewRandomAlpha.delegate = self
        collectionViewRandomAlpha.dataSource = self
        collectionViewRandomAlpha.reloadData()
        
        collectionViewAlphabet.register(UINib(nibName: "AlphabetCell", bundle: nil), forCellWithReuseIdentifier: "AlphabetCell")
        //collectionViewAlphabet.applyCornerRadius(10.0)
        let flowLayout1 = FlowLayout()
        if UIScreen.main.bounds.height >= 650{
            flowLayout1.minimumInteritemSpacing = 10
            flowLayout1.minimumLineSpacing = 10
        }else{
            flowLayout1.minimumInteritemSpacing = 5
            flowLayout1.minimumLineSpacing = 5
        }
        flowLayout1.scrollDirection = .vertical
        collectionViewAlphabet.collectionViewLayout = flowLayout1
        collectionViewAlphabet.delegate = self
        collectionViewAlphabet.dataSource = self
        collectionViewAlphabet.reloadData()
    }
    
    func getUtterance(_ speechString: String) -> AVSpeechUtterance {
      let utterance = AVSpeechUtterance(string: speechString)
//      utterance.voice = 8
//      utterance.rate =
//      utterance.pitchMultiplier =
//      utterance.volume =
//      utterance.preUtteranceDelay =
//      utterance.postUtteranceDelay =
        
      return utterance
    }
    
    func generateRandomAlpha() {
        let catname = modelPuzzleDetails.catName?.uppercased() ?? ""
        self.arrName = catname.map({ String($0) })
        
        let lowerName = modelPuzzleDetails.catName?.lowercased() ?? ""
        self.arrTextSpeech = lowerName.map({ String($0) })
        
        self.arrName = self.arrName.shuffled()
        self.arrRandomAlpha.removeAll()
        let count = 15 - catname.count
        
        let strRandom = randomString(length: count,word: catname)
        
        let strFinal = strRandom + catname
        
        var a = Array(strFinal)
        a.shuffle()
        let shuffledWord = String(a)
        let b = Array(shuffledWord)
        for c in b {
            self.arrRandomAlpha.append(String(c))
        }
        
        for i in 0..<arrName.count {
            arrName[i] = ""
        }
        
        print("arrname = \(arrName)")
    }
    
    func setData(){
        self.imgObject.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imgObject.sd_setImage(with: URL(string: modelPuzzleDetails.catImage ?? ""), placeholderImage: UIImage(named: "ic_homeIcon1"), options: .highPriority, context: nil)
        lblTitle.text = "\(modelPuzzleDetails.catId ?? 0)/\(totalCount)"
        //lblCoinNumbers.font = UIFont(name: FONT_JANDACLOSER_BLACK, size: 18.0)
    }
    
    //RANDOM ALPHABET
    func randomizeAvailableLetters(tileArraySize: Int) -> Array<String> {
        
        var alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        for i in 0..<self.arrName.count{
            alphabet.removeAll(where: {$0 == self.arrName[i]})
        }
        
        var availableTiles = [String]()
        for _ in 0..<tileArraySize {
            let rand = Int(arc4random_uniform(UInt32(26 - self.arrName.count)))
            availableTiles.append(alphabet[rand])
        }
        return(availableTiles)
    }
    
    func randomString(length: Int,word:String) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var s = ""
        
        var i = 0
        
        while (i < length) {
            let c = letters.randomElement()!
            print(c)
            if !s.contains(c) && !word.contains(c) {
                s.append(c)
                i = i + 1
            }
        }
        
        print(s)
        return s
    }
    
    func noCoinVCPresent(){
        let vc = mainStoryboard.instantiateViewController(withIdentifier: String(describing: NoCoinVC.self)) as! NoCoinVC
        vc.modalPresentationStyle = .overFullScreen
        vc.completionHandler = {
            self.rewardAddAds()
        }
        appDelegate.window?.visibleViewController?.present(vc, animated: true, completion: nil)
    }
    
    func interstitialAddAds(){
  
    }
    
    func rewardAddAds(){
   
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
            if let ad = rewardedAd {
              ad.present(fromRootViewController: self) {
                  let reward = ad.adReward
                  print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
                  // TODO: Reward the user.
                  let coin = (getInt(key: USER_COIN) ?? 0) + 10
                  setInt(value: coin, key: USER_COIN)
                  self.lblTotalCoin.text = "\(getInt(key: USER_COIN) ?? 0)"
              }
            } else {
              print("Ad wasn't ready")
            }
        case .AppOpen:
            break;
        }
        
    }
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension DetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewAlphabet{
            //IF THIS CHANGE THEN let totalCellWidth = 60 * 3 and let totalSpacingWidth =  5 * 3 also change in insetForSectionAt method
//            return 15
            return self.arrName.count
        }
        return self.arrRandomAlpha.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewAlphabet{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlphabetCell", for: indexPath) as! AlphabetCell
            
            let text = self.arrName[indexPath.row].capitalized
            cell.viewMain.backgroundColor = UIColor(red:44/255, green:44/255, blue:44/255, alpha:0.5)
            if (text == ""){
                cell.lblAlphabet.isHidden = true
            }else{
                cell.lblAlphabet.isHidden = false
                cell.lblAlphabet.text = text
            }
           
            cell.viewMain.applyCornerRadius(10.0)
            
            if isWrongName == "1"{
                arrTemp.removeAll()
                cell.viewMain.backgroundColor = .red
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if indexPath.row == (self.arrName.endIndex - 1){
                        self.isWrongName = "0"
                        self.arrRandomAlpha.removeAll()
                        let catname = self.modelPuzzleDetails.catName?.uppercased() ?? ""
                        let count = 15 - catname.count
                        
                        let strRandom = self.randomString(length: count,word: catname)

                        let strFinal = strRandom + catname

                        var a = Array(strFinal)
                        a.shuffle()
                        let shuffledWord = String(a)
                        let b = Array(shuffledWord)
                        for c in b {
                            self.arrRandomAlpha.append(String(c))
                        }
                        for i in 0..<self.arrName.count {
                            self.arrName[i] = ""
                        }
                        self.collectionViewAlphabet.reloadData()
                        self.collectionViewRandomAlpha.reloadData()
                    }
                }
            }else if isWrongName == "2"{
                cell.viewMain.backgroundColor = .green
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let index = appDelegate.arrPuzzleData.firstIndex(of: self.puzzleModel) ?? 0
                if self.isHintButtonPressed{
                    cell.viewMain.backgroundColor = .green
                    if indexPath.row == (self.arrName.endIndex - 1){
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CongratulationVC") as! CongratulationVC
                        vc.modelPuzzleDetails = self.modelPuzzleDetails
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.isHintUsed = true
                        self.arrPuzzleStageData[self.puzzleStageIndex].isPuzzleUnlock = true
                        self.modelPuzzleDetails.isCurrentPuzzleSolved = true
                        self.arrPuzzleStageData[self.currentPuzzleStageIndex] = self.modelPuzzleDetails
                        appDelegate.arrPuzzleData[index].data = self.arrPuzzleStageData
                        setPuzzleDataObject(value: self.arrPuzzleStageData, key: "\(ARRAY_PUZZLE_STAGES)_ID_\(appDelegate.arrPuzzleData[index].id ?? 0)")
                        print("\(ARRAY_PUZZLE_STAGES)_ID_\(appDelegate.arrPuzzleData[index].id ?? 0) clear")
                        vc.isQuitPressed = { press in
                            self.lblTotalCoin.text = "\(getInt(key: USER_COIN) ?? 0)"
                            self.arrTemp.removeAll()
                            if press == "1"{
                                self.isBackPressed?(true)
                                self.navigationController?.popViewController(animated: true)
                            }else if press == "2"{
                                self.isHintButtonPressed = false
                                if self.currentPuzzleStageIndex == (self.arrPuzzleStageData.endIndex - 1){
                                    self.isBackPressed?(true)
                                    self.navigationController?.popViewController(animated: true)
                                }else{
                                    self.currentPuzzleStageIndex = self.currentPuzzleStageIndex + 1
                                }
                                
                                if self.puzzleStageIndex == (self.arrPuzzleStageData.endIndex - 1){}else{
                                    self.puzzleStageIndex = self.puzzleStageIndex + 1
                                }
                                
                                self.modelPuzzleDetails = self.arrPuzzleStageData[self.currentPuzzleStageIndex]
                                self.isWrongName = ""
                                self.puzzleTitle = ""
                                print("Details : \(self.modelPuzzleDetails.catId ?? 0),\(self.modelPuzzleDetails.catName ?? "")")
                                self.setData()
                                self.generateRandomAlpha()
                                
                                self.collectionViewAlphabet.reloadData()
                                self.collectionViewRandomAlpha.reloadData()
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                }
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailNameCell", for: indexPath) as! DetailNameCell
        
        let model = arrRandomAlpha[indexPath.row]
        
        if model == ""{
            cell.viewMain.isHidden = true
        }else{
            cell.viewMain.isHidden = false
        }
        print("cell.frame.heigh :- ",cell.frame.height)
        cell.imageBack.applyCornerRadius(cell.frame.height/6)
        cell.lblAplhabet.text = model

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == self.collectionViewAlphabet{
            if UIScreen.main.bounds.height >= 650{
                return CGSize(width: ((self.collectionViewRandomAlpha.width / 5) - 10) , height: UIScreen.main.bounds.height*(self.arrName.count>10 ? 0.075 : self.arrName.count>5 ? 0.08 : 0.09 ))
            }
            else{
                return CGSize(width: ((self.collectionViewRandomAlpha.width / 5) - 5) , height: UIScreen.main.bounds.height*(self.arrName.count>10 ? 0.08 : self.arrName.count>5 ? 0.08 : 0.09 ))
            }
        }
        else{
            if UIScreen.main.bounds.height >= 650{
                return CGSize(width: ((self.collectionViewRandomAlpha.width / 5) - 10) , height: UIScreen.main.bounds.height*(self.arrName.count>10 ? 0.075 : self.arrName.count>5 ? 0.08 : 0.09 ))
            }
            else{
                return CGSize(width: ((self.collectionViewRandomAlpha.width / 5) - 5) , height: UIScreen.main.bounds.height*(self.arrName.count>10 ? 0.07 : self.arrName.count>5 ? 0.08 : 0.09 ))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewRandomAlpha{
            self.isWordSlectThenHintPress = true
            let model = self.arrRandomAlpha[indexPath.row]
            
            if let j = arrName.firstIndex(of: "") {
                if getInt(key: SPEAK_KEYWORD) == 0{
                    speechSynthesizer.stopSpeaking(at: .word)
                    print(self.arrTextSpeech.joined())
                    speechSynthesizer.speak(getUtterance(model.map{$0.lowercased()}.joined()))
                }
                arrName[j] = model
            }
            
            arrTemp.append(model)
            
            puzzleTitle = arrTemp.joined(separator: "").lowercased()
            
            self.collectionViewAlphabet.reloadData()
            self.arrRandomAlpha[indexPath.row] = ""
            self.collectionViewRandomAlpha.reloadData()
            
            if arrName.last != ""{
                let index = appDelegate.arrPuzzleData.firstIndex(of: self.puzzleModel) ?? 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if self.puzzleTitle == self.modelPuzzleDetails.catName{
                        print("Same Name")
                        self.isWrongName = "2"
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CongratulationVC") as! CongratulationVC
                        vc.modelPuzzleDetails = self.modelPuzzleDetails
                        vc.vc = self
                        if self.pressedHint{
                            vc.isHintUsed = true
                            self.pressedHint = false
                        }
                        self.arrPuzzleStageData[self.puzzleStageIndex].isPuzzleUnlock = true
                        self.modelPuzzleDetails.isCurrentPuzzleSolved = true
                        self.arrPuzzleStageData[self.currentPuzzleStageIndex] = self.modelPuzzleDetails
                        
                        appDelegate.arrPuzzleData[index].data = self.arrPuzzleStageData
                        setPuzzleDataObject(value: self.arrPuzzleStageData, key: "\(ARRAY_PUZZLE_STAGES)_ID_\(appDelegate.arrPuzzleData[index].id ?? 0)")
                        print("\(ARRAY_PUZZLE_STAGES)_ID_\(appDelegate.arrPuzzleData[index].id ?? 0) clear")
//                        let arr = getPuzzleDataObject(key: "\(ARRAY_PUZZLE_STAGES)_ID_\(self.puzzleID)")
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.isQuitPressed = { press in
                            self.lblTotalCoin.text = "\(getInt(key: USER_COIN) ?? 0)"
                            self.arrTemp.removeAll()
                            if press == "1"{
                                self.isBackPressed?(true)
                                self.navigationController?.popViewController(animated: true)
                            }else if press == "2"{
                                if self.currentPuzzleStageIndex == (self.arrPuzzleStageData.endIndex - 1){
                                    self.isBackPressed?(true)
                                    self.navigationController?.popViewController(animated: true)
                                }else{
                                    self.currentPuzzleStageIndex = self.currentPuzzleStageIndex + 1
                                }
                                
                                if self.puzzleStageIndex == (self.arrPuzzleStageData.endIndex - 1){
                                    
                                }else{
                                    self.puzzleStageIndex = self.puzzleStageIndex + 1
                                }
                                
                                self.modelPuzzleDetails = self.arrPuzzleStageData[self.currentPuzzleStageIndex]
                                self.isWrongName = ""
                                self.puzzleTitle = ""
                                print("Details : \(self.modelPuzzleDetails.catId ?? 0),\(self.modelPuzzleDetails.catName ?? "")")
                                self.setData()
                                self.generateRandomAlpha()
                                
                                self.collectionViewAlphabet.reloadData()
                                self.collectionViewRandomAlpha.reloadData()
                            }
                        }
                        self.collectionViewAlphabet.reloadData()
//                        self.lblTotalCoin.text = "\(getInt(key: USER_COIN) ?? 0)"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                    else{
                        if let isupgrade = getInt(key: isUpgradePlan), isupgrade == 1{
                        }else{
                            if(appDelegate.modelConfig.isShowiOSAds){
                                let adsPresentCount = getInt(key: ADS_FAIL_COUNT) ?? 1
                                print("Ads present Fail Count :- ",adsPresentCount)
                                if adsPresentCount == appDelegate.modelConfig.adsPresentCount{
                                    setInt(value: 1, key: ADS_FAIL_COUNT)
                                    self.interstitialAddAds()
                                }else{
                                    setInt(value: adsPresentCount + 1, key: ADS_FAIL_COUNT)
                                }
                            }
                        }
                        self.isWrongName = "1"
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        self.collectionViewAlphabet.reloadData()
                        print("Wrong Name")
                    }
                }
            }
        }
    }
}

//MARK: - Session 3 --- AVSpeechSynthesizerDelegate: 6 Speech callbacks
extension DetailVC: AVSpeechSynthesizerDelegate {
// func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) { }
// func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) { }
// func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) { }
// func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {}
// func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) { }
// func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) { }
}

//MARK: - Class FlowLayout
class FlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        // Copy each item to prevent "UICollectionViewFlowLayout has cached frame mismatch" warning
        guard let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
        
        // Constants
        let leftPadding: CGFloat = 8
        let interItemSpacing = minimumInteritemSpacing
        
        // Tracking values
        var leftMargin: CGFloat = leftPadding // Modified to determine origin.x for each item
        var maxY: CGFloat = -1.0 // Modified to determine origin.y for each item
        var rowSizes: [[CGFloat]] = [] // Tracks the starting and ending x-values for the first and last item in the row
        var currentRow: Int = 0 // Tracks the current row
        attributes.forEach { layoutAttribute in
            
            // Each layoutAttribute represents its own item
            if layoutAttribute.frame.origin.y >= maxY {
                
                // This layoutAttribute represents the left-most item in the row
                leftMargin = leftPadding
                
                // Register its origin.x in rowSizes for use later
                if rowSizes.count == 0 {
                    // Add to first row
                    rowSizes = [[leftMargin, 0]]
                } else {
                    // Append a new row
                    rowSizes.append([leftMargin, 0])
                    currentRow += 1
                }
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
            
            // Add right-most x value for last item in the row
            rowSizes[currentRow][1] = leftMargin - interItemSpacing
        }
        
        // At this point, all cells are left aligned
        // Reset tracking values and add extra left padding to center align entire row
        leftMargin = leftPadding
        maxY = -1.0
        currentRow = 0
        attributes.forEach { layoutAttribute in
            
            // Each layoutAttribute is its own item
            if layoutAttribute.frame.origin.y >= maxY {
                
                // This layoutAttribute represents the left-most item in the row
                leftMargin = leftPadding
                
                // Need to bump it up by an appended margin
                let rowWidth = rowSizes[currentRow][1] - rowSizes[currentRow][0] // last.x - first.x
                let appendedMargin = (collectionView!.frame.width - leftPadding  - rowWidth - leftPadding) / 2
                leftMargin += appendedMargin
                
                currentRow += 1
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}

//MARK: - Google Ads fullScreenContentDelegate Method
extension DetailVC:GADFullScreenContentDelegate{
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad will present full screen content.
      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//          let reward = ad
//          print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
//          // TODO: Reward the user.
//            let coin = (getInt(key: USER_COIN) ?? 0) + 10
//            setInt(value: coin, key: USER_COIN)
//            self.lblTotalCoin.text = "\(getInt(key: USER_COIN) ?? 0)"
        print("Ad will present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
      }
}
