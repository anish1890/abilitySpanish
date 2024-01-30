//
//  VideoThumbListVC.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//



import UIKit
import FMDB
import SDWebImage

class VideoThumbListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CustomLayoutDelegate,UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var videoCatListCollectionView: UICollectionView!
    
    @IBOutlet weak var ad_height_constraint: NSLayoutConstraint!
    @IBOutlet weak var adContainer: UIView!
    
    var arrSelectedCategoryVideo: [[String: String]] = []
    var selectedVideoCat: Int = 0
    var columnCount: Int = 2
    var miniInteriorSpacing: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = GlobleConstants.MAIN_CAT_Vid

        let collectionNib = UINib(nibName: "VideolistCollectionViewCell", bundle: nil)
        videoCatListCollectionView.register(collectionNib, forCellWithReuseIdentifier: "VideolistCollectionViewCell")
        selectDataFromDB("\(selectedVideoCat)")
        columnCount = 2
        miniInteriorSpacing = 0

        if !(videoCatListCollectionView.collectionViewLayout is CustomLayout) {
            let layout = CustomLayout()
            layout.delegate = self
            layout.columnCount = columnCount
            videoCatListCollectionView.collectionViewLayout = layout
            videoCatListCollectionView.reloadData()
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSelectedCategoryVideo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideolistCollectionViewCell", for: indexPath) as! VideolistCollectionViewCell

        cell.imgVideoThumb.layer.cornerRadius = 10
        cell.videoView.layer.cornerRadius = 10

        let vidTitle = arrSelectedCategoryVideo[indexPath.row]["Title"] ?? ""
        cell.lblVideoTitle.text = vidTitle

        if let vidId = arrSelectedCategoryVideo[indexPath.row]["VideoId"],
           let youtubeURL = URL(string: "http://img.youtube.com/vi/\(vidId)/0.jpg") {
           
            cell.imgVideoThumb.sd_setImage(with: youtubeURL)
        }

        cell.videoView.clipsToBounds = true
        cell.imgVideoThumb.clipsToBounds = true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayVideoVC") as! PlayVideoVC
        vc.selectedVidId = arrSelectedCategoryVideo[indexPath.row]["VideoId"] ?? ""
        vc.getVideoArray = arrSelectedCategoryVideo
        vc.selectedVideoIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }

    func calculateHeightForLbl(text: String, width: CGFloat) -> CGFloat {
        let constraint = CGSize(width: width, height: 20000.0)
        let boundingBox = (text as NSString).boundingRect(with: constraint,
                                                          options: .usesLineFragmentOrigin,
                                                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)],
                                                          context: nil).size

        return boundingBox.height + (width * 77 / 150) + 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let vidTitle = arrSelectedCategoryVideo[indexPath.row]["Title"] else {
            return CGSize.zero
        }

        let sizeHeight = calculateHeightForLbl(text: vidTitle, width: videoCatListCollectionView.frame.size.width / 2.0)

        if UI_USER_INTERFACE_IDIOM() == .phone {
            return CGSize(width: videoCatListCollectionView.frame.size.width / 2.0, height: sizeHeight)
        } else {
            return CGSize(width: videoCatListCollectionView.frame.size.width / 2.0, height: sizeHeight + 30)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountForSection section: Int) -> Int {
        let numberOfColumns = 3
        return numberOfColumns
    }

    // MARK: - Helper Methods

    func selectDataFromDB(_ categoryId: String) {
        arrSelectedCategoryVideo = []

        let docPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = docPaths[0]
        let dbPath = (documentsDir as NSString).appendingPathComponent("preschool.db")

        let db = FMDatabase(path: dbPath)

        if db.open() {
            let query = "SELECT data FROM kids where id=\(categoryId)"
            print("Query: \(query), categoryId: \(categoryId)")
            if let result = db.executeQuery(query, withArgumentsIn: [categoryId]) {
                while result.next() {
                    if let dataString = result.string(forColumn: "data") {
                        let dataComponents = dataString.components(separatedBy: "#")
                        if dataComponents.count == 2 {
                            let videoId = dataComponents[0]
                            let title = dataComponents[1]
                            let dataDict: [String: String] = ["VideoId": videoId, "Title": title]
                            arrSelectedCategoryVideo.append(dataDict)
                        }
                    }
                }
                db.close()
            }
        }
    }
}
