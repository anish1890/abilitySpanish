//
//  mainCatTableViewCell.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//

import UIKit

class mainCatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMainCAt: UIImageView!
    @IBOutlet weak var catName : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
