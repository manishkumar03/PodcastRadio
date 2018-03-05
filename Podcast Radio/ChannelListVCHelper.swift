//
//  ChannelListVCHelperFunctions.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-07.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import Foundation
import UIKit

extension ChannelListVC {

    
    /**
    Do the initial setup for the ChannelList table view. It will set the title, add the left and right bar buttons, and set up the pull-to-refresh control.
     - Parameter None
     - Returns: None
     */
    func setupChannelListTableView() {
        // Set the application title with Avenir-Book font. Also, change the color of the left and right bar buttons.
        title = "Podcast Radio"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Book", size: 20)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.6, green: 0.7882, blue: 0.4314, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = UIColor.white        
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.orange
        
        // Register the custom cell class for the channel cell.
        tableView.register(ChannelListCellUI.self, forCellReuseIdentifier: "channelListCell")
        
        // Add the button to prompt for podcast URL
        let rightBarButtonItemPrompt = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForPodcastURL))

        // Add the button to refresh the feed
        let rightBarButtonItemRefresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshAllFeeds))
        
        navigationItem.rightBarButtonItems = [rightBarButtonItemPrompt, rightBarButtonItemRefresh]
        
        let leftBarButtonItemAbout = UIBarButtonItem(title: "About", style: .done, target: self, action: #selector(showAboutScreen))
        navigationItem.leftBarButtonItem = leftBarButtonItemAbout
        
        // Add pull-to-refresh control
        tableView.addSubview(pullToRefresh)
        pullToRefresh.attributedTitle = NSAttributedString(string: "Refreshing - please wait")
        pullToRefresh.tintColor = UIColor.orange
        pullToRefresh.addTarget(self, action: #selector(refreshAllFeeds), for: .valueChanged)
    }
}


extension ChannelListVC {
    
    /**
     If this is the first launch of the app and user has not subscribed to any podcasts yet, load the set of default podcasts.
     - Parameter None
     - Returns: None
     - Note: It loads only those podcasts which have published atleast one episode.
     */
    func processDefaultURLs()
    {
        // Get the URLs for podcasts from the file
        urlPodcasts = getDefaultPodcastURLs()
        
        // Fetch and parse the XMLs
        for urlPodcast in urlPodcasts
        {
            let podcastParserDelegate = ParseRSSFeed()
            let podcastChannelParsed = podcastParserDelegate.parseRSSFeed(urlPodcast)
            if podcastChannelParsed.pclEpisodes.count > 0
            {
                parsedPodcastChannels.append(podcastChannelParsed)
            }
        }
        
        if parsedPodcastChannels.count > 0
        {
            subscribedYet = true
            didDataChange = true
        }

    }
}

extension ChannelListVC {
    
    /**
     Let user enter the podcast URL for a new subscription.
     - Parameter None
     - Returns: None
     */
    func promptForPodcastURL() {
        let ac = UIAlertController(title: "Enter Podcast URL", message: "Please enter the URL for the podcast RSS feed", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [unowned self,ac] (action: UIAlertAction) in
            let answer = ac.textFields?.first?.text!
            let answerTrimmed = answer!.trimmingCharacters(in: Constants.spaceSet)
            self.processRSSFeed(answerTrimmed)
        }
        
        ac.addAction(submitAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        present(ac, animated: true, completion: nil)
    }
}


extension ChannelListVC {
    
    /**
     Validate the URL entered by the user. If it's not a valid URL, display an error. Otherwise, fetch and parse the feed XML. Once parsed, store the parsed feed in the user default storage. The parsed feed will be displayed at the top of the channel list table view.
     - Parameter answer: URL entered by the user
     - Returns: None
     - Note: It loads only those podcasts which have published atleast one episode.
     */
    func processRSSFeed(_ answer: String) {
        if isValidUrl(answer)
        {
            let podcastParserDelegate = ParseRSSFeed()
            let podcastChannelParsed = podcastParserDelegate.parseRSSFeed(answer)
            if podcastChannelParsed.pclEpisodes.count > 0
            {
                // Display the new channel at the top of the channel list
                parsedPodcastChannels.insert(podcastChannelParsed, at: 0)
                urlPodcasts.insert(answer, at: 0)
                tableView.reloadData()
                didDataChange = true

            } else
            {
                let ac = showErrorAlertInvalidURL()
                self.present(ac, animated: true, completion: nil)
            }
        } else
        {
            let ac = showErrorAlertInvalidURL()
            self.present(ac, animated: true, completion: nil)
        }

    }
}

extension ChannelListVC {
    
    /**
     Fetch and parse the feed XML for each channel.
     - Parameter None
     - Returns: None
     - Note: Pull-to-refresh control also uses this function.
     */
    func refreshAllFeeds() {
        let startDate = Date()

        var tempParsedPodcastChannels: [PodcastChannelLayout] = []
        
        guard urlPodcasts.count > 0 else {
            let ac = showMessageNoSubscriptions()
            self.present(ac, animated: true, completion: nil)
            return
        }
        
        // Fetch and parse the XMLs
        DispatchQueue.global(qos: .userInteractive).async
        { [unowned self ] in
            for urlPodcast in urlPodcasts
            {
                let podcastParserDelegate = ParseRSSFeed()
                let podcastChannelParsed = podcastParserDelegate.parseRSSFeed(urlPodcast)
                if podcastChannelParsed.pclEpisodes.count > 0
                {
                    tempParsedPodcastChannels.append(podcastChannelParsed)
                }
            }
            
            
            let endDate = Date()
            let timeInterval = endDate.timeIntervalSince(startDate)
            print("Refresh feeds seconds:  \(timeInterval)")
            
            if tempParsedPodcastChannels.count > 0
            {
                DispatchQueue.main.async
                {
                    parsedPodcastChannels = tempParsedPodcastChannels
                    self.tableView.reloadData()
                    
                    // In case pull-to-refresh control was used, stop refreshing.
                    pullToRefresh.endRefreshing()
                    didDataChange = true
                }

            } else
            {
                DispatchQueue.main.async
                {
                    let ac = showErrorAlertInternetConection()
                    self.present(ac, animated: true, completion: nil)
                }
                
            }
        }

    }
    
    /**
     Show the "About" screen. This screen will be shown when the user presses the "About" button.
     - Parameter answer: URL entered by the user
     - Returns: None
     */
    func showAboutScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AboutScreen") as! AboutScreenVC
        navigationController?.pushViewController(vc, animated: true)        
    }
}
