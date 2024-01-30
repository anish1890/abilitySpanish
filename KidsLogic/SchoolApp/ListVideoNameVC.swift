//
//  ListVideoNameVC.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//

import UIKit

class ListVideoNameVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblVideoList: UITableView!

    var arrVideoList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "VideoListTableViewCell", bundle: nil)
        tblVideoList.register(cellNib, forCellReuseIdentifier: "VideoListTableViewCell")

        arrVideoList = ["ABC Songs", "Number Songs", "Color Songs", "Animal Songs", "Shape Songs", "Vehicle Songs", "Fruit Songs", "Vegetable Songs", "Day Songs", "Month Songs", "Clothes Songs"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrVideoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! videoListTableViewCell

        cell.mainVideoView.layer.cornerRadius = 7
        cell.lblVideoName.text = arrVideoList[indexPath.row]
        cell.mainVideoView.clipsToBounds = true

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VideoThumbListVC") as! VideoThumbListVC
        vc.selectedVideoCat = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
