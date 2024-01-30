//
//	ClsPuzzleModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ClsPuzzleModel : NSObject, NSCoding,Codable{

	var data : [ClsPuzzleData]!
	var id : Int?
	var image : String?
	var name : String?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		data = [ClsPuzzleData]()
		if let dataArray = dictionary["data"] as? [[String:Any]]{
			for dic in dataArray{
				let value = ClsPuzzleData(fromDictionary: dic)
				data.append(value)
			}
		}
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		name = dictionary["name"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			var dictionaryElements = [[String:Any]]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if name != nil{
			dictionary["name"] = name
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey :"data") as? [ClsPuzzleData]
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}
