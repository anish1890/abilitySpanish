//
//  StageCell.swift
//  WordPuzzle
//
//  Created by Chirag Gujarati on 07/05/22.
//

import UIKit

class StageCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var lblStageNumber: UILabel!
    @IBOutlet weak var imgStageOpen: UIImageView!
    
    //MARK: - Override Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
