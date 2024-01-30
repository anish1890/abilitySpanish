//
//  GptViewController.swift
//  AbilityToHelp
//
//  Created by MAC  on 30/01/2024.
//

import UIKit
import SwiftyJSON
import Alamofire

class GptViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchText: UITextField!
    var chat = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func submitTapped(_ sender: Any) {
        self.makeAlamofireRequest(self.searchText.text ?? "")
    }

}
extension GptViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! cellGpt
        let data = chat[indexPath.row]
        cell.textlbl.text = data
        return cell
    }
}
extension GptViewController {
    func makeAlamofireRequest(_ prompt: String) {
        let apiKey = "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"
            let urlString = "https://api.openai.com/v1/completions"
            
            // Set headers with authorization
            let headers: HTTPHeaders = ["Authorization": "Bearer \(apiKey)", "Content-Type": "application/json"]

            // JSON Body
            let jsonBody: [String: Any] = [
                "prompt": prompt,
                "model": "gpt-3.5-turbo-instruct",
                "max_tokens": 100,
                "temperature": 0
            ]

            // Make the request using Alamofire
            AF.request(urlString, method: .post, parameters: jsonBody, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Response JSON: \(value)")
                    do {
                        let json = JSON(value)  // Assuming value is a JSON object, not NSData

                        // Now you can access the properties using SwiftyJSON
                        let id = json["id"].stringValue
                        let text = json["choices"][0]["text"].stringValue

                        self.chat.append(text)
                        print("ID: \(id)")
                        self.searchText.text = ""
                        print("Text: \(text)")
                        self.tableView.reloadData()
                        // Access other properties as needed
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                    
                    
                    // Handle the JSON response as needed
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
}
