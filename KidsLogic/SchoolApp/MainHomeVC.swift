//
//  MainHomeVC.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//

import UIKit


class MainHomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tblMainMenu: UITableView!

    var arrMaincat = ["card_one", "card_two", "card_three", "card_four"]
    var arrMainName = ["Kids Learning","Video learning","Look & Choose","Listen & Guess"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let cellNib = UINib(nibName: "mainCatTableViewCell", bundle: nil)
//        tblMainMenu.register(cellNib, forCellReuseIdentifier: "mainCatTableViewCell")
        
        title = GlobleConstants.PRE_SCHOOL_TITLE
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMaincat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCatTableViewCell", for: indexPath) as! mainCatTableViewCell
        cell.imgMainCAt.layer.cornerRadius = 12
        cell.imgMainCAt.image = UIImage(named: arrMaincat[indexPath.row])
        cell.imgMainCAt.clipsToBounds = true
        cell.catName.text = arrMainName[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openHomePage(indexVal: indexPath.row)
    }
    
    func openHomePage(indexVal: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! SchoolHomeVC
        vc.selectedMainCat = indexVal
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


