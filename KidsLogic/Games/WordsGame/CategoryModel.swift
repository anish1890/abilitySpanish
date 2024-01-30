//
//  CategoryModel.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 06/05/22.
//

import UIKit

class CategoryModel: NSObject {
    var itemName = ""
    var itemImage = ""
    var stageDetails = [StageDetailsModel]()
    
    init(itemName:String,itemImage:String,stageDetails:[StageDetailsModel]) {
        self.itemName = itemName
        self.itemImage = itemImage
        self.stageDetails = stageDetails
    }
}
