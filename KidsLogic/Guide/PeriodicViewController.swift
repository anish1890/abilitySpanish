//
//  PeriodicViewController.swift
//  AbilityToHelp
//
//  Created by Anish on 1/28/24.
//

import UIKit
import Alamofire
import KRProgressHUD
class PeriodicViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var myPreodicTable = [Preodic]()
    let itemsPerRow: CGFloat = 4
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedData = retrieveFromUserDefaults() {
             // Data found in UserDefaults, use it
             self.myPreodicTable = savedData
             self.collectionView.reloadData()
         } else {
             // Data not found in UserDefaults, make the API request
             self.getArticles()
         }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPreodicTable.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PeriodicCell
        cell.myText.text = self.myPreodicTable[indexPath.row].symbol
        cell.name.text = self.myPreodicTable[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
         let availableWidth = collectionView.frame.width - paddingSpace
         let widthPerItem = availableWidth / itemsPerRow
         return CGSize(width: widthPerItem, height: widthPerItem) // Square cells
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return sectionInsets
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return sectionInsets.left
     }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.myPreodicTable[indexPath.row]
        print(data)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PeriodicDetail") as! PeriodicDetail
        vc.myPreodicTable = data
        navigationController?.pushViewController(vc, animated: true)
    }
    func getArticles(){
     KRProgressHUD.show()

        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": "b42a85a811msh4e571f6b5d07e65p102209jsneb74d08ea20f",
            "X-RapidAPI-Host": "periodictable.p.rapidapi.com"
        ]

        let url = "https://periodictable.p.rapidapi.com/"

        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseJSON { response in
               

                switch response.result {
                case .success(let value):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value),
                       let periodicTable = try? JSONDecoder().decode([Preodic].self, from: jsonData) {
                        self.saveToUserDefaults(periodicTable)
                        self.myPreodicTable = periodicTable
                        self.collectionView.reloadData()
                        KRProgressHUD.dismiss()
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
    // Save data to UserDefaults
     func saveToUserDefaults(_ periodicTable: [Preodic]) {
         do {
             let encodedData = try JSONEncoder().encode(periodicTable)
             UserDefaults.standard.set(encodedData, forKey: "myPreodicTableKey")
         } catch {
             print("Error encoding data: \(error)")
         }
     }

     // Retrieve data from UserDefaults
     func retrieveFromUserDefaults() -> [Preodic]? {
         if let encodedData = UserDefaults.standard.data(forKey: "myPreodicTableKey") {
             do {
                 let decodedData = try JSONDecoder().decode([Preodic].self, from: encodedData)
                 return decodedData
             } catch {
                 print("Error decoding data: \(error)")
                 return nil
             }
         }
         return nil
     }

}

class PeriodicCell : UICollectionViewCell {
    @IBOutlet weak var myText : UILabel!
    @IBOutlet weak var name : UILabel!
}

struct Preodic : Codable {
    
   
        let alloys, atomicMass, atomicNumber, atomicRadius: String?
        let block: String?
        let boilingPoint: String?
        let bondingType: String?
        let cpkHexColor, crystalStructure, density, electronAffinity: String?
        let electronegativity, electronicConfiguration, facts, group: String?
        let groupBlock, ionRadius, ionizationEnergy, isotopes: String?
        let magneticOrdering, meltingPoint, molarHeatCapacity, name: String?
        let oxidationStates, period, speedOfSound: String?
        let standardState: String?
        let symbol, vanDelWaalsRadius, yearDiscovered, minerals: String?
        let history: String?
    
}
