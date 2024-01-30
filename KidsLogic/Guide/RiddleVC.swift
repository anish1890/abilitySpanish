//
//  ArticlesVC.swift
//  AbilityToHelp
//
//  Created by Anish on 1/28/24.
//

import UIKit
import Alamofire
import KRProgressHUD

class RiddleVC: UIViewController {

    @IBOutlet weak var riddle: UILabel!
    @IBOutlet weak var answer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.answer.isHidden = true
        // Do any additional setup after loading the view.
        getArticles()
    }
    @IBAction func showAnswer(_ sender: Any) {
        self.answer.isHidden = false
    }
    
    
    func getArticles(){
        KRProgressHUD.show()
        let headers:HTTPHeaders = [
            "X-RapidAPI-Key": "b42a85a811msh4e571f6b5d07e65p102209jsneb74d08ea20f",
            "X-RapidAPI-Host": "riddlie.p.rapidapi.com"
        ]

        let url = "https://riddlie.p.rapidapi.com/api/v1/riddles/random"

        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value),
                       let riddle = try? JSONDecoder().decode(Riddle.self, from: jsonData) {
                        print("Decoded Riddle:")
                        print("Riddle: \(riddle.riddle)")
                        print("Answer: \(riddle.answer)")
                        print("UpVotes: \(riddle.upVotes)")
                        print("Difficulty Level: \(riddle.difficultyLevel)")
                        print("Posted By: \(riddle.postedBy)")
                        self.riddle.text = riddle.riddle
                        self.answer.text = riddle.answer
                        
                    } else {
                        print("Error decoding JSON")
                    }
                    KRProgressHUD.dismiss()
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    KRProgressHUD.dismiss()
                }
            }
    }

}

struct Riddle : Codable {
    
let riddle:String
let answer:String
let upVotes:Int
let difficultyLevel:String
let postedBy:String
    
}
