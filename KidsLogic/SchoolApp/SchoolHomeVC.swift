//
//  HomeVC.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//

import UIKit


class SchoolHomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var arrVideoList: [String] = []
    var arrMainCategoryImage: [String] = []
    var arrMainCategoryImageName: [String] = []
    var arrAlphabet: [String] = []
    var arrNumber: [String] = []
    var arrColor: [String] = []
    var arrShapes: [String] = []
    var arrAnimal: [String] = []
    var arrbirds: [String] = []
    var arrflower: [String] = []
    var arrfruit: [String] = []
    var arrMonth: [String] = []
    var arrVegetable: [String] = []
    var arrBodyParts: [String] = []
    var arrClothes: [String] = []
    var arrCountry: [String] = []
    var arrFood: [String] = []
    var arrGeometry: [String] = []
    var arrHouse: [String] = []
    var arrJobs: [String] = []
    var arrSchool: [String] = []
    var arrSports: [String] = []
    var arrVehicle: [String] = []

    @IBOutlet weak var mainCatListCollectionView: UICollectionView!
   
    @IBOutlet weak var ad_height_constraint: NSLayoutConstraint!
    @IBOutlet weak var adContainer: UIView!
   

    var selectedMainCat: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        mainCatListCollectionView.register(collectionNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")

        if selectedMainCat == 0 {
            title = GlobleConstants.MAIN_CAT_LEARN
        } else if selectedMainCat == 1 {
            title = GlobleConstants.MAIN_CAT_Vid
        } else if selectedMainCat == 2 {
            title = GlobleConstants.MAIN_CAT_LOOK
        } else if selectedMainCat == 3 {
            title = GlobleConstants.MAIN_CAT_LISTEN
        }
       arrMainCategoryImageName = ["Alphabets", "Number", "Color", "Shapes", "Animals", "Birds", "Flowers", "Fruits", "Month", "Vegetable", "Body parts", "Clothes", "Country", "Food", "Geometry", "House", "Jobs", "School", "Sports", "Vehicle"]
        
        arrMainCategoryImage = ["home_alphabet", "home_number", "home_color", "home_shape", "home_animal", "home_birds", "home_flower", "home_fruits", "home_month", "home_vegetable", "home_body_parts", "home_clothes", "home_country", "home_food", "home_geometry", "home_house", "home_jobs", "home_school", "home_sports", "home_vehicle"]

        arrVideoList = ["vt_abc", "vt_number", "vt_color", "vt_animal", "vt_shape", "vt_vehicle", "vt_fruit", "vt_vegetable", "vt_day", "vt_month", "vt_clothes"]

        arrAlphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

         arrNumber = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]

         arrColor = ["green", "pink", "red", "black", "aqua", "blue", "brown", "slate", "violet", "white", "yellow"]

         arrShapes = ["circle", "square", "decagon", "ellipse", "hexagon", "triangle", "octagon", "parallelogram", "pentagon", "rectangle", "rhombus", "right_triangle", "trapezoid"]

         arrAnimal = ["bear", "bison", "black_leopard", "cheetah", "chimpanzee", "chipmuck", "cougar", "deer", "elephant", "fox", "giraffe", "gorilla", "hedgehog", "hippopotamus", "hyena", "jackal", "jaguar", "kangaroo", "koala_bear", "lion", "meerkat", "mongoose", "monkey", "opossum", "otter", "panda", "polar_bear", "porcupine", "raccoon", "red_panda", "rhinoceros", "scimitar_oryx", "squirrel", "tiger", "wolf", "wombat", "zebra"]

         arrbirds = ["canary", "crow", "dove", "duck", "eagle", "hoopoe", "hornbill", "kingfisher", "kite", "lapwing", "mynah", "nightingale", "owl", "parrot", "peacock", "peahen", "pheasant", "pigeon", "puffin", "quail", "robin", "sparrow", "swallow", "toucan", "vulture", "wagtail", "waxwing", "woodpecker"]

         arrflower = ["arum_lily", "aster", "bird_of_paradise", "bougainvillea", "buttercup", "calendula", "canna", "cockscomb", "daffodils", "dahlia", "daisy", "dianthus", "gladiolus", "hibiscus", "jasmine", "lavender", "lilac", "lily", "lotus", "morning_glory", "nerium_oleander", "orchids", "peony", "periwinkle", "petunia", "poppy", "purple_mallow", "rose", "sunflower", "tulips"]

         arrfruit = ["apple", "apricot", "avocado", "blackberry", "blackcurrant", "blueberry", "cherry", "coconut", "fig", "grape", "kiwi", "lemon", "lime", "lychee", "mango", "nectarine", "orange", "papaya", "passion", "peach", "pear", "pineapple", "plum", "quince", "raspberry", "strawberry", "watermelon"]

         arrMonth = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]

         arrVegetable = ["asparagus", "broccoli", "brussels_sprouts", "carrot", "cauliflower", "cucumber", "eggplant", "garlic", "lettuce", "mint", "mushroom", "okra", "onion", "peaspeas", "potato", "radish", "red_cabbage", "spinach", "squash", "string_beans", "tomato", "turnip"]

         arrBodyParts = ["ankle", "arm", "chest", "ear", "elbow", "eye", "fingers", "foot", "hair", "knee", "leg", "lips", "mouth", "neck", "nose", "shoulder", "stomach", "thigh", "thumb", "toe"]

         arrClothes = ["shirt", "shoes", "pyjamas", "sock", "gloves", "skirt", "slipper", "sweater", "bathrobe", "jeans", "boot", "dress", "overalls", "shorts", "jacket", "scarf", "belt", "hat", "glasses", "suit"]

         arrCountry = ["argentina", "austria", "belgium", "brazil", "cambodia", "canada", "croatia", "cuba", "denmark", "england", "france", "germany", "greece", "indian", "indonesia", "italy", "japan", "laos", "malaysia", "mexico", "myanmar", "netherlands", "pakistan", "philippine", "portugal", "russia", "saudi_arabia", "singapore", "south_korea", "spain", "sweden", "thailand", "united_states", "vietnam"]

        arrFood = ["pizza", "biscuits", "chip", "cake", "noodles", "water", "sandwich", "ice_cream", "beer", "hamburger", "tea", "ham", "yogurt", "chocolate", "rice", "soda", "juice", "coffee", "bread", "soup", "butter", "cheese", "milk"]

        arrGeometry = ["arrow", "circle", "cone", "crescent", "cube", "cuboid", "cylinder", "diamond", "heart", "hexagon", "oval", "parallelogram", "pentagon", "pyramid", "rectangle", "sphere", "star", "trapezoid", "triangle"]

        arrHouse = ["bookcase", "chair", "newspaper", "sofasofa", "picture", "watch", "brush", "television", "table", "coin", "phone", "bar_stool", "laptop", "mirror", "scissors", "umbrella", "clock", "bucket", "cup", "key", "door", "glass", "armchair", "window", "knife", "wallet", "bottle", "mobile_phone", "bed", "lock"]

        arrJobs = ["accountant", "architect", "astronomer", "author", "baker", "bricklayer", "butcher", "carpenter", "chef", "cleaner", "dentist", "doctor", "driver", "dustman", "electrician", "engineer", "farmer", "firefighter", "florist", "gardener", "hairdresser", "journalist", "judge", "lawyer", "lecturer", "librarian", "lifeguard", "mechanics", "nurse", "optician", "painter", "pharmacist", "photographer", "pilot", "plumber", "receptionist", "scientist", "soldier", "student", "tailor", "traffic_warden", "veterinarian", "waiter", "welder"]

        arrSchool = ["board", "book", "chair", "compass", "computer", "desk", "dictionary", "eraser", "globe", "map", "notebook", "pen", "pencil", "ruler", "school_bag", "teacher"]

        arrSports = ["chess", "windsurfing", "bowling", "karate", "ice_skating", "table_tennis", "badminton", "swimming", "football", "hockey", "equestrian", "cycling", "diving", "judo", "golf", "baseball", "volleyball", "surfing", "skateboarding", "skiing", "archery", "canoeing", "running", "billiards", "fencing", "tennis", "basketball"]

         arrVehicle = ["ambulance", "bike", "boat", "bus", "car", "container_truck", "fire_truck", "helicopter", "motorbike", "plane", "police_car", "ship", "subway", "train", "truck"]


 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTitle()
    }

    func updateTitle() {
        switch selectedMainCat {
        case 0:
            title = GlobleConstants.MAIN_CAT_LEARN
        case 1:
            title = GlobleConstants.MAIN_CAT_Vid
        case 2:
            title = GlobleConstants.MAIN_CAT_LOOK
        case 3:
            title = GlobleConstants.MAIN_CAT_LISTEN
        default:
            break
        }
    }
  

    // MARK: - UICollectionViewDataSource

      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return selectedMainCat == 1 ? arrVideoList.count : arrMainCategoryImage.count
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
          
          
          cell.mainCatImg.isHidden = false
          cell.lblName.isHidden = false
          cell.catName.isHidden = true

          cell.mainCatImg.layer.cornerRadius = 12
          cell.mainCatView.layer.cornerRadius = 12
          if selectedMainCat != 1 {
              cell.catName.isHidden = false
              let Name = arrMainCategoryImageName[indexPath.row]
              cell.catName.text = Name
          }
        
          let imageName = selectedMainCat == 1 ? arrVideoList[indexPath.row] : arrMainCategoryImage[indexPath.row]
          cell.mainCatImg.image = UIImage(named: imageName)

          var finalCellFrame = cell.mainCatImg.frame
          let translation = collectionView.panGestureRecognizer.translation(in: collectionView.superview)
          if translation.x > 0 {
              finalCellFrame = CGRect(x: finalCellFrame.size.width / 2, y: finalCellFrame.size.height / 2, width: 0, height: 0)
          } else {
              finalCellFrame = CGRect(x: finalCellFrame.size.width / 2, y: finalCellFrame.size.height / 2, width: 0, height: 0)
          }

          UIView.animate(withDuration: 0.8) {
              cell.mainCatImg.frame = finalCellFrame
          }

          cell.mainCatImg.clipsToBounds = true
          cell.mainCatView.clipsToBounds = true

          return cell
      }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        title = "Back"
        
        if selectedMainCat == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SubCategoryLearnVC") as! SubCategoryLearnVC
            
            switch indexPath.row {
            case 0: vc.arrGetSubCatData = arrAlphabet
            case 1: vc.arrGetSubCatData = arrNumber
            case 2: vc.arrGetSubCatData = arrColor
            case 3: vc.arrGetSubCatData = arrShapes
            case 4: vc.arrGetSubCatData = arrAnimal
            case 5: vc.arrGetSubCatData = arrbirds
            case 6: vc.arrGetSubCatData = arrflower
            case 7: vc.arrGetSubCatData = arrfruit
            case 8: vc.arrGetSubCatData = arrMonth
            case 9: vc.arrGetSubCatData = arrVegetable
            case 10: vc.arrGetSubCatData = arrBodyParts
            case 11: vc.arrGetSubCatData = arrClothes
            case 12: vc.arrGetSubCatData = arrCountry
            case 13: vc.arrGetSubCatData = arrFood
            case 14: vc.arrGetSubCatData = arrGeometry
            case 15: vc.arrGetSubCatData = arrHouse
            case 16: vc.arrGetSubCatData = arrJobs
            case 17: vc.arrGetSubCatData = arrSchool
            case 18: vc.arrGetSubCatData = arrSports
            case 19: vc.arrGetSubCatData = arrVehicle
            default: break
            }
            
            vc.selectedSubCat = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
            
        } else if selectedMainCat == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "videoThumbListVC") as! VideoThumbListVC
            vc.selectedVideoCat = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
            
        } else if selectedMainCat == 2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "lookQuizVC") as! LookQuizVC
            vc.selectedSubCat = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
            
        } else if selectedMainCat == 3 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ListenQuizVC") as! ListenQuizVC
            vc.selectedSubCat = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }

      // MARK: - UICollectionViewDelegateFlowLayout

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = collectionView.frame.size.width / (UI_USER_INTERFACE_IDIOM() == .phone ? 2 : 4)
          return CGSize(width: width, height: width)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 0.0
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 0.0
      }


}
