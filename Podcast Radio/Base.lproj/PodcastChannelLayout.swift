//
//  PodcastChannelLayout.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-04.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import UIKit

class PodcastChannelLayout: NSObject, NSCoding {
    
    // prefix pcl stands for Podcast Channel Layout
    var pclChannelName: String
    var pclChannelDescription: String
    var pclChannelArtworkPath: String
    var pclChannelArtworkImage: String
    var pclChannelAuthor: String
    var pclEpisodes: [PodcastEpisodeLayout]
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(pclChannelName, forKey: "pclChannelName")
        aCoder.encode(pclChannelDescription, forKey: "pclChannelDescription")
        aCoder.encode(pclChannelArtworkPath, forKey: "pclChannelArtworkPath")
        aCoder.encode(pclChannelArtworkImage, forKey: "pclChannelArtworkImage")
        aCoder.encode(pclChannelAuthor, forKey: "pclChannelAuthor")
        aCoder.encode(pclEpisodes, forKey: "pclEpisodes")
    }
    
    required init(coder aDecoder: NSCoder) {
        pclChannelName = aDecoder.decodeObject(forKey: "pclChannelName") as! String
        pclChannelDescription = aDecoder.decodeObject(forKey: "pclChannelDescription") as! String
        pclChannelArtworkPath = aDecoder.decodeObject(forKey: "pclChannelArtworkPath") as! String
        pclChannelArtworkImage = aDecoder.decodeObject(forKey: "pclChannelArtworkImage") as! String
        pclChannelAuthor = aDecoder.decodeObject(forKey: "pclChannelAuthor") as! String
        pclEpisodes = aDecoder.decodeObject(forKey: "pclEpisodes") as! [PodcastEpisodeLayout]
        super.init()
    }
  
    
    override init() {        
        pclChannelName = ""
        pclChannelDescription = ""
        pclChannelArtworkPath = ""
        pclChannelArtworkImage = ""
        pclChannelAuthor = ""
        pclEpisodes = []
        super.init()
    }
    
}

extension PodcastChannelLayout {
    func printPodcast() {
        print("Contents for podcast - " + self.pclChannelName)
        print("Description: " + self.pclChannelDescription)
        print("Author: " + self.pclChannelAuthor)
        print("Artwork: " + self.pclChannelArtworkPath)
        for episode in pclEpisodes {
            print (episode.pelEpisodeName)
            print (episode.pelEpisodeSummary)
            print (episode.pelEpisodeEnclosure)
            print (episode.pelEpisodePublishDate)
            print ("\n")
        }
    }
}

