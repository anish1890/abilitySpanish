//
//  SubCategoryLearnVC.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//




import UIKit
import AVFoundation
import QuartzCore


class SubCatDetailsVC: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var btnPrevi: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var ad_height_constraint: NSLayoutConstraint!
    @IBOutlet weak var adContainer: UIView!

    var passArrDataSelected: [[String: Any]]?
    var selectedSubCatIndex: Int = 0
    var arrGetSubCatDetailsData: [Any] = []
    
    lazy var synthesizer: AVSpeechSynthesizer = {
        let synth = AVSpeechSynthesizer()
        synth.delegate = self
        return synth
    }()

   

    @IBAction func btn_click_Prev(_ sender: Any) {
        // Implement your action for the previous button
        synthesizer.stopSpeaking(at: .immediate)
        
        if selectedSubCatIndex > 0 {
            selectedSubCatIndex -= 1
            displaySelected(selectedSubCatIndex)
        } else {
            displaySelected(selectedSubCatIndex)
        }
    }

    @IBAction func btn_click_next(_ sender: Any) {
        synthesizer.stopSpeaking(at: .immediate)

         if selectedSubCatIndex < (arrGetSubCatDetailsData.count - 1) {
             selectedSubCatIndex += 1
             displaySelected(selectedSubCatIndex)
         } else {
             displaySelected(selectedSubCatIndex)
         }
    }

    @IBAction func btn_click_Replay(_ sender: Any) {
        // Implement your action for the replay button
        synthesizer.stopSpeaking(at: .immediate)
          displaySelected(selectedSubCatIndex)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

      
        if let Str_Title = (self.arrGetSubCatDetailsData[self.selectedSubCatIndex] as? [String: Any])?["Title"] as? String {
            lblName.text = Str_Title

            if UI_USER_INTERFACE_IDIOM() == .phone {
                lblName.font = UIFont.boldSystemFont(ofSize: 35)
            } else {
                lblName.font = UIFont.boldSystemFont(ofSize: 50)
            }
        }

        if let Str_ImageName = (self.arrGetSubCatDetailsData[self.selectedSubCatIndex] as? [String: Any])?["Image"] as? String {
            imgSelected.image = UIImage(named: Str_ImageName)
            imgSelected.layer.cornerRadius = 10
            imgSelected.clipsToBounds = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.displaySelected(self.selectedSubCatIndex)
        }


    }
    func displaySelected(_ indexVal: Int) {
        guard let title = (arrGetSubCatDetailsData[indexVal] as? [String: Any])?["Title"] as? String else {
            return
        }
        lblName.text = title
        
        if UI_USER_INTERFACE_IDIOM() == .phone {
            lblName.font = UIFont.boldSystemFont(ofSize: 35)
        } else {
            lblName.font = UIFont.boldSystemFont(ofSize: 50)
        }
        
        if let imageName = (arrGetSubCatDetailsData[indexVal] as? [String: Any])?["Image"] as? String {
            imgSelected.image = UIImage(named: imageName)
            imgSelected.layer.cornerRadius = 10
            imgSelected.clipsToBounds = true
        }
        
        let leftWobble = CGAffineTransform(rotationAngle: radians(15.0))
        let rightWobble = CGAffineTransform(rotationAngle: radians(0.0))
        
        imgSelected.transform = leftWobble
        
        UIView.animate(withDuration: 0.125, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.imgSelected.transform = rightWobble
        }, completion: nil)
        
        speakWord((arrGetSubCatDetailsData[indexVal] as? [String: Any])?["Desc_Data"] as? String)
        shakeView()
    }

    func radians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / 180)
    }

    func speakWord(_ word: String?) {
        if let word = word {
            GlobleConstants.theAppDelegate.speakWord(word)
        }
    }

    func shakeView() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: imgSelected.center.x - 5, y: imgSelected.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: imgSelected.center.x + 5, y: imgSelected.center.y))
        imgSelected.layer.add(shake, forKey: "position")
    }
   
    
    func alphabetDetailsArray() {
        self.passArrDataSelected = [
            ["Title": "Apple", "Image": "a", "Desc_Data": "A for Apple"],
            ["Title": "Ball", "Image": "b", "Desc_Data": "B for Ball"],
            ["Title": "Cat", "Image": "c", "Desc_Data": "C for Cat"],
            ["Title": "Dog", "Image": "d", "Desc_Data": "D for Dog"],
            ["Title": "Elephant", "Image": "e", "Desc_Data": "E for Elephant"],
            ["Title": "Fish", "Image": "f", "Desc_Data": "F for Fish"],
            ["Title": "Goat", "Image": "g", "Desc_Data": "G for Goat"],
            ["Title": "Horse", "Image": "h", "Desc_Data": "H for Horse"],
            ["Title": "Ice cream", "Image": "i", "Desc_Data": "I for Ice cream"],
            ["Title": "Joker", "Image": "j", "Desc_Data": "J for Joker"],
            ["Title": "Kite", "Image": "k", "Desc_Data": "K for Kite"],
            ["Title": "Lion", "Image": "l", "Desc_Data": "L for Lion"],
            ["Title": "Monkey", "Image": "m", "Desc_Data": "M for Monkey"],
            ["Title": "Nest", "Image": "n", "Desc_Data": "N for Nest"],
            ["Title": "Orange", "Image": "o", "Desc_Data": "O for Orange"],
            ["Title": "Parrot", "Image": "p", "Desc_Data": "P for Parrot"],
            ["Title": "Queen", "Image": "q", "Desc_Data": "Q for Queen"],
            ["Title": "Rabbit", "Image": "r", "Desc_Data": "R for Rabbit"],
            ["Title": "Sun", "Image": "s", "Desc_Data": "S for Sun"],
            ["Title": "Train", "Image": "t", "Desc_Data": "T for Train"],
            ["Title": "Umbrella", "Image": "u", "Desc_Data": "U for Umbrella"],
            ["Title": "Violin", "Image": "v", "Desc_Data": "V for Violin"],
            ["Title": "Watch", "Image": "w", "Desc_Data": "W for Watch"],
            ["Title": "Xylophone", "Image": "x", "Desc_Data": "X for Xylophone"],
            ["Title": "Yak", "Image": "y", "Desc_Data": "Y for Yak"],
            ["Title": "Zebra", "Image": "z", "Desc_Data": "Z for Zebra"]
        ]
    }
    func numberDetailsArray() {
        passArrDataSelected = [
            ["Title": "Zero", "Image": "0", "Desc_Data": "Zero"],
            ["Title": "One", "Image": "1", "Desc_Data": "One"],
            ["Title": "Two", "Image": "2", "Desc_Data": "Two"],
            ["Title": "Three", "Image": "3", "Desc_Data": "Three"],
            ["Title": "Four", "Image": "4", "Desc_Data": "Four"],
            ["Title": "Five", "Image": "5", "Desc_Data": "Five"],
            ["Title": "Six", "Image": "6", "Desc_Data": "Six"],
            ["Title": "Seven", "Image": "7", "Desc_Data": "Seven"],
            ["Title": "Eight", "Image": "8", "Desc_Data": "Eight"],
            ["Title": "Nine", "Image": "9", "Desc_Data": "Nine"],
            ["Title": "Ten", "Image": "10", "Desc_Data": "Ten"],
            ["Title": "Eleven", "Image": "11", "Desc_Data": "Eleven"],
            ["Title": "Twelve", "Image": "12", "Desc_Data": "Twelve"],
            ["Title": "Thirteen", "Image": "13", "Desc_Data": "Thirteen"],
            ["Title": "Fourteen", "Image": "14", "Desc_Data": "Fourteen"],
            ["Title": "Fifteen", "Image": "15", "Desc_Data": "Fifteen"],
            ["Title": "Sixteen", "Image": "16", "Desc_Data": "Sixteen"],
            ["Title": "Seventeen", "Image": "17", "Desc_Data": "Seventeen"],
            ["Title": "Eighteen", "Image": "18", "Desc_Data": "Eighteen"],
            ["Title": "Nineteen", "Image": "19", "Desc_Data": "Nineteen"],
            ["Title": "Twenty", "Image": "20", "Desc_Data": "Twenty"]
        ]
    }

    func colorDetailsArray() {
        passArrDataSelected = [
            ["Title": "Green", "Image": "green", "Desc_Data": "Green"],
            ["Title": "Pink", "Image": "pink", "Desc_Data": "Pink"],
            ["Title": "Red", "Image": "red", "Desc_Data": "Red"],
            ["Title": "Black", "Image": "black", "Desc_Data": "Black"],
            ["Title": "Aqua", "Image": "aqua", "Desc_Data": "Aqua"],
            ["Title": "Blue", "Image": "blue", "Desc_Data": "Blue"],
            ["Title": "Brown", "Image": "brown", "Desc_Data": "Brown"],
            ["Title": "Slate", "Image": "slate", "Desc_Data": "Slate"],
            ["Title": "Violet", "Image": "violet", "Desc_Data": "Violet"],
            ["Title": "White", "Image": "white", "Desc_Data": "White"],
            ["Title": "Yellow", "Image": "yellow", "Desc_Data": "Yellow"]
        ]
    }

    func shapesDetailsArray() {
        passArrDataSelected = [
            ["Title": "Circle", "Image": "circle", "Desc_Data": "Circle"],
            ["Title": "Square", "Image": "square", "Desc_Data": "Square"],
            ["Title": "Decagon", "Image": "decagon", "Desc_Data": "Decagon"],
            ["Title": "Ellipse", "Image": "ellipse", "Desc_Data": "Ellipse"],
            ["Title": "Hexagon", "Image": "hexagon", "Desc_Data": "Hexagon"],
            ["Title": "Triangle", "Image": "triangle", "Desc_Data": "Triangle"],
            ["Title": "Octagon", "Image": "octagon", "Desc_Data": "Octagon"],
            ["Title": "Parallelogram", "Image": "parallelogram", "Desc_Data": "Parallelogram"],
            ["Title": "Pentagon", "Image": "pentagon", "Desc_Data": "Pentagon"],
            ["Title": "Rectangle", "Image": "rectangle", "Desc_Data": "Rectangle"],
            ["Title": "Rhombus", "Image": "rhombus", "Desc_Data": "Rhombus"],
            ["Title": "Right Triangle", "Image": "right_triangle", "Desc_Data": "Right Triangle"],
            ["Title": "Trapezoid", "Image": "trapezoid", "Desc_Data": "Trapezoid"]
        ]
    }

    func animalDetailsArray() {
        passArrDataSelected = [
            ["Title": "Bear", "Image": "bear", "Desc_Data": "Bear"],
            ["Title": "Bison", "Image": "bison", "Desc_Data": "Bison"],
            ["Title": "Black Leopard", "Image": "black_leopard", "Desc_Data": "Black Leopard"],
            ["Title": "Cheetah", "Image": "cheetah", "Desc_Data": "Cheetah"],
            ["Title": "Chimpanzee", "Image": "chimpanzee", "Desc_Data": "Chimpanzee"],
            ["Title": "Chipmunk", "Image": "chipmunk", "Desc_Data": "Chipmunk"],
            ["Title": "Cougar", "Image": "cougar", "Desc_Data": "Cougar"],
            ["Title": "Deer", "Image": "deer", "Desc_Data": "Deer"],
            ["Title": "Elephant", "Image": "elephant", "Desc_Data": "Elephant"],
            ["Title": "Fox", "Image": "fox", "Desc_Data": "Fox"],
            ["Title": "Giraffe", "Image": "giraffe", "Desc_Data": "Giraffe"],
            ["Title": "Gorilla", "Image": "gorilla", "Desc_Data": "Gorilla"],
            ["Title": "Hedgehog", "Image": "hedgehog", "Desc_Data": "Hedgehog"],
            ["Title": "Hippopotamus", "Image": "hippopotamus", "Desc_Data": "Hippopotamus"],
            ["Title": "Hyena", "Image": "hyena", "Desc_Data": "Hyena"],
            ["Title": "Jackal", "Image": "jackal", "Desc_Data": "Jackal"],
            ["Title": "Jaguar", "Image": "jaguar", "Desc_Data": "Jaguar"],
            ["Title": "Kangaroo", "Image": "kangaroo", "Desc_Data": "Kangaroo"],
            ["Title": "Koala Bear", "Image": "koala_bear", "Desc_Data": "Koala Bear"],
            ["Title": "Lion", "Image": "lion", "Desc_Data": "Lion"],
            ["Title": "Meerkat", "Image": "meerkat", "Desc_Data": "Meerkat"],
            ["Title": "Mongoose", "Image": "mongoose", "Desc_Data": "Mongoose"],
            ["Title": "Monkey", "Image": "monkey", "Desc_Data": "Monkey"],
            ["Title": "Opossum", "Image": "opossum", "Desc_Data": "Opossum"],
            ["Title": "Otter", "Image": "otter", "Desc_Data": "Otter"],
            ["Title": "Panda", "Image": "panda", "Desc_Data": "Panda"],
            ["Title": "Polar Bear", "Image": "polar_bear", "Desc_Data": "Polar Bear"],
            ["Title": "Porcupine", "Image": "porcupine", "Desc_Data": "Porcupine"],
            ["Title": "Raccoon", "Image": "raccoon", "Desc_Data": "Raccoon"],
            ["Title": "Red Panda", "Image": "red_panda", "Desc_Data": "Red Panda"],
            ["Title": "Rhinoceros", "Image": "rhinoceros", "Desc_Data": "Rhinoceros"],
            ["Title": "Scimitar Oryx", "Image": "scimitar_oryx", "Desc_Data": "Scimitar Oryx"],
            ["Title": "Squirrel", "Image": "squirrel", "Desc_Data": "Squirrel"],
            ["Title": "Tiger", "Image": "tiger", "Desc_Data": "Tiger"],
            ["Title": "Wolf", "Image": "wolf", "Desc_Data": "Wolf"],
            ["Title": "Wombat", "Image": "wombat", "Desc_Data": "Wombat"],
            ["Title": "Zebra", "Image": "zebra", "Desc_Data": "Zebra"]
        ]
    }
    func birdsDetailsArray() {
        passArrDataSelected = [
            ["Title": "Canary", "Image": "canary", "Desc_Data": "Canary"],
            ["Title": "Crow", "Image": "crow", "Desc_Data": "Crow"],
            ["Title": "Dove", "Image": "dove", "Desc_Data": "Dove"],
            ["Title": "Duck", "Image": "duck", "Desc_Data": "Duck"],
            ["Title": "Eagle", "Image": "eagle", "Desc_Data": "Eagle"],
            ["Title": "Hoopoe", "Image": "hoopoe", "Desc_Data": "Hoopoe"],
            ["Title": "Hornbill", "Image": "hornbill", "Desc_Data": "Hornbill"],
            ["Title": "Kingfisher", "Image": "kingfisher", "Desc_Data": "Kingfisher"],
            ["Title": "Kite", "Image": "kite", "Desc_Data": "Kite"],
            ["Title": "Lapwing", "Image": "lapwing", "Desc_Data": "Lapwing"],
            ["Title": "Mynah", "Image": "mynah", "Desc_Data": "Mynah"],
            ["Title": "Nightingale", "Image": "nightingale", "Desc_Data": "Nightingale"],
            ["Title": "Owl", "Image": "owl", "Desc_Data": "Owl"],
            ["Title": "Parrot", "Image": "parrot", "Desc_Data": "Parrot"],
            ["Title": "Peacock", "Image": "peacock", "Desc_Data": "Peacock"],
            ["Title": "Peahen", "Image": "peahen", "Desc_Data": "Peahen"],
            ["Title": "Pheasant", "Image": "pheasant", "Desc_Data": "Pheasant"],
            ["Title": "Pigeon", "Image": "pigeon", "Desc_Data": "Pigeon"],
            ["Title": "Puffin", "Image": "puffin", "Desc_Data": "Puffin"],
            ["Title": "Quail", "Image": "quail", "Desc_Data": "Quail"],
            ["Title": "Robin", "Image": "robin", "Desc_Data": "Robin"],
            ["Title": "Sparrow", "Image": "sparrow", "Desc_Data": "Sparrow"],
            ["Title": "Swallow", "Image": "swallow", "Desc_Data": "Swallow"],
            ["Title": "Toucan", "Image": "toucan", "Desc_Data": "Toucan"],
            ["Title": "Vulture", "Image": "vulture", "Desc_Data": "Vulture"],
            ["Title": "Wagtail", "Image": "wagtail", "Desc_Data": "Wagtail"],
            ["Title": "Waxwing", "Image": "waxwing", "Desc_Data": "Waxwing"],
            ["Title": "Woodpecker", "Image": "woodpecker", "Desc_Data": "Woodpecker"]
        ]
    }

    func flowerDetailsArray() {
        passArrDataSelected = [
            ["Title": "Arum Lily", "Image": "arum_lily", "Desc_Data": "Arum Lily"],
            ["Title": "Aster", "Image": "aster", "Desc_Data": "Aster"],
            ["Title": "Bird Of Paradise", "Image": "bird_of_paradise", "Desc_Data": "Bird Of Paradise"],
            ["Title": "Bougainvillea", "Image": "bougainvillea", "Desc_Data": "Bougainvillea"],
            ["Title": "Buttercup", "Image": "buttercup", "Desc_Data": "Buttercup"],
            ["Title": "Calendula", "Image": "calendula", "Desc_Data": "Calendula"],
            ["Title": "Canna", "Image": "canna", "Desc_Data": "Canna"],
            ["Title": "Cockscomb", "Image": "cockscomb", "Desc_Data": "Cockscomb"],
            ["Title": "Daffodils", "Image": "daffodils", "Desc_Data": "Daffodils"],
            ["Title": "Dahlia", "Image": "dahlia", "Desc_Data": "Dahlia"],
            ["Title": "Daisy", "Image": "daisy", "Desc_Data": "Daisy"],
            ["Title": "Dianthus", "Image": "dianthus", "Desc_Data": "Dianthus"],
            ["Title": "Gladiolus", "Image": "gladiolus", "Desc_Data": "Gladiolus"],
            ["Title": "Hibiscus", "Image": "hibiscus", "Desc_Data": "Hibiscus"],
            ["Title": "Jasmine", "Image": "jasmine", "Desc_Data": "Jasmine"],
            ["Title": "Lavender", "Image": "lavender", "Desc_Data": "Lavender"],
            ["Title": "Lilac", "Image": "lilac", "Desc_Data": "Lilac"],
            ["Title": "Lily", "Image": "lily", "Desc_Data": "Lily"],
            ["Title": "Lotus", "Image": "lotus", "Desc_Data": "Lotus"],
            ["Title": "Morning Glory", "Image": "morning_glory", "Desc_Data": "Morning Glory"],
            ["Title": "Nerium Oleander", "Image": "nerium_oleander", "Desc_Data": "Nerium Oleander"],
            ["Title": "Orchids", "Image": "orchids", "Desc_Data": "Orchids"],
            ["Title": "Peony", "Image": "peony", "Desc_Data": "Peony"],
            ["Title": "Periwinkle", "Image": "periwinkle", "Desc_Data": "Periwinkle"],
            ["Title": "Petunia", "Image": "petunia", "Desc_Data": "Petunia"],
            ["Title": "Poppy", "Image": "poppy", "Desc_Data": "Poppy"],
            ["Title": "Purple Mallow", "Image": "purple_mallow", "Desc_Data": "Purple Mallow"],
            ["Title": "Rose", "Image": "rose", "Desc_Data": "Rose"],
            ["Title": "Sunflower", "Image": "sunflower", "Desc_Data": "Sunflower"],
            ["Title": "Tulips", "Image": "tulips", "Desc_Data": "Tulips"]
        ]
    }

    func fruitDetailsArray() {
        passArrDataSelected = [
            ["Title": "Apple", "Image": "apple", "Desc_Data": "Apple"],
            ["Title": "Apricot", "Image": "apricot", "Desc_Data": "Apricot"],
            ["Title": "Avocado", "Image": "avocado", "Desc_Data": "Avocado"],
            ["Title": "Blackberry", "Image": "blackberry", "Desc_Data": "Blackberry"],
            ["Title": "Blackcurrant", "Image": "blackcurrant", "Desc_Data": "Blackcurrant"],
            ["Title": "Blueberry", "Image": "blueberry", "Desc_Data": "Blueberry"],
            ["Title": "Cherry", "Image": "cherry", "Desc_Data": "Cherry"],
            ["Title": "Coconut", "Image": "coconut", "Desc_Data": "Coconut"],
            ["Title": "Fig", "Image": "fig", "Desc_Data": "Fig"],
            ["Title": "Grape", "Image": "grape", "Desc_Data": "Grape"],
            ["Title": "Kiwi", "Image": "kiwi", "Desc_Data": "Kiwi"],
            ["Title": "Lemon", "Image": "lemon", "Desc_Data": "Lemon"],
            ["Title": "Lime", "Image": "lime", "Desc_Data": "Lime"],
            ["Title": "Lychee", "Image": "lychee", "Desc_Data": "Lychee"],
            ["Title": "Mango", "Image": "mango", "Desc_Data": "Mango"],
            ["Title": "Nectarine", "Image": "nectarine", "Desc_Data": "Nectarine"],
            ["Title": "Orange", "Image": "orange", "Desc_Data": "Orange"],
            ["Title": "Papaya", "Image": "papaya", "Desc_Data": "Papaya"],
            ["Title": "Passion", "Image": "passion", "Desc_Data": "Passion"],
            ["Title": "Peach", "Image": "peach", "Desc_Data": "Peach"],
            ["Title": "Pear", "Image": "pear", "Desc_Data": "Pear"],
            ["Title": "Pineapple", "Image": "pineapple", "Desc_Data": "Pineapple"],
            ["Title": "Plum", "Image": "plum", "Desc_Data": "Plum"],
            ["Title": "Quince", "Image": "quince", "Desc_Data": "Quince"],
            ["Title": "Raspberry", "Image": "raspberry", "Desc_Data": "Raspberry"],
            ["Title": "Strawberry", "Image": "strawberry", "Desc_Data": "Strawberry"],
            ["Title": "Watermelon", "Image": "watermelon", "Desc_Data": "Watermelon"]
        ]
    }

    func monthDetailsArray() {
        passArrDataSelected = [
            ["Title": "January", "Image": "january", "Desc_Data": "January"],
            ["Title": "February", "Image": "february", "Desc_Data": "February"],
            ["Title": "March", "Image": "march", "Desc_Data": "March"],
            ["Title": "April", "Image": "april", "Desc_Data": "April"],
            ["Title": "May", "Image": "may", "Desc_Data": "May"],
            ["Title": "June", "Image": "june", "Desc_Data": "June"],
            ["Title": "July", "Image": "july", "Desc_Data": "July"],
            ["Title": "August", "Image": "august", "Desc_Data": "August"],
            ["Title": "September", "Image": "september", "Desc_Data": "September"],
            ["Title": "October", "Image": "october", "Desc_Data": "October"],
            ["Title": "November", "Image": "november", "Desc_Data": "November"],
            ["Title": "December", "Image": "december", "Desc_Data": "December"]
        ]
    }

    func vegetableDetailsArray() {
        passArrDataSelected = [
            ["Title": "Asparagus", "Image": "asparagus", "Desc_Data": "Asparagus"],
            ["Title": "Broccoli", "Image": "broccoli", "Desc_Data": "Broccoli"],
            ["Title": "Brussels Sprouts", "Image": "brussels_sprouts", "Desc_Data": "Brussels Sprouts"],
            ["Title": "Carrot", "Image": "carrot", "Desc_Data": "Carrot"],
            ["Title": "Cauliflower", "Image": "cauliflower", "Desc_Data": "Cauliflower"],
            ["Title": "Cucumber", "Image": "cucumber", "Desc_Data": "Cucumber"],
            ["Title": "Eggplant", "Image": "eggplant", "Desc_Data": "Eggplant"],
            ["Title": "Garlic", "Image": "garlic", "Desc_Data": "Garlic"],
            ["Title": "Lettuce", "Image": "lettuce", "Desc_Data": "Lettuce"],
            ["Title": "Mint", "Image": "mint", "Desc_Data": "Mint"],
            ["Title": "Mushroom", "Image": "mushroom", "Desc_Data": "Mushroom"],
            ["Title": "Okra", "Image": "okra", "Desc_Data": "Okra"],
            ["Title": "Onion", "Image": "onion", "Desc_Data": "Onion"],
            ["Title": "Peaspeas", "Image": "peaspeas", "Desc_Data": "Peaspeas"],
            ["Title": "Potato", "Image": "potato", "Desc_Data": "Potato"],
            ["Title": "Radish", "Image": "radish", "Desc_Data": "Radish"],
            ["Title": "Red Cabbage", "Image": "red_cabbage", "Desc_Data": "Red Cabbage"],
            ["Title": "Spinach", "Image": "spinach", "Desc_Data": "Spinach"],
            ["Title": "Squash", "Image": "squash", "Desc_Data": "Squash"],
            ["Title": "String Beans", "Image": "string_beans", "Desc_Data": "String Beans"],
            ["Title": "Tomato", "Image": "tomato", "Desc_Data": "Tomato"],
            ["Title": "Turnip", "Image": "turnip", "Desc_Data": "Turnip"]
        ]
    }
    func bodyPartsDetailsArray() {
        passArrDataSelected = [
            ["Title": "Ankle", "Image": "ankle", "Desc_Data": "Ankle"],
            ["Title": "Arm", "Image": "arm", "Desc_Data": "Arm"],
            ["Title": "Chest", "Image": "chest", "Desc_Data": "Chest"],
            ["Title": "Ear", "Image": "ear", "Desc_Data": "Ear"],
            ["Title": "Elbow", "Image": "elbow", "Desc_Data": "Elbow"],
            ["Title": "Eye", "Image": "eye", "Desc_Data": "Eye"],
            ["Title": "Fingers", "Image": "fingers", "Desc_Data": "Fingers"],
            ["Title": "Foot", "Image": "foot", "Desc_Data": "Foot"],
            ["Title": "Hair", "Image": "hair", "Desc_Data": "Hair"],
            ["Title": "Knee", "Image": "knee", "Desc_Data": "Knee"],
            ["Title": "Leg", "Image": "leg", "Desc_Data": "Leg"],
            ["Title": "Lips", "Image": "lips", "Desc_Data": "Lips"],
            ["Title": "Mouth", "Image": "mouth", "Desc_Data": "Mouth"],
            ["Title": "Neck", "Image": "neck", "Desc_Data": "Neck"],
            ["Title": "Nose", "Image": "nose", "Desc_Data": "Nose"],
            ["Title": "Shoulder", "Image": "shoulder", "Desc_Data": "Shoulder"],
            ["Title": "Stomach", "Image": "stomach", "Desc_Data": "Stomach"],
            ["Title": "Thigh", "Image": "thigh", "Desc_Data": "Thigh"],
            ["Title": "Thumb", "Image": "thumb", "Desc_Data": "Thumb"],
            ["Title": "Toe", "Image": "toe", "Desc_Data": "Toe"]
        ]
    }
    func clothesDetailsArray() {
        passArrDataSelected = [
            ["Title": "Shirt", "Image": "shirt", "Desc_Data": "Shirt"],
            ["Title": "Shoes", "Image": "shoes", "Desc_Data": "Shoes"],
            ["Title": "Pyjamas", "Image": "pyjamas", "Desc_Data": "Pyjamas"],
            ["Title": "Sock", "Image": "sock", "Desc_Data": "Sock"],
            ["Title": "Gloves", "Image": "gloves", "Desc_Data": "Gloves"],
            ["Title": "Skirt", "Image": "skirt", "Desc_Data": "Skirt"],
            ["Title": "Slipper", "Image": "slipper", "Desc_Data": "Slipper"],
            ["Title": "Sweater", "Image": "sweater", "Desc_Data": "Sweater"],
            ["Title": "Bathrobe", "Image": "bathrobe", "Desc_Data": "Bathrobe"],
            ["Title": "Jeans", "Image": "jeans", "Desc_Data": "Jeans"],
            ["Title": "Boot", "Image": "boot", "Desc_Data": "Boot"],
            ["Title": "Dress", "Image": "dress", "Desc_Data": "Dress"],
            ["Title": "Overalls", "Image": "overalls", "Desc_Data": "Overalls"],
            ["Title": "Shorts", "Image": "shorts", "Desc_Data": "Shorts"],
            ["Title": "Jacket", "Image": "jacket", "Desc_Data": "Jacket"],
            ["Title": "Scarf", "Image": "scarf", "Desc_Data": "Scarf"],
            ["Title": "Belt", "Image": "belt", "Desc_Data": "Belt"],
            ["Title": "Hat", "Image": "hat", "Desc_Data": "Hat"],
            ["Title": "Glasses", "Image": "glasses", "Desc_Data": "Glasses"],
            ["Title": "Suit", "Image": "suit", "Desc_Data": "Suit"]
        ]
    }

    func countryDetailsArray() {
        passArrDataSelected = [
            ["Title": "Argentina", "Image": "argentina", "Desc_Data": "Argentina"],
            ["Title": "Austria", "Image": "austria", "Desc_Data": "Austria"],
            ["Title": "Belgium", "Image": "belgium", "Desc_Data": "Belgium"],
            ["Title": "Brazil", "Image": "brazil", "Desc_Data": "Brazil"],
            ["Title": "Cambodia", "Image": "cambodia", "Desc_Data": "Cambodia"],
            ["Title": "Canada", "Image": "canada", "Desc_Data": "Canada"],
            ["Title": "Croatia", "Image": "croatia", "Desc_Data": "Croatia"],
            ["Title": "Cuba", "Image": "cuba", "Desc_Data": "Cuba"],
            ["Title": "Denmark", "Image": "denmark", "Desc_Data": "Denmark"],
            ["Title": "England", "Image": "england", "Desc_Data": "England"],
            ["Title": "France", "Image": "france", "Desc_Data": "France"],
            ["Title": "Germany", "Image": "germany", "Desc_Data": "Germany"],
            ["Title": "Greece", "Image": "greece", "Desc_Data": "Greece"],
            ["Title": "Indian", "Image": "indian", "Desc_Data": "Indian"],
            ["Title": "Indonesia", "Image": "indonesia", "Desc_Data": "Indonesia"],
            ["Title": "Italy", "Image": "italy", "Desc_Data": "Italy"],
            ["Title": "Japan", "Image": "japan", "Desc_Data": "Japan"],
            ["Title": "Laos", "Image": "laos", "Desc_Data": "Laos"],
            ["Title": "Malaysia", "Image": "malaysia", "Desc_Data": "Malaysia"],
            ["Title": "Mexico", "Image": "mexico", "Desc_Data": "Mexico"],
            ["Title": "Myanmar", "Image": "myanmar", "Desc_Data": "Myanmar"],
            ["Title": "Netherlands", "Image": "netherlands", "Desc_Data": "Netherlands"],
            ["Title": "Pakistan", "Image": "pakistan", "Desc_Data": "Pakistan"],
            ["Title": "Philippine", "Image": "philippine", "Desc_Data": "Philippine"],
            ["Title": "Portugal", "Image": "portugal", "Desc_Data": "Portugal"],
            ["Title": "Russia", "Image": "russia", "Desc_Data": "Russia"],
            ["Title": "Saudi Arabia", "Image": "saudi_arabia", "Desc_Data": "Saudi Arabia"],
            ["Title": "Singapore", "Image": "singapore", "Desc_Data": "Singapore"],
            ["Title": "South Korea", "Image": "south_korea", "Desc_Data": "South Korea"],
            ["Title": "Spain", "Image": "spain", "Desc_Data": "Spain"],
            ["Title": "Sweden", "Image": "sweden", "Desc_Data": "Sweden"],
            ["Title": "Thailand", "Image": "thailand", "Desc_Data": "Thailand"],
            ["Title": "United States", "Image": "united_states", "Desc_Data": "United States"],
            ["Title": "Vietnam", "Image": "vietnam", "Desc_Data": "Vietnam"]
        ]
    }
    func foodDetailsArray() {
        passArrDataSelected = [
            ["Title": "Pizza", "Image": "pizza", "Desc_Data": "Pizza"],
            ["Title": "Biscuits", "Image": "biscuits", "Desc_Data": "Biscuits"],
            ["Title": "Chip", "Image": "chip", "Desc_Data": "Chip"],
            ["Title": "Cake", "Image": "cake", "Desc_Data": "Cake"],
            ["Title": "Noodles", "Image": "noodles", "Desc_Data": "Noodles"],
            ["Title": "Water", "Image": "water", "Desc_Data": "Water"],
            ["Title": "Sandwich", "Image": "sandwich", "Desc_Data": "Sandwich"],
            ["Title": "Ice Cream", "Image": "ice_cream", "Desc_Data": "Ice Cream"],
            ["Title": "Beer", "Image": "beer", "Desc_Data": "Beer"],
            ["Title": "Hamburger", "Image": "hamburger", "Desc_Data": "Hamburger"],
            ["Title": "Tea", "Image": "tea", "Desc_Data": "Tea"],
            ["Title": "Ham", "Image": "ham", "Desc_Data": "Ham"],
            ["Title": "Yogurt", "Image": "yogurt", "Desc_Data": "Yogurt"],
            ["Title": "Chocolate", "Image": "chocolate", "Desc_Data": "Chocolate"],
            ["Title": "Rice", "Image": "rice", "Desc_Data": "Rice"],
            ["Title": "Soda", "Image": "soda", "Desc_Data": "Soda"],
            ["Title": "Juice", "Image": "juice", "Desc_Data": "Juice"],
            ["Title": "Coffee", "Image": "coffee", "Desc_Data": "Coffee"],
            ["Title": "Bread", "Image": "bread", "Desc_Data": "Bread"],
            ["Title": "Soup", "Image": "soup", "Desc_Data": "Soup"],
            ["Title": "Butter", "Image": "butter", "Desc_Data": "Butter"],
            ["Title": "Cheese", "Image": "cheese", "Desc_Data": "Cheese"],
            ["Title": "Milk", "Image": "milk", "Desc_Data": "Milk"]
        ]
    }

    func geometryDetailsArray() {
        passArrDataSelected = [
            ["Title": "Arrow", "Image": "arrow", "Desc_Data": "Arrow"],
            ["Title": "Circle", "Image": "circle", "Desc_Data": "Circle"],
            ["Title": "Cone", "Image": "cone", "Desc_Data": "Cone"],
            ["Title": "Crescent", "Image": "crescent", "Desc_Data": "Crescent"],
            ["Title": "Cube", "Image": "cube", "Desc_Data": "Cube"],
            ["Title": "Cuboid", "Image": "cuboid", "Desc_Data": "Cuboid"],
            ["Title": "Cylinder", "Image": "cylinder", "Desc_Data": "Cylinder"],
            ["Title": "Diamond", "Image": "diamond", "Desc_Data": "Diamond"],
            ["Title": "Heart", "Image": "heart", "Desc_Data": "Heart"],
            ["Title": "Hexagon", "Image": "hexagon", "Desc_Data": "Hexagon"],
            ["Title": "Oval", "Image": "oval", "Desc_Data": "Oval"],
            ["Title": "Parallelogram", "Image": "parallelogram", "Desc_Data": "Parallelogram"],
            ["Title": "Pentagon", "Image": "pentagon", "Desc_Data": "Pentagon"],
            ["Title": "Pyramid", "Image": "pyramid", "Desc_Data": "Pyramid"],
            ["Title": "Rectangle", "Image": "rectangle", "Desc_Data": "Rectangle"],
            ["Title": "Sphere", "Image": "sphere", "Desc_Data": "Sphere"],
            ["Title": "Star", "Image": "star", "Desc_Data": "Star"],
            ["Title": "Trapezoid", "Image": "trapezoid", "Desc_Data": "Trapezoid"],
            ["Title": "Triangle", "Image": "triangle", "Desc_Data": "Triangle"]
        ]
    }

    func houseDetailsArray() {
        passArrDataSelected = [
            ["Title": "Bookcase", "Image": "bookcase", "Desc_Data": "Bookcase"],
            ["Title": "Chair", "Image": "chair", "Desc_Data": "Chair"],
            ["Title": "Newspaper", "Image": "newspaper", "Desc_Data": "Newspaper"],
            ["Title": "Sofa", "Image": "sofasofa", "Desc_Data": "Sofa"],
            ["Title": "Picture", "Image": "picture", "Desc_Data": "Picture"],
            ["Title": "Watch", "Image": "watch", "Desc_Data": "Watch"],
            ["Title": "Brush", "Image": "brush", "Desc_Data": "Brush"],
            ["Title": "Television", "Image": "television", "Desc_Data": "Television"],
            ["Title": "Table", "Image": "table", "Desc_Data": "Table"],
            ["Title": "Coin", "Image": "coin", "Desc_Data": "Coin"],
            ["Title": "Phone", "Image": "phone", "Desc_Data": "Phone"],
            ["Title": "Bar Stool", "Image": "bar_stool", "Desc_Data": "Bar Stool"],
            ["Title": "Laptop", "Image": "laptop", "Desc_Data": "Laptop"],
            ["Title": "Mirror", "Image": "mirror", "Desc_Data": "Mirror"],
            ["Title": "Scissors", "Image": "scissors", "Desc_Data": "Scissors"],
            ["Title": "Umbrella", "Image": "umbrella", "Desc_Data": "Umbrella"],
            ["Title": "Clock", "Image": "clock", "Desc_Data": "Clock"],
            ["Title": "Bucket", "Image": "bucket", "Desc_Data": "Bucket"],
            ["Title": "Cup", "Image": "cup", "Desc_Data": "Cup"],
            ["Title": "Key", "Image": "key", "Desc_Data": "Key"],
            ["Title": "Door", "Image": "door", "Desc_Data": "Door"],
            ["Title": "Glass", "Image": "glass", "Desc_Data": "Glass"],
            ["Title": "Armchair", "Image": "armchair", "Desc_Data": "Armchair"],
            ["Title": "Window", "Image": "window", "Desc_Data": "Window"],
            ["Title": "Knife", "Image": "knife", "Desc_Data": "Knife"],
            ["Title": "Wallet", "Image": "wallet", "Desc_Data": "Wallet"],
            ["Title": "Bottle", "Image": "bottle", "Desc_Data": "Bottle"],
            ["Title": "Mobile Phone", "Image": "mobile_phone", "Desc_Data": "Mobile Phone"],
            ["Title": "Bed", "Image": "bed", "Desc_Data": "Bed"],
            ["Title": "Lock", "Image": "lock", "Desc_Data": "Lock"]
        ]
    }
    func jobsDetailsArray() {
        passArrDataSelected = [
            ["Title": "Accountant", "Image": "accountant", "Desc_Data": "Accountant"],
            ["Title": "Architect", "Image": "architect", "Desc_Data": "Architect"],
            ["Title": "Astronomer", "Image": "astronomer", "Desc_Data": "Astronomer"],
            ["Title": "Author", "Image": "author", "Desc_Data": "Author"],
            ["Title": "Baker", "Image": "baker", "Desc_Data": "Baker"],
            ["Title": "Bricklayer", "Image": "bricklayer", "Desc_Data": "Bricklayer"],
            ["Title": "Butcher", "Image": "butcher", "Desc_Data": "Butcher"],
            ["Title": "Carpenter", "Image": "carpenter", "Desc_Data": "Carpenter"],
            ["Title": "Chef", "Image": "chef", "Desc_Data": "Chef"],
            ["Title": "Cleaner", "Image": "cleaner", "Desc_Data": "Cleaner"],
            ["Title": "Dentist", "Image": "dentist", "Desc_Data": "Dentist"],
            ["Title": "Doctor", "Image": "doctor", "Desc_Data": "Doctor"],
            ["Title": "Driver", "Image": "driver", "Desc_Data": "Driver"],
            ["Title": "Dustman", "Image": "dustman", "Desc_Data": "Dustman"],
            ["Title": "Electrician", "Image": "electrician", "Desc_Data": "Electrician"],
            ["Title": "Engineer", "Image": "engineer", "Desc_Data": "Engineer"],
            ["Title": "Farmer", "Image": "farmer", "Desc_Data": "Farmer"],
            ["Title": "Firefighter", "Image": "firefighter", "Desc_Data": "Firefighter"],
            ["Title": "Florist", "Image": "florist", "Desc_Data": "Florist"],
            ["Title": "Gardener", "Image": "gardener", "Desc_Data": "Gardener"],
            ["Title": "Hairdresser", "Image": "hairdresser", "Desc_Data": "Hairdresser"],
            ["Title": "Journalist", "Image": "journalist", "Desc_Data": "Journalist"],
            ["Title": "Judge", "Image": "judge", "Desc_Data": "Judge"],
            ["Title": "Lawyer", "Image": "lawyer", "Desc_Data": "Lawyer"],
            ["Title": "Lecturer", "Image": "lecturer", "Desc_Data": "Lecturer"],
            ["Title": "Librarian", "Image": "librarian", "Desc_Data": "Librarian"],
            ["Title": "Lifeguard", "Image": "lifeguard", "Desc_Data": "Lifeguard"],
            ["Title": "Mechanics", "Image": "mechanics", "Desc_Data": "Mechanics"],
            ["Title": "Nurse", "Image": "nurse", "Desc_Data": "Nurse"],
            ["Title": "Optician", "Image": "optician", "Desc_Data": "Optician"],
            ["Title": "Painter", "Image": "painter", "Desc_Data": "Painter"],
            ["Title": "Pharmacist", "Image": "pharmacist", "Desc_Data": "Pharmacist"],
            ["Title": "Photographer", "Image": "photographer", "Desc_Data": "Photographer"],
            ["Title": "Pilot", "Image": "pilot", "Desc_Data": "Pilot"],
            ["Title": "Plumber", "Image": "plumber", "Desc_Data": "Plumber"],
            ["Title": "Receptionist", "Image": "receptionist", "Desc_Data": "Receptionist"],
            ["Title": "Scientist", "Image": "scientist", "Desc_Data": "Scientist"],
            ["Title": "Soldier", "Image": "soldier", "Desc_Data": "Soldier"],
            ["Title": "Student", "Image": "student", "Desc_Data": "Student"],
            ["Title": "Tailor", "Image": "tailor", "Desc_Data": "Tailor"],
            ["Title": "Traffic Warden", "Image": "traffic_warden", "Desc_Data": "Traffic Warden"],
            ["Title": "Veterinarian", "Image": "veterinarian", "Desc_Data": "Veterinarian"],
            ["Title": "Waiter", "Image": "waiter", "Desc_Data": "Waiter"],
            ["Title": "Welder", "Image": "welder", "Desc_Data": "Welder"]
        ]
    }

    func schoolDetailsArray() {
        passArrDataSelected = [
            ["Title": "Board", "Image": "board", "Desc_Data": "Board"],
            ["Title": "Book", "Image": "book", "Desc_Data": "Book"],
            ["Title": "Chair", "Image": "chair", "Desc_Data": "Chair"],
            ["Title": "Compass", "Image": "compass", "Desc_Data": "Compass"],
            ["Title": "Computer", "Image": "computer", "Desc_Data": "Computer"],
            ["Title": "Desk", "Image": "desk", "Desc_Data": "Desk"],
            ["Title": "Dictionary", "Image": "dictionary", "Desc_Data": "Dictionary"],
            ["Title": "Eraser", "Image": "eraser", "Desc_Data": "Eraser"],
            ["Title": "Globe", "Image": "globe", "Desc_Data": "Globe"],
            ["Title": "Map", "Image": "map", "Desc_Data": "Map"],
            ["Title": "Notebook", "Image": "notebook", "Desc_Data": "Notebook"],
            ["Title": "Pen", "Image": "pen", "Desc_Data": "Pen"],
            ["Title": "Pencil", "Image": "pencil", "Desc_Data": "Pencil"],
            ["Title": "Ruler", "Image": "ruler", "Desc_Data": "Ruler"],
            ["Title": "School bag", "Image": "school_bag", "Desc_Data": "School bag"],
            ["Title": "Teacher", "Image": "teacher", "Desc_Data": "Teacher"]
        ]
    }
    func sportsDetailsArray() {
        passArrDataSelected = [
            ["Title": "Chess", "Image": "chess", "Desc_Data": "Chess"],
            ["Title": "Windsurfing", "Image": "windsurfing", "Desc_Data": "Windsurfing"],
            ["Title": "Bowling", "Image": "bowling", "Desc_Data": "Bowling"],
            ["Title": "Karate", "Image": "karate", "Desc_Data": "Karate"],
            ["Title": "Ice Skating", "Image": "ice_skating", "Desc_Data": "Ice Skating"],
            ["Title": "Table Tennis", "Image": "table_tennis", "Desc_Data": "Table Tennis"],
            ["Title": "Badminton", "Image": "badminton", "Desc_Data": "Badminton"],
            ["Title": "Swimming", "Image": "swimming", "Desc_Data": "Swimming"],
            ["Title": "Football", "Image": "football", "Desc_Data": "Football"],
            ["Title": "Hockey", "Image": "hockey", "Desc_Data": "Hockey"],
            ["Title": "Equestrian", "Image": "equestrian", "Desc_Data": "Equestrian"],
            ["Title": "Cycling", "Image": "cycling", "Desc_Data": "Cycling"],
            ["Title": "Diving", "Image": "diving", "Desc_Data": "Diving"],
            ["Title": "Judo", "Image": "judo", "Desc_Data": "Judo"],
            ["Title": "Golf", "Image": "golf", "Desc_Data": "Golf"],
            ["Title": "Baseball", "Image": "baseball", "Desc_Data": "Baseball"],
            ["Title": "Volleyball", "Image": "volleyball", "Desc_Data": "Volleyball"],
            ["Title": "Surfing", "Image": "surfing", "Desc_Data": "Surfing"],
            ["Title": "Skateboarding", "Image": "skateboarding", "Desc_Data": "Skateboarding"],
            ["Title": "Skiing", "Image": "skiing", "Desc_Data": "Skiing"],
            ["Title": "Archery", "Image": "archery", "Desc_Data": "Archery"],
            ["Title": "Canoeing", "Image": "canoeing", "Desc_Data": "Canoeing"],
            ["Title": "Running", "Image": "running", "Desc_Data": "Running"],
            ["Title": "Billiards", "Image": "billiards", "Desc_Data": "Billiards"],
            ["Title": "Fencing", "Image": "fencing", "Desc_Data": "Fencing"],
            ["Title": "Tennis", "Image": "tennis", "Desc_Data": "Tennis"],
            ["Title": "Basketball", "Image": "basketball", "Desc_Data": "Basketball"]
        ]
    }

    func vehicleDetailsArray() {
        self.passArrDataSelected = [
            ["Title": "Ambulance", "Image": "ambulance", "Desc_Data": "Ambulance"],
            ["Title": "Bike", "Image": "bike", "Desc_Data": "Bike"],
            ["Title": "Boat", "Image": "boat", "Desc_Data": "Boat"],
            ["Title": "Bus", "Image": "bus", "Desc_Data": "Bus"],
            ["Title": "Car", "Image": "car", "Desc_Data": "Car"],
            ["Title": "Container Truck", "Image": "container_truck", "Desc_Data": "Container Truck"],
            ["Title": "Fire Truck", "Image": "fire_truck", "Desc_Data": "Fire Truck"],
            ["Title": "Helicopter", "Image": "helicopter", "Desc_Data": "Helicopter"],
            ["Title": "Motorbike", "Image": "motorbike", "Desc_Data": "Motorbike"],
            ["Title": "Plane", "Image": "plane", "Desc_Data": "Plane"],
            ["Title": "Police Car", "Image": "police_car", "Desc_Data": "Police Car"],
            ["Title": "Ship", "Image": "ship", "Desc_Data": "Ship"],
            ["Title": "Subway", "Image": "subway", "Desc_Data": "Subway"],
            ["Title": "Train", "Image": "train", "Desc_Data": "Train"],
            ["Title": "Truck", "Image": "truck", "Desc_Data": "Truck"]
        ]
    }

}

   



