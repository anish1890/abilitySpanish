//
//  PlayVideoVC.swift
//  KidsLogic
//
//  Created by MAC  on 20/01/2024.
//

import UIKit
import youtube_ios_player_helper
import SDWebImage

class PlayVideoVC: UIViewController, YTPlayerViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var tblVideo: UITableView!

    var selectedVidId: String = ""
    var getVideoArray: [[String: Any]] = []
    var selectedVideoIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "VideoPlayerTblCell", bundle: nil)
        tblVideo.register(cellNib, forCellReuseIdentifier: "VideoPlayerTblCell")

        playerView.delegate = self

        let playerVars: [String: Any] = [
            "playsinline": 1
        ]
        playerView.load(withVideoId: selectedVidId, playerVars: playerVars)
    }

    // MARK: - YTPlayerViewDelegate

    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            print("Started playback")
        case .paused:
            print("Paused playback")
        default:
            break
        }
    }

    // MARK: - UITableViewDelegate and UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getVideoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayerTblCell", for: indexPath) as! VideoPlayerTblCell

        cell.videoPlayerView.layer.cornerRadius = 10

        cell.lblVideoTitle.text = getVideoArray[indexPath.row]["Title"] as? String
        if let vidId = getVideoArray[indexPath.row]["VideoId"] as? String {
            let youtubeURL = URL(string: "http://img.youtube.com/vi/\(vidId)/0.jpg")
            cell.imgVideo.sd_setImage(with: youtubeURL, placeholderImage: UIImage(named: "default_video_desc"))
        }

        cell.videoPlayerView.clipsToBounds = true
        cell.imgVideo.clipsToBounds = true

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playerView.delegate = self
        let playerVars: [String: Any] = ["playsinline": 1]
        if let videoId = getVideoArray[indexPath.row]["VideoId"] as? String {
            playerView.load(withVideoId: videoId, playerVars: playerVars)
        }
    }
}


