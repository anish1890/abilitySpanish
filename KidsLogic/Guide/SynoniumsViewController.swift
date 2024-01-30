//
//  SynoniumsViewController.swift
//  AbilityToHelp
//
//  Created by Anish on 1/28/24.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

class SynoniumsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    

    @IBOutlet weak var wordField: UITextField!
    @IBOutlet weak var tableView : UITableView!
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! synoniumsCell
        cell.myLbl.text = myImages[indexPath.row]
        return cell
    }
    func getArticles(word:String){
        KRProgressHUD.show()
        let headers:HTTPHeaders = [
            "X-RapidAPI-Key": "b42a85a811msh4e571f6b5d07e65p102209jsneb74d08ea20f",
            "X-RapidAPI-Host": "synonyms-api.p.rapidapi.com"
        ]

        let url = "https://synonyms-api.p.rapidapi.com/synonym?word=\(word)"

        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value),
                       let riddle = try? JSONDecoder().decode(Synoniums.self, from: jsonData) {
                        print("Decoded Riddle:")
                        self.myImages.removeAll()
                        self.myImages = riddle.synonyms
                        self.tableView.reloadData()
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
class synoniumsCell : UITableViewCell {
    @IBOutlet weak var myLbl : UILabel!
}
struct Synoniums : Codable {
    let synonyms : [String]
}
