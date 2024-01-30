//
//  GlobleConstants.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//

import Foundation
import UIKit

struct GlobleConstants {
    static let theAppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let DEVICE_TYPE = "iPhone"

    // Home screen (HomeVC) main category listing screen constant
    //static let HOME_TITEL_TEXT = Language.kLang("Kids Learning")

    static let MAIN_CAT_LEARN = "Kids Learning"
    static let MAIN_CAT_LOOK = "Look and Choose"
    static let MAIN_CAT_LISTEN = "Listen and Guess"
    static let MAIN_CAT_Vid = "Video Learning"

    static let CORRECT_ANS = "Correct Answer"
    static let WRONG_ANS = "Wrong Answer"
    static let PRE_SCHOOL_TITLE = "Pre school kids Learning"

    static let FAV_COLOR_WRONG = UIColor(red: 255/255.0, green: 38/255.0, blue: 0/255.0, alpha: 0.9)
    static let FAV_COLOR_CORRECT = UIColor(red: 0/255.0, green: 249/255.0, blue: 0/255.0, alpha: 0.9)
    static let FAV_COLOR_DEFAULT = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.9)
    static let is_ad_enable = "No"  //"Yes" for display ad and "No" for hide ad
    static let ad_type = "Google" //"Google" for google ad and "Facebook" for facebook ad

    // Google ad id
    static let google_banner_ad_id = "ca-app-pub-3940256099942544/2934735716"
    static let google_fullscreen_ad_id = "ca-app-pub-3940256099942544/4411468910"
    
    // Facebook ad id
    static let fb_banner_ad_id = "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID"
    static let fb_fullscreen_ad_id = "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID"
}

extension Array {
    func randomObject() -> Element? {
        let myCount = count
        if myCount > 0 {
            return self[Int(arc4random_uniform(UInt32(myCount)))]
        } else {
            return nil
        }
    }
}
