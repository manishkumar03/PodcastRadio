//
//  getStoredData.swift
//  Podcast Radio
//
//  Created by Manish Kumar on 2018-03-04.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//

import Foundation

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
    print("Loaded stored podcasts in seconds:  \(timeInterval)")
}

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

/** The default set of podcast URLs are stored in the file "PodcastList.txt"
 */
func getDefaultPodcastURLs() -> [String] {
    
    var podcastURLs: [String] = []
    
    if let podcastsURLPath = Bundle.main.path(forResource: "PodcastsList", ofType: ".txt") {
        let podcastsListData = try? String(contentsOfFile: podcastsURLPath)
        let tempPodcastList = podcastsListData?.components(separatedBy: .newlines)
        
        for podcastURL in tempPodcastList! {
            if podcastURL.count > 0 {
                podcastURLs.append(podcastURL)
            }
        }
        
    }
    
    return podcastURLs
}

