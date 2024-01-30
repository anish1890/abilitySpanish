//
//  AIEnums.swift
//  Swift3CodeStructure
//
//  Created by Ravi Alagiya on 25/11/2016.
//  Copyright © 2016 Ravi Alagiya. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

//MARK:- AIEdge
enum AIEdge:Int {
	case
	top,
	left,
	bottom,
	right,
	top_Left,
	top_Right,
	bottom_Left,
	bottom_Right,
	all,
	none
}

enum socialStatus {
    case facebook
    case apple
    case normal
    case gmail
}

enum dateFormatter:String {
    case dateFormate1 = "hh:mm a"
    case dateFormate2 = "hh:mm:ss"
    case dateFormate3 = "HH:mm:ss"
    case dateFormate4 = "dd MMM yyyy"
    case dateFormate5 = "dd MMM yyyy hh:mm a"
    case dateFormate6 = "yyyy-MM-dd"
}

enum AppStoreReviewManager {
  static func requestReviewIfAppropriate() {
      SKStoreReviewController.requestReview()
  }
}

