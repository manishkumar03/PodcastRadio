//
//  getPodcastURLs.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-04.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import UIKit
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
