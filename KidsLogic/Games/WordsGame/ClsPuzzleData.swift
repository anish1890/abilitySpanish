//
//	ClsPuzzleData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ClsPuzzleData : Codable{
    
    var catId : Int?
    var catImage : String?
    var catName : String?
    var isPuzzleUnlock = false
    var isCurrentPuzzleSolved = false
    var catSound : String?
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        catId = dictionary["cat_id"] as? Int
        catImage = dictionary["cat_image"] as? String
        catName = dictionary["cat_name"] as? String
        catSound = dictionary["cat_sound"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if catId != nil{
            dictionary["cat_id"] = catId
        }
        if catImage != nil{
            dictionary["cat_image"] = catImage
        }
        if catName != nil{
            dictionary["cat_name"] = catName
        }
        if catSound != nil{
            dictionary["cat_sound"] = catSound
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        catId = aDecoder.decodeObject(forKey: "cat_id") as? Int
        catImage = aDecoder.decodeObject(forKey: "cat_image") as? String
        catName = aDecoder.decodeObject(forKey: "cat_name") as? String
        catSound = aDecoder.decodeObject(forKey: "cat_sound") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if catId != nil{
            aCoder.encode(catId, forKey: "cat_id")
        }
        if catImage != nil{
            aCoder.encode(catImage, forKey: "cat_image")
        }
        if catName != nil{
            aCoder.encode(catName, forKey: "cat_name")
        }
        if catSound != nil{
            aCoder.encode(catSound, forKey: "cat_sound")
        }
    }
}
