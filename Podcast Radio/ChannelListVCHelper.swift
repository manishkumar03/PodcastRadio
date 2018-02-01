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
     Retrieve the parsed podcast feeds, if any, from the user defaults storage. If found, reload the tableview with them.
     - Parameter None
     - Returns: None
     - Note: This function gets called from viewDidLoad method.
     */
    func getStoredChannelData() {
        let startDate = Date()
        
        if let storedPodcastData = NSKeyedUnarchiver.unarchiveObject(withFile: GlobalVariables.channelPath)
        {
            let storedPodcastChannels = storedPodcastData as! [PodcastChannelLayout]
            if storedPodcastChannels.count > 0
            {
                parsedPodcastChannels = storedPodcastChannels
                print("Stored podcast found  \(parsedPodcastChannels.count)")
                
//                for channel in parsedPodcastChannels
//                {
//                    channel.printPodcast()
//                }
            }
        }
        
        
        let endDate = Date()
        let timeInterval = endDate.timeIntervalSince(startDate)
        print("Load stored podcasts seconds:  \(timeInterval)")
    }
}


extension ChannelListVC {
    
    /**
     Retrieve the list of podcasts to which the user has subscribed. This list is used to refresh the feed and fetch latest episodes.
     - Parameter None
     - Returns: None
     */
    func getStoredURLList() {
        
        if let storedUrlData = NSKeyedUnarchiver.unarchiveObject(withFile: GlobalVariables.urlPath) {
            let storedUrlPodcasts = storedUrlData as! [String]
            if storedUrlPodcasts.count > 0 {
                urlPodcasts = storedUrlPodcasts
                print("Stored URLs found \(urlPodcasts)")
            }
        }
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
                showErrorAlertInvalidURL()
            }
        } else
        {
            showErrorAlertInvalidURL()
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
            showMessageNoSubscriptions()
            return}
        
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
                    self.showErrorAlertInternetConection()
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

extension ChannelListVC {
    
    func showErrorAlertInvalidURL() {
        let ac = UIAlertController(title: "Not a valid URL", message: "Please enter a valid podcast URL.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func isValidUrl(_ inputUrl: String) -> Bool
    {
        if let testUrl = URL(string: inputUrl)
        {
            if UIApplication.shared.canOpenURL(testUrl)
            {
                return true
            } else {
                showErrorAlertInvalidURL()
                return false
            }
            
        } else
        {
            showErrorAlertInvalidURL()
            return false
        }
    }
    
    /**
     Check if the phone has internet connection. It works for both Wi-fi and cellular connections.
     - Parameter None
     - Returns: None
     */
    func checkInternetConnection() -> Bool
    {
        return Reachability.isConnectedToNetwork()

    }
    
    func showErrorAlertInternetConection() {
        let ac = UIAlertController(title: "Not connected to Internet", message: "Some features of the app may not work correctly", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func showMessageNoPodcastsFound() {
        let ac = UIAlertController(title: "No podcast subscriptions found",
                                   message: "Please use the '+' button to add a podcast",
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)        
    }
    
    func showMessageNoSubscriptions() {
        let ac = UIAlertController(title: "No podcast subscriptions found",
                                   message: "Please subscribe to at least one podcast",
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    
    func showMessageDefaultPodcastsLoaded() {
        let ac = UIAlertController(title: "No podcast subscriptions found",
                                   message: "A set of default podcasts has been loaded",
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
}

