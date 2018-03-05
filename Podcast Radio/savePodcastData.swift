//
//  savePodcastData.swift
//  Podcast Radio
//
//  Created by Manish Kumar on 2018-03-04.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//

import Foundation

func savePodcastData() {
        
        let startDate = Date()
        
        // Store to the documents directory
        let areChannelsSaved = NSKeyedArchiver.archiveRootObject(parsedPodcastChannels, toFile: GlobalVariables.channelPath)
        print("Are channels saved?:", areChannelsSaved)
        
        let areURLsSaved = NSKeyedArchiver.archiveRootObject(urlPodcasts, toFile: GlobalVariables.urlPath)
        print("Are channels saved?:", areURLsSaved)
        
        didDataChange = false
        
        let endDate = Date()
        let timeInterval = endDate.timeIntervalSince(startDate)
        print("Saved data in seconds:  \(timeInterval)")
}
