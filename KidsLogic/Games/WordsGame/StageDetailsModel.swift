//
//  StageDetailsModel.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 12/05/22.
//

import UIKit

class StageDetailsModel: NSObject {
    var itemName = ""
    var numbers = ""
    var itemImage = ""
    var arrName = [String]()
    
    init(itemName:String,itemImage:String,numbers:String,arrName:[String]) {
        self.itemName = itemName
        self.numbers = numbers
        self.itemImage = itemImage
        self.arrName = arrName
    }
}
