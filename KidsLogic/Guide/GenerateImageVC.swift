//
//  GenerateImageVC.swift
//  AbilityToHelp
//
//  Created by Anish on 1/28/24.
//

import UIKit
import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

class GenerateImageVC: UIViewController {

    @IBOutlet weak var wordField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var myImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func searchThis(_ sender: Any) {
        if wordField.text == "" {
            simpleAlert("Enter word")
        }else {
            getArticles(word:self.wordField.text!)
        }
    }
    
    func getArticles(word:String){
        KRProgressHUD.show()
        let headers:HTTPHeaders = [
            "X-RapidAPI-Key": "b42a85a811msh4e571f6b5d07e65p102209jsneb74d08ea20f",
            "X-RapidAPI-Host": "edupix.p.rapidapi.com"
        ]

        let url = "https://edupix.p.rapidapi.com/science/\(word)"

        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value),
                       let riddle = try? JSONDecoder().decode(TextImage.self, from: jsonData) {
                        self.myImages.removeAll()
                        self.myImages = riddle.images
                        self.collectionView.reloadData()
                        print("Decoded Riddle:")
                        KRProgressHUD.dismiss()
                    } else {
                        print("Error decoding JSON")
                        KRProgressHUD.dismiss()
                    }
                   
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    KRProgressHUD.dismiss()
                }
            }
    }
}
extension GenerateImageVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TextImageCell
        if let url = URL(string: self.myImages[indexPath.row]) {
            cell.txtImg.sd_setImage(with: url)
        }
        return cell
    }
    
    
}
class TextImageCell : UICollectionViewCell {
    
    @IBOutlet weak var txtImg : UIImageView!
    
}




struct TextImage : Codable {
    let query:String
let resultCount:Int
let images: [String]
}
