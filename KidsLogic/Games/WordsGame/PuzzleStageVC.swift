//
//  PuzzleStageVC.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 07/05/22.
//

import UIKit
import GoogleMobileAds

class PuzzleStageVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var lblCoinNumbers: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionViewStages: UICollectionView!
    @IBOutlet weak var imgBottomIcon: UIImageView!
    
    //MARK: - Properties
    var puzzleModel = ClsPuzzleModel(fromDictionary: [:])
    var arrPuzzleDta = [ClsPuzzleData]()
    
    
    //MARK: - viewController Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let index = appDelegate.arrPuzzleData.firstIndex(of: puzzleModel)
        arrPuzzleDta = appDelegate.arrPuzzleData[index ?? 0].data
        collectionViewStages.reloadData()
        lblCoinNumbers.text = "\(getInt(key: USER_COIN) ?? 0)"
    }
}

//MARK: - Method
extension PuzzleStageVC{
    func setUI() {
        lblTitle.text = puzzleModel.name
        lblCoinNumbers.font = UIFont(name: FONT_JANDACLOSER_BLACK, size: 18.0)
        collectionViewStages.register(UINib(nibName: "StageCell", bundle: nil), forCellWithReuseIdentifier: "StageCell")
//        collectionViewStages.applyCornerRadius(16.0)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.scrollDirection = .vertical
        collectionViewStages.collectionViewLayout = flowLayout
        collectionViewStages.delegate = self
        collectionViewStages.dataSource = self
    }
}

//MARK: - ACTION
extension PuzzleStageVC{
    @IBAction func btnBackPopAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension PuzzleStageVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPuzzleDta.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCell", for: indexPath) as! StageCell
        
        let model = arrPuzzleDta[indexPath.row]
        print("index of \(indexPath.row) model.isPuzzleUnlock", model.isPuzzleUnlock)
        print("index of \(indexPath.row) model.isCurrentPuzzleSolved",model.isCurrentPuzzleSolved)
        if model.isPuzzleUnlock && model.isCurrentPuzzleSolved{
            cell.lblStageNumber.textColor = .white
            cell.imgLock.isHidden = true
            cell.imgStageOpen.isHidden = true
        }else if model.isPuzzleUnlock && !model.isCurrentPuzzleSolved{
            cell.lblStageNumber.textColor = UIColor(named: "TEXT_COLOR") ?? .white
            cell.imgLock.isHidden = true
            cell.imgStageOpen.isHidden = false
        }else if !model.isPuzzleUnlock && model.isCurrentPuzzleSolved{
            cell.lblStageNumber.textColor = .white
            cell.imgLock.isHidden = true
            cell.imgStageOpen.isHidden = true
        }else{
            if (indexPath.row == 0){
                cell.lblStageNumber.textColor = UIColor(named: "TEXT_COLOR") ?? .white
                cell.imgLock.isHidden = true
                cell.imgStageOpen.isHidden = false
            }else{
                cell.lblStageNumber.textColor = UIColor(named: "TEXT_COLOR") ?? .white
                cell.imgLock.isHidden = false
                cell.imgStageOpen.isHidden = false
            }
        }
        
        cell.lblStageNumber.text = "\(model.catId ?? 0)"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: ((self.collectionViewStages.width / 3) - 5) , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = arrPuzzleDta[indexPath.row]
        
        if (indexPath.row == 0){
            if model.isCurrentPuzzleSolved{
                return
            }else{
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
                DispatchQueue.main.async {
                    self.imgBottomIcon.frame.origin.y += 120
                }
                
                if indexPath.row == (arrPuzzleDta.endIndex - 1){
                    vc.puzzleStageIndex = indexPath.row
                }else{
                    vc.puzzleStageIndex = indexPath.row + 1
                }
                vc.modelPuzzleDetails = model
                vc.currentPuzzleStageIndex = indexPath.row
                vc.arrPuzzleStageData = arrPuzzleDta
                vc.puzzleModel = puzzleModel
                vc.puzzleID = puzzleModel.id ?? 0
                vc.totalCount = "\(arrPuzzleDta.count)"
                vc.isBackPressed = { press in
                    if press{
                        UIView.animate(withDuration: 0.3, animations: {
                            self.imgBottomIcon.frame.origin.y -= 120 /// go up
                        }) { _ in
                        }
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            if model.isCurrentPuzzleSolved || !model.isPuzzleUnlock{
                return
            }else{
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
                DispatchQueue.main.async {
                    self.imgBottomIcon.frame.origin.y += 120
                }
                
                if indexPath.row == (arrPuzzleDta.endIndex - 1){
                    vc.puzzleStageIndex = indexPath.row
                }else{
                    vc.puzzleStageIndex = indexPath.row + 1
                }
                vc.modelPuzzleDetails = model
                vc.currentPuzzleStageIndex = indexPath.row
                vc.puzzleID = puzzleModel.id ?? 0
                vc.arrPuzzleStageData = arrPuzzleDta
                vc.totalCount = "\(arrPuzzleDta.count)"
                vc.isBackPressed = { press in
                    if press{
                        UIView.animate(withDuration: 0.3, animations: {
                            self.imgBottomIcon.frame.origin.y -= 120 /// go up
                        }) { _ in
                        }
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
