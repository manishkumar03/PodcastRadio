//
//  ViewController.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-03.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

/// Parsed RSS feeds for the podcasts. This is what gets stored in the user defaults.
var parsedPodcastChannels = [PodcastChannelLayout]()

/// The list of podcasts URLs to which the user has subscribed
var urlPodcasts = [String]()

/// Internet connection status
var connectedToInternet = false

/// Are you subscribed to any podcasts
var subscribedYet = false

/// the global player object.
var player: AVPlayer?

/// In case we want to refresh the feed by using the pull-down method.
let pullToRefresh = UIRefreshControl()

class ChannelListVC: UITableViewController {
    //let storageDefault = UserDefaults.standard
    
    override func viewDidLoad()
    {
        //print("viewDidLoad called")
        super.viewDidLoad()
        setupChannelListTableView()
        connectedToInternet = checkInternetConnection()
        
        getStoredURLList()
        if urlPodcasts.count > 0 {
            subscribedYet = true
            getStoredChannelData()
        } else {
            if connectedToInternet {
                let startDate = Date()
                processDefaultURLs()
                let endDate = Date()
                let timeInterval = endDate.timeIntervalSince(startDate)
                print("Default URL seconds:  \(timeInterval)")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //print("viewDidAppear")
        if subscribedYet == false {
            showMessageNoPodcastsFound()
        }
        
//        if connectedToInternet == false {
//            showErrorAlertInternetConection()
//        }
    }


}
