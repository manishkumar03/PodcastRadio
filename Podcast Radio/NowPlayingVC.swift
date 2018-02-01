//
//  NowPlayingVC.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-11-02.
//  Copyright © 2017 Manish Kumar. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable class NowPlayingVC: UIViewController {
    
    @IBOutlet weak var whiteRoundedView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    var playerCurrentTime = 0.0
    var currentlyPlayingURL = URL(string: "dummyString")
    var enclosureURL = URL(string: "dummyString")
    let episodeName:String = ""
    
    let padding: CGFloat = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        let notification = NSNotification.Name(rawValue: "player")
        notificationCenter.addObserver(self, selector: #selector(updatePlayer), name: notification, object: nil)
        
        let viewHeight = UIScreen.main.bounds.height
        let viewWidth = UIScreen.main.bounds.width
        self.view.backgroundColor = UIColor(red: 0.6, green: 0.7882, blue: 0.4314, alpha: 0.4)
        
        /*---whiteRoundedView---
         Add a background view to the play button. */
        
        whiteRoundedView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: padding)
        
        let top01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: padding)
        
        let height01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)
        
        //let width01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: viewWidth - 2*padding)
        
        let trailing01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -1*padding)
        
        self.view.addConstraints([leading01, top01, height01, trailing01])
        
        whiteRoundedView.layer.backgroundColor = UIColor.white.cgColor
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 6.0
        whiteRoundedView.layer.shadowOffset = CGSize(width:-4, height:4)
        whiteRoundedView.layer.shadowOpacity = 0.3
        
        self.view.sendSubview(toBack: whiteRoundedView)
        
        /*---playPauseButton---
         Play and Pause button. */
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.layer.cornerRadius = 6.0
        playPauseButton.layer.masksToBounds = false
        playPauseButton.backgroundColor = UIColor.orange
        playPauseButton.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
        
        if let playerSafe = player {
            if (playerSafe.rate != 0) {
                playPauseButton.setBackgroundImage(UIImage(named: "pause.png"), for: .normal)
            }
        }
        
        let centerX02 = NSLayoutConstraint(item: playPauseButton, attribute: .centerX, relatedBy: .equal, toItem: whiteRoundedView, attribute: .centerX, multiplier: 1, constant: 0)
        
        let centerY02 = NSLayoutConstraint(item: playPauseButton, attribute: .centerY, relatedBy: .equal, toItem: whiteRoundedView, attribute: .centerY, multiplier: 1, constant: 0)
        
        let height02 = NSLayoutConstraint(item: playPauseButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: whiteRoundedView.frame.height/3)
        
        let width02 = NSLayoutConstraint(item: playPauseButton, attribute: .width, relatedBy: .equal, toItem: playPauseButton, attribute: .height, multiplier: 1, constant: 0)
        
        self.view.addConstraints([centerX02, centerY02, height02, width02])
        playPauseButton.setTitle(nil, for: .normal)
        
        /*---forwardButton---
         Forward by 30 seconds. */
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.layer.cornerRadius = 6.0
        forwardButton.layer.masksToBounds = false
        forwardButton.backgroundColor = UIColor.orange
        forwardButton.setBackgroundImage(UIImage(named: "forward_30.png"), for: .normal)
        let centerY03 = NSLayoutConstraint(item: forwardButton, attribute: .centerY, relatedBy: .equal, toItem: whiteRoundedView, attribute: .centerY, multiplier: 1, constant: 0)
        
        let leading03 = NSLayoutConstraint(item: forwardButton, attribute: .leading, relatedBy: .equal, toItem: playPauseButton, attribute: .trailing, multiplier: 1, constant: Constants.padding)
        
        let height03 = NSLayoutConstraint(item: forwardButton, attribute: .height, relatedBy: .equal, toItem: playPauseButton, attribute: .height, multiplier: 0.75, constant: 0)
        
        let width03 = NSLayoutConstraint(item: forwardButton, attribute: .width, relatedBy: .equal, toItem: forwardButton, attribute: .height, multiplier: 1, constant: 0)
        
        self.view.addConstraints([centerY03, leading03, height03, width03])
        forwardButton.setTitle(nil, for: .normal)
        
        /*---rewindButton---
         Rewind by 30 seconds. */
        rewindButton.translatesAutoresizingMaskIntoConstraints = false
        rewindButton.layer.cornerRadius = 6.0
        rewindButton.layer.masksToBounds = false
        rewindButton.backgroundColor = UIColor.orange
        rewindButton.setBackgroundImage(UIImage(named: "replay_30.png"), for: .normal)
        let centerY04 = NSLayoutConstraint(item: rewindButton, attribute: .centerY, relatedBy: .equal, toItem: whiteRoundedView, attribute: .centerY, multiplier: 1, constant: 0)
        
        let leading04 = NSLayoutConstraint(item: rewindButton, attribute: .trailing, relatedBy: .equal, toItem: playPauseButton, attribute: .leading, multiplier: 1, constant: -1*Constants.padding)
        
        let height04 = NSLayoutConstraint(item: rewindButton, attribute: .height, relatedBy: .equal, toItem: playPauseButton, attribute: .height, multiplier: 0.75, constant: 0)
        
        let width04 = NSLayoutConstraint(item: rewindButton, attribute: .width, relatedBy: .equal, toItem: forwardButton, attribute: .height, multiplier: 1, constant: 0)
        
        self.view.addConstraints([centerY04, leading04, height04, width04])
        rewindButton.setTitle(nil, for: .normal)
        
        
        /*---episodeNameLabel---
         Show the episode name. */
        episodeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeNameLabel.backgroundColor = UIColor.white
        episodeNameLabel.textAlignment = .center
        episodeNameLabel.adjustsFontSizeToFitWidth = false
        
        episodeNameLabel.font = UIFont(name: "Avenir-Book", size:13.0)
        episodeNameLabel.textColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        
        let leading06 = NSLayoutConstraint(item: episodeNameLabel, attribute: .leading, relatedBy: .equal, toItem: whiteRoundedView, attribute: .leading, multiplier: 1, constant: 4)
        
        let top06 = NSLayoutConstraint(item: episodeNameLabel, attribute: .top, relatedBy: .equal, toItem: whiteRoundedView, attribute: .top, multiplier: 1, constant: 1)
        
        let bottom06 = NSLayoutConstraint(item: episodeNameLabel, attribute: .bottom, relatedBy: .equal, toItem: playPauseButton, attribute: .top, multiplier: 1, constant: -1)
        
        let trailing06 = NSLayoutConstraint(item: episodeNameLabel, attribute: .trailing, relatedBy: .equal, toItem: whiteRoundedView, attribute: .trailing, multiplier: 1, constant: -4)
        
        self.view.addConstraints([leading06, top06, bottom06, trailing06])
        episodeNameLabel.text = "  "
    }
    
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        
        if let playerSafe = player {
            playerCurrentTime = CMTimeGetSeconds((playerSafe.currentTime()))
            let asset = playerSafe.currentItem?.asset
            if let urlAsset = asset as? AVURLAsset {
                currentlyPlayingURL = urlAsset.url
            }
        }

        if let playerSafe = player {
            if playerSafe.rate == 0 {
                playerSafe.play()
                playPauseButton.setBackgroundImage(UIImage(named: "pause.png"), for: .normal)
            } else {
                playerSafe.pause()
                playPauseButton.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
            }
        }
        

    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        
        if let playerSafe = player {
            playerCurrentTime = CMTimeGetSeconds((playerSafe.currentTime()))
            let asset = playerSafe.currentItem?.asset
            if let urlAsset = asset as? AVURLAsset {
                currentlyPlayingURL = urlAsset.url
            }
        }
            let jumpToSeconds = playerCurrentTime + Constants.seekDuration
            let newTime: CMTime = CMTimeMake(Int64(jumpToSeconds), 1)
            player?.seek(to: newTime)
    }
    
    @IBAction func rewindButtonPressed(_ sender: UIButton) {
        
        if let playerSafe = player {
            playerCurrentTime = CMTimeGetSeconds((playerSafe.currentTime()))
            let asset = playerSafe.currentItem?.asset
            if let urlAsset = asset as? AVURLAsset {
                currentlyPlayingURL = urlAsset.url
            }
        }
            let jumpToSeconds = playerCurrentTime - Constants.seekDuration
            let newTime: CMTime = CMTimeMake(Int64(jumpToSeconds), 1)
            player?.seek(to: newTime)        
    }
    
    func updatePlayer(notification: Notification) {
        
        if let playerSafe = player {
            playerCurrentTime = CMTimeGetSeconds((playerSafe.currentTime()))
            let asset = playerSafe.currentItem?.asset
            if let urlAsset = asset as? AVURLAsset {
                currentlyPlayingURL = urlAsset.url
            }
        }
        
        if player?.rate == 0 {
            //player!.play()
            playPauseButton.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
        } else {
            //player!.pause()
            playPauseButton.setBackgroundImage(UIImage(named: "pause.png"), for: .normal)
        }
        
        let episodeName = notification.userInfo!["episodeName"] as! String
        episodeNameLabel.text = episodeName
        playPauseButton.setNeedsLayout()
    }
    
}
