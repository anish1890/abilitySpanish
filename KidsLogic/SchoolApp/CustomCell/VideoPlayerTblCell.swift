//
//  VideoPlayerTblCell.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//

import UIKit

class VideoPlayerTblCell: UITableViewCell {
    
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var imgVideo: UIImageView!
    @IBOutlet weak var lblVideoTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}