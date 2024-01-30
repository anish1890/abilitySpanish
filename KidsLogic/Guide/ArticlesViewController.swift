//
//  ArticlesViewController.swift
//  AbilityToHelp
//
//  Created by Anish on 1/28/24.
//

import UIKit
import WebKit

class ArticlesViewController: UIViewController {

    @IBOutlet weak var webPageView: WKWebView!
    var selectedTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWebPage()
      
    }
    

    func loadWebPage() {
            var urlString: URL?

            switch selectedTag {
            case 2:
                urlString = Bundle.main.url(forResource: "autism", withExtension: "html")
            case 3:
                urlString = Bundle.main.url(forResource: "behaviors", withExtension: "html")
            case 4:
                urlString = Bundle.main.url(forResource: "learning delay", withExtension: "html")
            case 5:
                urlString = Bundle.main.url(forResource: "speechdelay", withExtension: "html")
            case 6:
                urlString = Bundle.main.url(forResource: "ODD", withExtension: "html")
            case 7:
                urlString = Bundle.main.url(forResource: "tou", withExtension: "html")
            default:
                // Load a default URL or handle other cases as needed
                break
            }

            if let url = urlString {
                let request = URLRequest(url: url)
                webPageView.load(request)
            }
        }

}
