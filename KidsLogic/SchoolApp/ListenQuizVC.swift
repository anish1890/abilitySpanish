//
//  ListenQuizVC.swift
//  KidsLogic
//
//  Created by Anish on 1/22/24.
//

import UIKit
import AVFoundation

class ListenQuizVC: UIViewController, AVSpeechSynthesizerDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    
     @IBOutlet weak var imgSelected: UIImageView!
     @IBOutlet weak var quizLookCollection: UICollectionView!
     @IBOutlet weak var lblQuiz: UILabel!
   
     var passArrDataSelected: [[String: Any]]? = []
     var tempPassArrDataSelected: [[String: Any]]? = []
     var CorrectAns: String = ""
     var rnd: UInt = 0
     var arrAnsOption: [String] = []
     var synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
     var selectedSubCat: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        synthesizer.delegate = self

        self.title = GlobleConstants.MAIN_CAT_LISTEN

        let collectionNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        quizLookCollection.register(collectionNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")

        let anotherButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(skipQuestion))
        navigationItem.rightBarButtonItem = anotherButton

        if selectedSubCat == 0 {
            alphabetDetailsArray()
        } else if selectedSubCat == 1 {
            numberDetailsArray()
        } else if selectedSubCat == 2 {
            colorDetailsArray()
        } else if selectedSubCat == 3 {
            shapesDetailsArray()
        } else if selectedSubCat == 4 {
            animalDetailsArray()
        } else if selectedSubCat == 5 {
            birdsDetailsArray()
        } else if selectedSubCat == 6 {
            flowerDetailsArray()
        } else if selectedSubCat == 7 {
            fruitDetailsArray()
        } else if selectedSubCat == 8 {
            monthDetailsArray()
        } else if selectedSubCat == 9 {
            vegetableDetailsArray()
        } else if selectedSubCat == 10 {
            bodyPartsDetailsArray()
        } else if selectedSubCat == 11 {
            clothesDetailsArray()
        } else if selectedSubCat == 12 {
            countryDetailsArray()
        } else if selectedSubCat == 13 {
            foodDetailsArray()
        } else if selectedSubCat == 14 {
            geometryDetailsArray()
        } else if selectedSubCat == 15 {
            houseDetailsArray()
        } else if selectedSubCat == 16 {
            jobsDetailsArray()
        } else if selectedSubCat == 17 {
            schoolDetailsArray()
        } else if selectedSubCat == 18 {
            sportsDetailsArray()
        } else if selectedSubCat == 19 {
            vehicleDetailsArray()
        }

        rnd = UInt(arc4random_uniform(UInt32(passArrDataSelected!.count)))
        displaySelected(indexVal: Int(rnd))

    }

    @objc func skipQuestion() {
        rnd = UInt(arc4random_uniform(UInt32(passArrDataSelected!.count)))
        displaySelected(indexVal: Int(rnd))
    }
    

    @IBAction func btn_click_Prev(_ sender: Any) {
        rnd = UInt(arc4random_uniform(UInt32(passArrDataSelected!.count)))
        displaySelected(indexVal: Int(rnd))
    }

    @IBAction func btn_click_next(_ sender: Any) {
        rnd = UInt(arc4random_uniform(UInt32(passArrDataSelected!.count)))
        displaySelected(indexVal: Int(rnd))
        //    let randomObject = passArrDataSelected[rnd]
        //    print(randomObject)
    }

    func displaySelected(indexVal: Int) {
        synthesizer.stopSpeaking(at: .immediate)

        lblQuiz.text = passArrDataSelected![indexVal]["Desc_Data"] as? String

        if UIDevice.current.userInterfaceIdiom == .phone {
            lblQuiz.font = UIFont.boldSystemFont(ofSize: 16)
        } else {
            lblQuiz.font = UIFont.boldSystemFont(ofSize: 30)
        }

        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        transition.subtype = .fromRight
        imgSelected.layer.add(transition, forKey: nil)
        GlobleConstants.theAppDelegate.speakWord(lblQuiz.text ?? "")

        arrAnsOption = []
        if let strTitle = passArrDataSelected![indexVal]["Image"] as? String {
            arrAnsOption.append(strTitle)
            CorrectAns = strTitle
        }

        tempPassArrDataSelected = passArrDataSelected
        tempPassArrDataSelected!.remove(at: indexVal)

        for _ in 0..<3 {
            let index = Int(arc4random_uniform(UInt32(tempPassArrDataSelected!.count)))
            if let strTitle1 = tempPassArrDataSelected![index]["Image"] as? String {
                arrAnsOption.append(strTitle1)
                tempPassArrDataSelected!.remove(at: index)
            }
        }
        arrAnsOption.sort { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }

        quizLookCollection.reloadData()
    }
    
    @IBAction func btn_click_replay(_ sender: Any) {
        synthesizer.stopSpeaking(at: .immediate)

        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        transition.subtype = .fromRight
        imgSelected.layer.add(transition, forKey: nil)

        GlobleConstants.theAppDelegate.speakWord(lblQuiz.text ?? "")
    }
    // CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAnsOption.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.catName.isHidden = true
        cell.mainCatImg.isHidden = false
        cell.lblName.isHidden = true
        cell.mainCatImg.layer.cornerRadius = 15
        cell.mainCatImg.backgroundColor = GlobleConstants.FAV_COLOR_DEFAULT
        
        if let imageName = arrAnsOption[indexPath.row] as? String {
            cell.mainCatImg.image = UIImage(named: imageName)
        }
        
        cell.mainCatImg.layer.cornerRadius = 10
        cell.mainCatImg.clipsToBounds = true
        
        let finalCellFrame = cell.mainCatImg.frame
        let translation = collectionView.panGestureRecognizer.translation(in: collectionView.superview)
        
        if translation.x > 0 {
            cell.mainCatImg.frame = CGRect(x: finalCellFrame.size.width / 2, y: finalCellFrame.size.height / 2, width: 0, height: 0)
        } else {
            cell.mainCatImg.frame = CGRect(x: finalCellFrame.size.width / 2, y: finalCellFrame.size.height / 2, width: 0, height: 0)
        }
        
        UIView.animate(withDuration: 0.8) {
            cell.mainCatImg.frame = finalCellFrame
        }
        
        return cell
    }

    // CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            let strTitleSelect = arrAnsOption[indexPath.row] as? String ?? ""
            
            if CorrectAns == strTitleSelect {
                cell.mainCatImg.backgroundColor = GlobleConstants.FAV_COLOR_CORRECT
            } else {
                cell.mainCatImg.backgroundColor = GlobleConstants.FAV_COLOR_WRONG
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            let strTitleSelect = arrAnsOption[indexPath.row] as? String ?? ""
            
            if CorrectAns == strTitleSelect {
                cell.mainCatImg.backgroundColor = GlobleConstants.FAV_COLOR_CORRECT
            } else {
                cell.mainCatImg.backgroundColor = GlobleConstants.FAV_COLOR_WRONG
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let strTitleSelect = arrAnsOption[indexPath.row] as? String ?? ""
        synthesizer.stopSpeaking(at: .immediate)
        
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        transition.subtype = .fromRight
        imgSelected.layer.add(transition, forKey: nil)
        
        synthesizer = AVSpeechSynthesizer()
        if CorrectAns == strTitleSelect {
            GlobleConstants.theAppDelegate.speakWord(GlobleConstants.CORRECT_ANS)
        } else {
            GlobleConstants.theAppDelegate.speakWord(GlobleConstants.WRONG_ANS)
        }
    }

    // CollectionView Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: quizLookCollection.frame.size.width / 2, height: quizLookCollection.frame.size.height / 2)
        } else {
            return CGSize(width: quizLookCollection.frame.size.width / 2, height: quizLookCollection.frame.size.height / 2)
        }
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
    
    func alphabetDetailsArray() {
        passArrDataSelected = [
                ["Title": "Manzana", "Image": "a_apple", "Desc_Data": "A para Manzana"],
                ["Title": "Pelota", "Image": "b_ball", "Desc_Data": "B para Pelota"],
                ["Title": "Gato", "Image": "c_cat", "Desc_Data": "C para Gato"],
                ["Title": "Perro", "Image": "d_dog", "Desc_Data": "D para Perro"],
                ["Title": "Elefante", "Image": "e_elephant", "Desc_Data": "E para Elefante"],
                ["Title": "Pez", "Image": "f_fish", "Desc_Data": "F para Pez"],
                ["Title": "Cabra", "Image": "g_goat", "Desc_Data": "G para Cabra"],
                ["Title": "Caballo", "Image": "h_horse", "Desc_Data": "H para Caballo"],
                ["Title": "Helado", "Image": "i_icecream", "Desc_Data": "I para Helado"],
                ["Title": "Comodín", "Image": "j_joker", "Desc_Data": "J para Comodín"],
                ["Title": "Cometa", "Image": "k_kite", "Desc_Data": "K para Cometa"],
                ["Title": "León", "Image": "l_line", "Desc_Data": "L para León"],
                ["Title": "Mono", "Image": "m_monkey", "Desc_Data": "M para Mono"],
                ["Title": "Nido", "Image": "n_nest", "Desc_Data": "N para Nido"],
                ["Title": "Naranja", "Image": "o_orange", "Desc_Data": "O para Naranja"],
                ["Title": "Loro", "Image": "p_parrot", "Desc_Data": "P para Loro"],
                ["Title": "Reina", "Image": "q_queen", "Desc_Data": "Q para Reina"],
                ["Title": "Conejo", "Image": "r_rabbit", "Desc_Data": "R para Conejo"],
                ["Title": "Sol", "Image": "s_sun", "Desc_Data": "S para Sol"],
                ["Title": "Tren", "Image": "t_train", "Desc_Data": "T para Tren"],
                ["Title": "Paraguas", "Image": "u_umbrella", "Desc_Data": "U para Paraguas"],
                ["Title": "Violín", "Image": "v_violin", "Desc_Data": "V para Violín"],
                ["Title": "Reloj", "Image": "w_watch", "Desc_Data": "W para Reloj"],
                ["Title": "Xilófono", "Image": "x_xylophone", "Desc_Data": "X para Xilófono"],
                ["Title": "Yak", "Image": "y_yak", "Desc_Data": "Y para Yak"],
                ["Title": "Cebra", "Image": "z_zebra", "Desc_Data": "Z para Cebra"]
        ]
    }
    func numberDetailsArray() {
        passArrDataSelected = [
            ["Title": "Cero", "Image": "0", "Desc_Data": "Cero"],
             ["Title": "Uno", "Image": "1", "Desc_Data": "Uno"],
             ["Title": "Dos", "Image": "2", "Desc_Data": "Dos"],
             ["Title": "Tres", "Image": "3", "Desc_Data": "Tres"],
             ["Title": "Cuatro", "Image": "4", "Desc_Data": "Cuatro"],
             ["Title": "Cinco", "Image": "5", "Desc_Data": "Cinco"],
             ["Title": "Seis", "Image": "6", "Desc_Data": "Seis"],
             ["Title": "Siete", "Image": "7", "Desc_Data": "Siete"],
             ["Title": "Ocho", "Image": "8", "Desc_Data": "Ocho"],
             ["Title": "Nueve", "Image": "9", "Desc_Data": "Nueve"],
             ["Title": "Diez", "Image": "10", "Desc_Data": "Diez"],
             ["Title": "Once", "Image": "11", "Desc_Data": "Once"],
             ["Title": "Doce", "Image": "12", "Desc_Data": "Doce"],
             ["Title": "Trece", "Image": "13", "Desc_Data": "Trece"],
             ["Title": "Catorce", "Image": "14", "Desc_Data": "Catorce"],
             ["Title": "Quince", "Image": "15", "Desc_Data": "Quince"],
             ["Title": "Dieciséis", "Image": "16", "Desc_Data": "Dieciséis"],
             ["Title": "Diecisiete", "Image": "17", "Desc_Data": "Diecisiete"],
             ["Title": "Dieciocho", "Image": "18", "Desc_Data": "Dieciocho"],
             ["Title": "Diecinueve", "Image": "19", "Desc_Data": "Diecinueve"],
             ["Title": "Veinte", "Image": "20", "Desc_Data": "Veinte"]
        ]
    }

    func colorDetailsArray() {
        passArrDataSelected = [
            ["Title": "Verde", "Image": "green", "Desc_Data": "Verde"],
                ["Title": "Rosa", "Image": "pink", "Desc_Data": "Rosa"],
                ["Title": "Rojo", "Image": "red", "Desc_Data": "Rojo"],
                ["Title": "Negro", "Image": "black", "Desc_Data": "Negro"],
                ["Title": "Aqua", "Image": "aqua", "Desc_Data": "Aqua"],
                ["Title": "Azul", "Image": "blue", "Desc_Data": "Azul"],
                ["Title": "Marrón", "Image": "brown", "Desc_Data": "Marrón"],
                ["Title": "Pizarra", "Image": "slate", "Desc_Data": "Pizarra"],
                ["Title": "Violeta", "Image": "violet", "Desc_Data": "Violeta"],
                ["Title": "Blanco", "Image": "white", "Desc_Data": "Blanco"],
                ["Title": "Amarillo", "Image": "yellow", "Desc_Data": "Amarillo"]
        ]
    }

    func shapesDetailsArray() {
        passArrDataSelected = [
            ["Title": "Círculo", "Image": "circle", "Desc_Data": "Círculo"],
                ["Title": "Cuadrado", "Image": "square", "Desc_Data": "Cuadrado"],
                ["Title": "Decágono", "Image": "decagon", "Desc_Data": "Decágono"],
                ["Title": "Elipse", "Image": "ellipse", "Desc_Data": "Elipse"],
                ["Title": "Hexágono", "Image": "hexagon", "Desc_Data": "Hexágono"],
                ["Title": "Triángulo", "Image": "triangle", "Desc_Data": "Triángulo"],
                ["Title": "Octágono", "Image": "octagon", "Desc_Data": "Octágono"],
                ["Title": "Paralelogramo", "Image": "parallelogram", "Desc_Data": "Paralelogramo"],
                ["Title": "Pentágono", "Image": "pentagon", "Desc_Data": "Pentágono"],
                ["Title": "Rectángulo", "Image": "rectangle", "Desc_Data": "Rectángulo"],
                ["Title": "Rombus", "Image": "rhombus", "Desc_Data": "Rombus"],
                ["Title": "Triángulo Rectángulo", "Image": "right_triangle", "Desc_Data": "Triángulo Rectángulo"],
                ["Title": "Trapecio", "Image": "trapezoid", "Desc_Data": "Trapecio"]
        ]
    }

    func animalDetailsArray() {
        passArrDataSelected = [
            ["Title": "Oso", "Image": "bear", "Desc_Data": "Oso"],
                ["Title": "Bisonte", "Image": "bison", "Desc_Data": "Bisonte"],
                ["Title": "Leopardo Negro", "Image": "black_leopard", "Desc_Data": "Leopardo Negro"],
                ["Title": "Guepardo", "Image": "cheetah", "Desc_Data": "Guepardo"],
                ["Title": "Chimpancé", "Image": "chimpanzee", "Desc_Data": "Chimpancé"],
                ["Title": "Ardilla Listada", "Image": "chipmunk", "Desc_Data": "Ardilla Listada"],
                ["Title": "Puma", "Image": "cougar", "Desc_Data": "Puma"],
                ["Title": "Venado", "Image": "deer", "Desc_Data": "Venado"],
                ["Title": "Elefante", "Image": "elephant", "Desc_Data": "Elefante"],
                ["Title": "Zorro", "Image": "fox", "Desc_Data": "Zorro"],
                ["Title": "Jirafa", "Image": "giraffe", "Desc_Data": "Jirafa"],
                ["Title": "Gorila", "Image": "gorilla", "Desc_Data": "Gorila"],
                ["Title": "Erizo", "Image": "hedgehog", "Desc_Data": "Erizo"],
                ["Title": "Hipopótamo", "Image": "hippopotamus", "Desc_Data": "Hipopótamo"],
                ["Title": "Hiena", "Image": "hyena", "Desc_Data": "Hiena"],
                ["Title": "Chacal", "Image": "jackal", "Desc_Data": "Chacal"],
                ["Title": "Jaguar", "Image": "jaguar", "Desc_Data": "Jaguar"],
                ["Title": "Canguro", "Image": "kangaroo", "Desc_Data": "Canguro"],
                ["Title": "Koala", "Image": "koala_bear", "Desc_Data": "Koala"],
                ["Title": "León", "Image": "lion", "Desc_Data": "León"],
                ["Title": "Suricata", "Image": "meerkat", "Desc_Data": "Suricata"],
                ["Title": "Mangosta", "Image": "mongoose", "Desc_Data": "Mangosta"],
                ["Title": "Mono", "Image": "monkey", "Desc_Data": "Mono"],
                ["Title": "Zarigüeya", "Image": "opossum", "Desc_Data": "Zarigüeya"],
                ["Title": "Nutria", "Image": "otter", "Desc_Data": "Nutria"],
                ["Title": "Panda", "Image": "panda", "Desc_Data": "Panda"],
                ["Title": "Oso Polar", "Image": "polar_bear", "Desc_Data": "Oso Polar"],
                ["Title": "Puercoespín", "Image": "porcupine", "Desc_Data": "Puercoespín"],
                ["Title": "Mapache", "Image": "raccoon", "Desc_Data": "Mapache"],
                ["Title": "Panda Rojo", "Image": "red_panda", "Desc_Data": "Panda Rojo"],
                ["Title": "Rinoceronte", "Image": "rhinoceros", "Desc_Data": "Rinoceronte"],
                ["Title": "Órix Scimitar", "Image": "scimitar_oryx", "Desc_Data": "Órix Scimitar"],
                ["Title": "Ardilla", "Image": "squirrel", "Desc_Data": "Ardilla"],
                ["Title": "Tigre", "Image": "tiger", "Desc_Data": "Tigre"],
                ["Title": "Lobo", "Image": "wolf", "Desc_Data": "Lobo"],
                ["Title": "Wombat", "Image": "wombat", "Desc_Data": "Wombat"],
                ["Title": "Cebra", "Image": "zebra", "Desc_Data": "Cebra"]
        ]
    }
    func birdsDetailsArray() {
        passArrDataSelected = [
            ["Title": "Canario", "Image": "canary", "Desc_Data": "Canario"],
                ["Title": "Cuervo", "Image": "crow", "Desc_Data": "Cuervo"],
                ["Title": "Paloma", "Image": "dove", "Desc_Data": "Paloma"],
                ["Title": "Pato", "Image": "duck", "Desc_Data": "Pato"],
                ["Title": "Águila", "Image": "eagle", "Desc_Data": "Águila"],
                ["Title": "Abubilla", "Image": "hoopoe", "Desc_Data": "Abubilla"],
                ["Title": "Cálao", "Image": "hornbill", "Desc_Data": "Cálao"],
                ["Title": "Martín Pescador", "Image": "kingfisher", "Desc_Data": "Martín Pescador"],
                ["Title": "Cometa", "Image": "kite", "Desc_Data": "Cometa"],
                ["Title": "Avefría", "Image": "lapwing", "Desc_Data": "Avefría"],
                ["Title": "Myna", "Image": "mynah", "Desc_Data": "Myna"],
                ["Title": "Ruiseñor", "Image": "nightingale", "Desc_Data": "Ruiseñor"],
                ["Title": "Búho", "Image": "owl", "Desc_Data": "Búho"],
                ["Title": "Loro", "Image": "parrot", "Desc_Data": "Loro"],
                ["Title": "Pavo Real", "Image": "peacock", "Desc_Data": "Pavo Real"],
                ["Title": "Pava", "Image": "peahen", "Desc_Data": "Pava"],
                ["Title": "Faisán", "Image": "pheasant", "Desc_Data": "Faisán"],
                ["Title": "Paloma", "Image": "pigeon", "Desc_Data": "Paloma"],
                ["Title": "Frailecillo", "Image": "puffin", "Desc_Data": "Frailecillo"],
                ["Title": "Codorniz", "Image": "quail", "Desc_Data": "Codorniz"],
                ["Title": "Petirrojo", "Image": "robin", "Desc_Data": "Petirrojo"],
                ["Title": "Gorrión", "Image": "sparrow", "Desc_Data": "Gorrión"],
                ["Title": "Golondrina", "Image": "swallow", "Desc_Data": "Golondrina"],
                ["Title": "Tucán", "Image": "toucan", "Desc_Data": "Tucán"],
                ["Title": "Buitre", "Image": "vulture", "Desc_Data": "Buitre"],
                ["Title": "Lavandera", "Image": "wagtail", "Desc_Data": "Lavandera"],
                ["Title": "Ampelis", "Image": "waxwing", "Desc_Data": "Ampelis"],
                ["Title": "Pájaro Carpintero", "Image": "woodpecker", "Desc_Data": "Pájaro Carpintero"]
        ]
    }

    func flowerDetailsArray() {
        passArrDataSelected = [
            ["Title": "Lirio de agua", "Image": "arum_lily", "Desc_Data": "Lirio de agua"],
            ["Title": "Aster", "Image": "aster", "Desc_Data": "Aster"],
            ["Title": "Ave del Paraíso", "Image": "bird_of_paradise", "Desc_Data": "Ave del Paraíso"],
            ["Title": "Buganvilla", "Image": "bougainvillea", "Desc_Data": "Buganvilla"],
            ["Title": "Botón de oro", "Image": "buttercup", "Desc_Data": "Botón de oro"],
            ["Title": "Caléndula", "Image": "calendula", "Desc_Data": "Caléndula"],
            ["Title": "Caña", "Image": "canna", "Desc_Data": "Caña"],
            ["Title": "Cresta de gallo", "Image": "cockscomb", "Desc_Data": "Cresta de gallo"],
            ["Title": "Narcisos", "Image": "daffodils", "Desc_Data": "Narcisos"],
            ["Title": "Dalia", "Image": "dahlia", "Desc_Data": "Dalia"],
            ["Title": "Margarita", "Image": "daisy", "Desc_Data": "Margarita"],
            ["Title": "Clavel", "Image": "dianthus", "Desc_Data": "Clavel"],
            ["Title": "Glaïeul", "Image": "gladiolus", "Desc_Data": "Glaïeul"],
            ["Title": "Hibisco", "Image": "hibiscus", "Desc_Data": "Hibisco"],
            ["Title": "Jazmín", "Image": "jasmine", "Desc_Data": "Jazmín"],
            ["Title": "Lavanda", "Image": "lavender", "Desc_Data": "Lavanda"],
            ["Title": "Lila", "Image": "lilac", "Desc_Data": "Lila"],
            ["Title": "Lirio", "Image": "lily", "Desc_Data": "Lirio"],
            ["Title": "Loto", "Image": "lotus", "Desc_Data": "Loto"],
            ["Title": "Gloria de la mañana", "Image": "morning_glory", "Desc_Data": "Gloria de la mañana"],
            ["Title": "Adelfa", "Image": "nerium_oleander", "Desc_Data": "Adelfa"],
            ["Title": "Orquídeas", "Image": "orchids", "Desc_Data": "Orquídeas"],
            ["Title": "Peonía", "Image": "peony", "Desc_Data": "Peonía"],
            ["Title": "Vinca", "Image": "periwinkle", "Desc_Data": "Vinca"],
            ["Title": "Petunia", "Image": "petunia", "Desc_Data": "Petunia"],
            ["Title": "Amapola", "Image": "poppy", "Desc_Data": "Amapola"],
            ["Title": "Malva morada", "Image": "purple_mallow", "Desc_Data": "Malva morada"],
            ["Title": "Rosa", "Image": "rose", "Desc_Data": "Rosa"],
            ["Title": "Girasol", "Image": "sunflower", "Desc_Data": "Girasol"],
            ["Title": "Tulipanes", "Image": "tulips", "Desc_Data": "Tulipanes"]
        ]
    }

    func fruitDetailsArray() {
        passArrDataSelected = [
            ["Title": "Manzana", "Image": "apple", "Desc_Data": "Manzana"],
            ["Title": "Albaricoque", "Image": "apricot", "Desc_Data": "Albaricoque"],
            ["Title": "Aguacate", "Image": "avocado", "Desc_Data": "Aguacate"],
            ["Title": "Mora", "Image": "blackberry", "Desc_Data": "Mora"],
            ["Title": "Grosella negra", "Image": "blackcurrant", "Desc_Data": "Grosella negra"],
            ["Title": "Arándano", "Image": "blueberry", "Desc_Data": "Arándano"],
            ["Title": "Cereza", "Image": "cherry", "Desc_Data": "Cereza"],
            ["Title": "Coco", "Image": "coconut", "Desc_Data": "Coco"],
            ["Title": "Higo", "Image": "fig", "Desc_Data": "Higo"],
            ["Title": "Uva", "Image": "grape", "Desc_Data": "Uva"],
            ["Title": "Kiwi", "Image": "kiwi", "Desc_Data": "Kiwi"],
            ["Title": "Limón", "Image": "lemon", "Desc_Data": "Limón"],
            ["Title": "Lima", "Image": "lime", "Desc_Data": "Lima"],
            ["Title": "Lichi", "Image": "lychee", "Desc_Data": "Lichi"],
            ["Title": "Mango", "Image": "mango", "Desc_Data": "Mango"],
            ["Title": "Nectarina", "Image": "nectarine", "Desc_Data": "Nectarina"],
            ["Title": "Naranja", "Image": "orange", "Desc_Data": "Naranja"],
            ["Title": "Papaya", "Image": "papaya", "Desc_Data": "Papaya"],
            ["Title": "Fruta de la pasión", "Image": "passion", "Desc_Data": "Fruta de la pasión"],
            ["Title": "Melocotón", "Image": "peach", "Desc_Data": "Melocotón"],
            ["Title": "Pera", "Image": "pear", "Desc_Data": "Pera"],
            ["Title": "Piña", "Image": "pineapple", "Desc_Data": "Piña"],
            ["Title": "Ciruela", "Image": "plum", "Desc_Data": "Ciruela"],
            ["Title": "Membrillo", "Image": "quince", "Desc_Data": "Membrillo"],
            ["Title": "Frambuesa", "Image": "raspberry", "Desc_Data": "Frambuesa"],
            ["Title": "Fresa", "Image": "strawberry", "Desc_Data": "Fresa"],
            ["Title": "Sandía", "Image": "watermelon", "Desc_Data": "Sandía"]
        ]
    }


    func monthDetailsArray() {
        passArrDataSelected = [
            ["Title": "Enero", "Image": "january", "Desc_Data": "Enero"],
            ["Title": "Febrero", "Image": "february", "Desc_Data": "Febrero"],
            ["Title": "Marzo", "Image": "march", "Desc_Data": "Marzo"],
            ["Title": "Abril", "Image": "april", "Desc_Data": "Abril"],
            ["Title": "Mayo", "Image": "may", "Desc_Data": "Mayo"],
            ["Title": "Junio", "Image": "june", "Desc_Data": "Junio"],
            ["Title": "Julio", "Image": "july", "Desc_Data": "Julio"],
            ["Title": "Agosto", "Image": "august", "Desc_Data": "Agosto"],
            ["Title": "Septiembre", "Image": "september", "Desc_Data": "Septiembre"],
            ["Title": "Octubre", "Image": "october", "Desc_Data": "Octubre"],
            ["Title": "Noviembre", "Image": "november", "Desc_Data": "Noviembre"],
            ["Title": "Diciembre", "Image": "december", "Desc_Data": "Diciembre"]
        ]
    }

    func vegetableDetailsArray() {
        passArrDataSelected = [
            ["Title": "Espárragos", "Image": "asparagus", "Desc_Data": "Espárragos"],
            ["Title": "Brócoli", "Image": "broccoli", "Desc_Data": "Brócoli"],
            ["Title": "Coles de Bruselas", "Image": "brussels_sprouts", "Desc_Data": "Coles de Bruselas"],
            ["Title": "Zanahoria", "Image": "carrot", "Desc_Data": "Zanahoria"],
            ["Title": "Coliflor", "Image": "cauliflower", "Desc_Data": "Coliflor"],
            ["Title": "Pepino", "Image": "cucumber", "Desc_Data": "Pepino"],
            ["Title": "Berenjena", "Image": "eggplant", "Desc_Data": "Berenjena"],
            ["Title": "Ajo", "Image": "garlic", "Desc_Data": "Ajo"],
            ["Title": "Lechuga", "Image": "lettuce", "Desc_Data": "Lechuga"],
            ["Title": "Menta", "Image": "mint", "Desc_Data": "Menta"],
            ["Title": "Champiñón", "Image": "mushroom", "Desc_Data": "Champiñón"],
            ["Title": "Ocra", "Image": "okra", "Desc_Data": "Ocra"],
            ["Title": "Cebolla", "Image": "onion", "Desc_Data": "Cebolla"],
            ["Title": "Guisantes", "Image": "peaspeas", "Desc_Data": "Guisantes"],
            ["Title": "Patata", "Image": "potato", "Desc_Data": "Patata"],
            ["Title": "Rábano", "Image": "radish", "Desc_Data": "Rábano"],
            ["Title": "Col Roja", "Image": "red_cabbage", "Desc_Data": "Col Roja"],
            ["Title": "Espinaca", "Image": "spinach", "Desc_Data": "Espinaca"],
            ["Title": "Calabaza", "Image": "squash", "Desc_Data": "Calabaza"],
            ["Title": "Judías Verdes", "Image": "string_beans", "Desc_Data": "Judías Verdes"],
            ["Title": "Tomate", "Image": "tomato", "Desc_Data": "Tomate"],
            ["Title": "Nabo", "Image": "turnip", "Desc_Data": "Nabo"]
        ]
    }

    func bodyPartsDetailsArray() {
        passArrDataSelected = [
            ["Title": "Tobillo", "Image": "ankle", "Desc_Data": "Tobillo"],
            ["Title": "Brazo", "Image": "arm", "Desc_Data": "Brazo"],
            ["Title": "Pecho", "Image": "chest", "Desc_Data": "Pecho"],
            ["Title": "Oído", "Image": "ear", "Desc_Data": "Oído"],
            ["Title": "Codo", "Image": "elbow", "Desc_Data": "Codo"],
            ["Title": "Ojo", "Image": "eye", "Desc_Data": "Ojo"],
            ["Title": "Dedos", "Image": "fingers", "Desc_Data": "Dedos"],
            ["Title": "Pie", "Image": "foot", "Desc_Data": "Pie"],
            ["Title": "Cabello", "Image": "hair", "Desc_Data": "Cabello"],
            ["Title": "Rodilla", "Image": "knee", "Desc_Data": "Rodilla"],
            ["Title": "Pierna", "Image": "leg", "Desc_Data": "Pierna"],
            ["Title": "Labios", "Image": "lips", "Desc_Data": "Labios"],
            ["Title": "Boca", "Image": "mouth", "Desc_Data": "Boca"],
            ["Title": "Cuello", "Image": "neck", "Desc_Data": "Cuello"],
            ["Title": "Nariz", "Image": "nose", "Desc_Data": "Nariz"],
            ["Title": "Hombro", "Image": "shoulder", "Desc_Data": "Hombro"],
            ["Title": "Estómago", "Image": "stomach", "Desc_Data": "Estómago"],
            ["Title": "Muslo", "Image": "thigh", "Desc_Data": "Muslo"],
            ["Title": "Pulgar", "Image": "thumb", "Desc_Data": "Pulgar"],
            ["Title": "Dedo del Pie", "Image": "toe", "Desc_Data": "Dedo del Pie"]
        ]
    }

    func clothesDetailsArray() {
        passArrDataSelected = [
            ["Title": "Camisa", "Image": "shirt", "Desc_Data": "Camisa"],
            ["Title": "Zapatos", "Image": "shoes", "Desc_Data": "Zapatos"],
            ["Title": "Pijama", "Image": "pyjamas", "Desc_Data": "Pijama"],
            ["Title": "Calcetín", "Image": "sock", "Desc_Data": "Calcetín"],
            ["Title": "Guantes", "Image": "gloves", "Desc_Data": "Guantes"],
            ["Title": "Falda", "Image": "skirt", "Desc_Data": "Falda"],
            ["Title": "Zapatilla", "Image": "slipper", "Desc_Data": "Zapatilla"],
            ["Title": "Suéter", "Image": "sweater", "Desc_Data": "Suéter"],
            ["Title": "Bata de Baño", "Image": "bathrobe", "Desc_Data": "Bata de Baño"],
            ["Title": "Jeans", "Image": "jeans", "Desc_Data": "Jeans"],
            ["Title": "Bota", "Image": "boot", "Desc_Data": "Bota"],
            ["Title": "Vestido", "Image": "dress", "Desc_Data": "Vestido"],
            ["Title": "Overol", "Image": "overalls", "Desc_Data": "Overol"],
            ["Title": "Shorts", "Image": "shorts", "Desc_Data": "Shorts"],
            ["Title": "Chaqueta", "Image": "jacket", "Desc_Data": "Chaqueta"],
            ["Title": "Bufanda", "Image": "scarf", "Desc_Data": "Bufanda"],
            ["Title": "Cinturón", "Image": "belt", "Desc_Data": "Cinturón"],
            ["Title": "Sombrero", "Image": "hat", "Desc_Data": "Sombrero"],
            ["Title": "Gafas", "Image": "glasses", "Desc_Data": "Gafas"],
            ["Title": "Traje", "Image": "suit", "Desc_Data": "Traje"]
        ]
    }

    func countryDetailsArray() {
        passArrDataSelected = [
            ["Title": "Argentina", "Image": "argentina", "Desc_Data": "Argentina"],
            ["Title": "Austria", "Image": "austria", "Desc_Data": "Austria"],
            ["Title": "Bélgica", "Image": "belgium", "Desc_Data": "Bélgica"],
            ["Title": "Brasil", "Image": "brazil", "Desc_Data": "Brasil"],
            ["Title": "Camboya", "Image": "cambodia", "Desc_Data": "Camboya"],
            ["Title": "Canadá", "Image": "canada", "Desc_Data": "Canadá"],
            ["Title": "Croacia", "Image": "croatia", "Desc_Data": "Croacia"],
            ["Title": "Cuba", "Image": "cuba", "Desc_Data": "Cuba"],
            ["Title": "Dinamarca", "Image": "denmark", "Desc_Data": "Dinamarca"],
            ["Title": "Inglaterra", "Image": "england", "Desc_Data": "Inglaterra"],
            ["Title": "Francia", "Image": "france", "Desc_Data": "Francia"],
            ["Title": "Alemania", "Image": "germany", "Desc_Data": "Alemania"],
            ["Title": "Grecia", "Image": "greece", "Desc_Data": "Grecia"],
            ["Title": "India", "Image": "indian", "Desc_Data": "India"],
            ["Title": "Indonesia", "Image": "indonesia", "Desc_Data": "Indonesia"],
            ["Title": "Italia", "Image": "italy", "Desc_Data": "Italia"],
            ["Title": "Japón", "Image": "japan", "Desc_Data": "Japón"],
            ["Title": "Laos", "Image": "laos", "Desc_Data": "Laos"],
            ["Title": "Malasia", "Image": "malaysia", "Desc_Data": "Malasia"],
            ["Title": "México", "Image": "mexico", "Desc_Data": "México"],
            ["Title": "Myanmar", "Image": "myanmar", "Desc_Data": "Myanmar"],
            ["Title": "Países Bajos", "Image": "netherlands", "Desc_Data": "Países Bajos"],
            ["Title": "Pakistán", "Image": "pakistan", "Desc_Data": "Pakistán"],
            ["Title": "Filipinas", "Image": "philippine", "Desc_Data": "Filipinas"],
            ["Title": "Portugal", "Image": "portugal", "Desc_Data": "Portugal"],
            ["Title": "Rusia", "Image": "russia", "Desc_Data": "Rusia"],
            ["Title": "Arabia Saudita", "Image": "saudi_arabia", "Desc_Data": "Arabia Saudita"],
            ["Title": "Singapur", "Image": "singapore", "Desc_Data": "Singapur"],
            ["Title": "Corea del Sur", "Image": "south_korea", "Desc_Data": "Corea del Sur"],
            ["Title": "España", "Image": "spain", "Desc_Data": "España"],
            ["Title": "Suecia", "Image": "sweden", "Desc_Data": "Suecia"],
            ["Title": "Tailandia", "Image": "thailand", "Desc_Data": "Tailandia"],
            ["Title": "Estados Unidos", "Image": "united_states", "Desc_Data": "Estados Unidos"],
            ["Title": "Vietnam", "Image": "vietnam", "Desc_Data": "Vietnam"]
        ]
    }

    func foodDetailsArray() {
        passArrDataSelected = [
            ["Title": "Pizza", "Image": "pizza", "Desc_Data": "Pizza"],
            ["Title": "Galletas", "Image": "biscuits", "Desc_Data": "Galletas"],
            ["Title": "Patatas Fritas", "Image": "chip", "Desc_Data": "Patatas Fritas"],
            ["Title": "Pastel", "Image": "cake", "Desc_Data": "Pastel"],
            ["Title": "Fideos", "Image": "noodles", "Desc_Data": "Fideos"],
            ["Title": "Agua", "Image": "water", "Desc_Data": "Agua"],
            ["Title": "Sándwich", "Image": "sandwich", "Desc_Data": "Sándwich"],
            ["Title": "Helado", "Image": "ice_cream", "Desc_Data": "Helado"],
            ["Title": "Cerveza", "Image": "beer", "Desc_Data": "Cerveza"],
            ["Title": "Hamburguesa", "Image": "hamburger", "Desc_Data": "Hamburguesa"],
            ["Title": "Té", "Image": "tea", "Desc_Data": "Té"],
            ["Title": "Jamón", "Image": "ham", "Desc_Data": "Jamón"],
            ["Title": "Yogur", "Image": "yogurt", "Desc_Data": "Yogur"],
            ["Title": "Chocolate", "Image": "chocolate", "Desc_Data": "Chocolate"],
            ["Title": "Arroz", "Image": "rice", "Desc_Data": "Arroz"],
            ["Title": "Refresco", "Image": "soda", "Desc_Data": "Refresco"],
            ["Title": "Jugo", "Image": "juice", "Desc_Data": "Jugo"],
            ["Title": "Café", "Image": "coffee", "Desc_Data": "Café"],
            ["Title": "Pan", "Image": "bread", "Desc_Data": "Pan"],
            ["Title": "Sopa", "Image": "soup", "Desc_Data": "Sopa"],
            ["Title": "Mantequilla", "Image": "butter", "Desc_Data": "Mantequilla"],
            ["Title": "Queso", "Image": "cheese", "Desc_Data": "Queso"],
            ["Title": "Leche", "Image": "milk", "Desc_Data": "Leche"]
        ]
    }

    func geometryDetailsArray() {
        passArrDataSelected = [
            ["Title": "Flecha", "Image": "arrow", "Desc_Data": "Flecha"],
            ["Title": "Círculo", "Image": "circle", "Desc_Data": "Círculo"],
            ["Title": "Cono", "Image": "cone", "Desc_Data": "Cono"],
            ["Title": "Crescente", "Image": "crescent", "Desc_Data": "Crescente"],
            ["Title": "Cubo", "Image": "cube", "Desc_Data": "Cubo"],
            ["Title": "Cuboide", "Image": "cuboid", "Desc_Data": "Cuboide"],
            ["Title": "Cilindro", "Image": "cylinder", "Desc_Data": "Cilindro"],
            ["Title": "Diamante", "Image": "diamond", "Desc_Data": "Diamante"],
            ["Title": "Corazón", "Image": "heart", "Desc_Data": "Corazón"],
            ["Title": "Hexágono", "Image": "hexagon", "Desc_Data": "Hexágono"],
            ["Title": "Óvalo", "Image": "oval", "Desc_Data": "Óvalo"],
            ["Title": "Paralelogramo", "Image": "parallelogram", "Desc_Data": "Paralelogramo"],
            ["Title": "Pentágono", "Image": "pentagon", "Desc_Data": "Pentágono"],
            ["Title": "Pirámide", "Image": "pyramid", "Desc_Data": "Pirámide"],
            ["Title": "Rectángulo", "Image": "rectangle", "Desc_Data": "Rectángulo"],
            ["Title": "Esfera", "Image": "sphere", "Desc_Data": "Esfera"],
            ["Title": "Estrella", "Image": "star", "Desc_Data": "Estrella"],
            ["Title": "Trapecio", "Image": "trapezoid", "Desc_Data": "Trapecio"],
            ["Title": "Triángulo", "Image": "triangle", "Desc_Data": "Triángulo"]
        ]
    }

    func houseDetailsArray() {
        passArrDataSelected = [
            ["Title": "Estantería", "Image": "bookcase", "Desc_Data": "Estantería"],
            ["Title": "Silla", "Image": "chair", "Desc_Data": "Silla"],
            ["Title": "Periódico", "Image": "newspaper", "Desc_Data": "Periódico"],
            ["Title": "Sofá", "Image": "sofa", "Desc_Data": "Sofá"],
            ["Title": "Cuadro", "Image": "picture", "Desc_Data": "Cuadro"],
            ["Title": "Reloj", "Image": "watch", "Desc_Data": "Reloj"],
            ["Title": "Cepillo", "Image": "brush", "Desc_Data": "Cepillo"],
            ["Title": "Televisión", "Image": "television", "Desc_Data": "Televisión"],
            ["Title": "Mesa", "Image": "table", "Desc_Data": "Mesa"],
            ["Title": "Moneda", "Image": "coin", "Desc_Data": "Moneda"],
            ["Title": "Teléfono", "Image": "phone", "Desc_Data": "Teléfono"],
            ["Title": "Taburete de Bar", "Image": "bar_stool", "Desc_Data": "Taburete de Bar"],
            ["Title": "Laptop", "Image": "laptop", "Desc_Data": "Laptop"],
            ["Title": "Espejo", "Image": "mirror", "Desc_Data": "Espejo"],
            ["Title": "Tijeras", "Image": "scissors", "Desc_Data": "Tijeras"],
            ["Title": "Paraguas", "Image": "umbrella", "Desc_Data": "Paraguas"],
            ["Title": "Reloj de Pared", "Image": "clock", "Desc_Data": "Reloj de Pared"],
            ["Title": "Cubo", "Image": "bucket", "Desc_Data": "Cubo"],
            ["Title": "Taza", "Image": "cup", "Desc_Data": "Taza"],
            ["Title": "Llave", "Image": "key", "Desc_Data": "Llave"],
            ["Title": "Puerta", "Image": "door", "Desc_Data": "Puerta"],
            ["Title": "Vaso", "Image": "glass", "Desc_Data": "Vaso"],
            ["Title": "Sillón", "Image": "armchair", "Desc_Data": "Sillón"],
            ["Title": "Ventana", "Image": "window", "Desc_Data": "Ventana"],
            ["Title": "Cuchillo", "Image": "knife", "Desc_Data": "Cuchillo"],
            ["Title": "Billetera", "Image": "wallet", "Desc_Data": "Billetera"],
            ["Title": "Botella", "Image": "bottle", "Desc_Data": "Botella"],
            ["Title": "Teléfono Móvil", "Image": "mobile_phone", "Desc_Data": "Teléfono Móvil"],
            ["Title": "Cama", "Image": "bed", "Desc_Data": "Cama"],
            ["Title": "Candado", "Image": "lock", "Desc_Data": "Candado"]
        ]
    }

    func jobsDetailsArray() {
        passArrDataSelected = [
            ["Title": "Contador", "Image": "accountant", "Desc_Data": "Contador"],
            ["Title": "Arquitecto", "Image": "architect", "Desc_Data": "Arquitecto"],
            ["Title": "Astrónomo", "Image": "astronomer", "Desc_Data": "Astrónomo"],
            ["Title": "Autor", "Image": "author", "Desc_Data": "Autor"],
            ["Title": "Panadero", "Image": "baker", "Desc_Data": "Panadero"],
            ["Title": "Albañil", "Image": "bricklayer", "Desc_Data": "Albañil"],
            ["Title": "Carnicero", "Image": "butcher", "Desc_Data": "Carnicero"],
            ["Title": "Carpintero", "Image": "carpenter", "Desc_Data": "Carpintero"],
            ["Title": "Chef", "Image": "chef", "Desc_Data": "Chef"],
            ["Title": "Limpiador", "Image": "cleaner", "Desc_Data": "Limpiador"],
            ["Title": "Dentista", "Image": "dentist", "Desc_Data": "Dentista"],
            ["Title": "Doctor", "Image": "doctor", "Desc_Data": "Doctor"],
            ["Title": "Conductor", "Image": "driver", "Desc_Data": "Conductor"],
            ["Title": "Basurero", "Image": "dustman", "Desc_Data": "Basurero"],
            ["Title": "Electricista", "Image": "electrician", "Desc_Data": "Electricista"],
            ["Title": "Ingeniero", "Image": "engineer", "Desc_Data": "Ingeniero"],
            ["Title": "Granjero", "Image": "farmer", "Desc_Data": "Granjero"],
            ["Title": "Bombero", "Image": "firefighter", "Desc_Data": "Bombero"],
            ["Title": "Florista", "Image": "florist", "Desc_Data": "Florista"],
            ["Title": "Jardinero", "Image": "gardener", "Desc_Data": "Jardinero"],
            ["Title": "Peluquero", "Image": "hairdresser", "Desc_Data": "Peluquero"],
            ["Title": "Periodista", "Image": "journalist", "Desc_Data": "Periodista"],
            ["Title": "Juez", "Image": "judge", "Desc_Data": "Juez"],
            ["Title": "Abogado", "Image": "lawyer", "Desc_Data": "Abogado"],
            ["Title": "Conferencista", "Image": "lecturer", "Desc_Data": "Conferencista"],
            ["Title": "Bibliotecario", "Image": "librarian", "Desc_Data": "Bibliotecario"],
            ["Title": "Salvavidas", "Image": "lifeguard", "Desc_Data": "Salvavidas"],
            ["Title": "Mecánico", "Image": "mechanics", "Desc_Data": "Mecánico"],
            ["Title": "Enfermero", "Image": "nurse", "Desc_Data": "Enfermero"],
            ["Title": "Óptico", "Image": "optician", "Desc_Data": "Óptico"],
            ["Title": "Pintor", "Image": "painter", "Desc_Data": "Pintor"],
            ["Title": "Farmacéutico", "Image": "pharmacist", "Desc_Data": "Farmacéutico"],
            ["Title": "Fotógrafo", "Image": "photographer", "Desc_Data": "Fotógrafo"],
            ["Title": "Piloto", "Image": "pilot", "Desc_Data": "Piloto"],
            ["Title": "Fontanero", "Image": "plumber", "Desc_Data": "Fontanero"],
            ["Title": "Recepcionista", "Image": "receptionist", "Desc_Data": "Recepcionista"],
            ["Title": "Científico", "Image": "scientist", "Desc_Data": "Científico"],
            ["Title": "Soldado", "Image": "soldier", "Desc_Data": "Soldado"],
            ["Title": "Estudiante", "Image": "student", "Desc_Data": "Estudiante"],
            ["Title": "Sastre", "Image": "tailor", "Desc_Data": "Sastre"],
            ["Title": "Guardia de Tráfico", "Image": "traffic_warden", "Desc_Data": "Guardia de Tráfico"],
            ["Title": "Veterinario", "Image": "veterinarian", "Desc_Data": "Veterinario"],
            ["Title": "Camarero", "Image": "waiter", "Desc_Data": "Camarero"],
            ["Title": "Soldador", "Image": "welder", "Desc_Data": "Soldador"]
        ]
    }

    func schoolDetailsArray() {
        passArrDataSelected = [
            ["Title": "Pizarra", "Image": "board", "Desc_Data": "Pizarra"],
            ["Title": "Libro", "Image": "book", "Desc_Data": "Libro"],
            ["Title": "Silla", "Image": "chair", "Desc_Data": "Silla"],
            ["Title": "Compás", "Image": "compass", "Desc_Data": "Compás"],
            ["Title": "Computadora", "Image": "computer", "Desc_Data": "Computadora"],
            ["Title": "Escritorio", "Image": "desk", "Desc_Data": "Escritorio"],
            ["Title": "Diccionario", "Image": "dictionary", "Desc_Data": "Diccionario"],
            ["Title": "Borrador", "Image": "eraser", "Desc_Data": "Borrador"],
            ["Title": "Globo", "Image": "globe", "Desc_Data": "Globo"],
            ["Title": "Mapa", "Image": "map", "Desc_Data": "Mapa"],
            ["Title": "Cuaderno", "Image": "notebook", "Desc_Data": "Cuaderno"],
            ["Title": "Pluma", "Image": "pen", "Desc_Data": "Pluma"],
            ["Title": "Lápiz", "Image": "pencil", "Desc_Data": "Lápiz"],
            ["Title": "Regla", "Image": "ruler", "Desc_Data": "Regla"],
            ["Title": "Mochila", "Image": "school_bag", "Desc_Data": "Mochila"],
            ["Title": "Profesor", "Image": "teacher", "Desc_Data": "Profesor"]
        ]
    }

    func sportsDetailsArray() {
        passArrDataSelected = [
            ["Title": "Ajedrez", "Image": "chess", "Desc_Data": "Ajedrez"],
            ["Title": "Windsurf", "Image": "windsurfing", "Desc_Data": "Windsurf"],
            ["Title": "Bolos", "Image": "bowling", "Desc_Data": "Bolos"],
            ["Title": "Karate", "Image": "karate", "Desc_Data": "Karate"],
            ["Title": "Patinaje sobre Hielo", "Image": "ice_skating", "Desc_Data": "Patinaje sobre Hielo"],
            ["Title": "Tenis de Mesa", "Image": "table_tennis", "Desc_Data": "Tenis de Mesa"],
            ["Title": "Bádminton", "Image": "badminton", "Desc_Data": "Bádminton"],
            ["Title": "Natación", "Image": "swimming", "Desc_Data": "Natación"],
            ["Title": "Fútbol", "Image": "football", "Desc_Data": "Fútbol"],
            ["Title": "Hockey", "Image": "hockey", "Desc_Data": "Hockey"],
            ["Title": "Equitación", "Image": "equestrian", "Desc_Data": "Equitación"],
            ["Title": "Ciclismo", "Image": "cycling", "Desc_Data": "Ciclismo"],
            ["Title": "Clavados", "Image": "diving", "Desc_Data": "Clavados"],
            ["Title": "Judo", "Image": "judo", "Desc_Data": "Judo"],
            ["Title": "Golf", "Image": "golf", "Desc_Data": "Golf"],
            ["Title": "Béisbol", "Image": "baseball", "Desc_Data": "Béisbol"],
            ["Title": "Voleibol", "Image": "volleyball", "Desc_Data": "Voleibol"],
            ["Title": "Surf", "Image": "surfing", "Desc_Data": "Surf"],
            ["Title": "Skateboarding", "Image": "skateboarding", "Desc_Data": "Skateboarding"],
            ["Title": "Esquí", "Image": "skiing", "Desc_Data": "Esquí"],
            ["Title": "Tiro con Arco", "Image": "archery", "Desc_Data": "Tiro con Arco"],
            ["Title": "Canoa", "Image": "canoeing", "Desc_Data": "Canoa"],
            ["Title": "Carrera", "Image": "running", "Desc_Data": "Carrera"],
            ["Title": "Billar", "Image": "billiards", "Desc_Data": "Billar"],
            ["Title": "Esgrima", "Image": "fencing", "Desc_Data": "Esgrima"],
            ["Title": "Tenis", "Image": "tennis", "Desc_Data": "Tenis"],
            ["Title": "Baloncesto", "Image": "basketball", "Desc_Data": "Baloncesto"]
        ]
    }

    func vehicleDetailsArray() {
        passArrDataSelected = [
            ["Title": "Ambulancia", "Image": "ambulance", "Desc_Data": "Ambulancia"],
            ["Title": "Bicicleta", "Image": "bike", "Desc_Data": "Bicicleta"],
            ["Title": "Barco", "Image": "boat", "Desc_Data": "Barco"],
            ["Title": "Autobús", "Image": "bus", "Desc_Data": "Autobús"],
            ["Title": "Coche", "Image": "car", "Desc_Data": "Coche"],
            ["Title": "Camión Contenedor", "Image": "container_truck", "Desc_Data": "Camión Contenedor"],
            ["Title": "Camión de Bomberos", "Image": "fire_truck", "Desc_Data": "Camión de Bomberos"],
            ["Title": "Helicóptero", "Image": "helicopter", "Desc_Data": "Helicóptero"],
            ["Title": "Motocicleta", "Image": "motorbike", "Desc_Data": "Motocicleta"],
            ["Title": "Avión", "Image": "plane", "Desc_Data": "Avión"],
            ["Title": "Coche de Policía", "Image": "police_car", "Desc_Data": "Coche de Policía"],
            ["Title": "Barco", "Image": "ship", "Desc_Data": "Barco"],
            ["Title": "Metro", "Image": "subway", "Desc_Data": "Metro"],
            ["Title": "Tren", "Image": "train", "Desc_Data": "Tren"],
            ["Title": "Camión", "Image": "truck", "Desc_Data": "Camión"]
        ]
    }

}
