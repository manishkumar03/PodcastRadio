//
//  PodcastEpisodeLayout.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-04.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class PodcastEpisodeLayout: NSObject, NSCoding {
    // prefix pel stands for Podcast Episode Layout
    var pelEpisodeName: String
    var pelEpisodeShownotes: String
    var pelEpisodeEnclosure: String
    var pelEpisodeSummary: String
    var pelEpisodeDuration: String
    var pelEpisodePublishDate: Date
    var pelEpisodeLastPaused: Double
    
    required init(coder aDecoder: NSCoder) {
        self.pelEpisodeName = aDecoder.decodeObject(forKey: "pelEpisodeName") as! String
        self.pelEpisodeShownotes = aDecoder.decodeObject(forKey: "pelEpisodeShownotes") as! String
        self.pelEpisodeEnclosure = aDecoder.decodeObject(forKey: "pelEpisodeEnclosure") as! String
        self.pelEpisodeSummary = aDecoder.decodeObject(forKey: "pelEpisodeSummary") as! String
        self.pelEpisodeDuration = aDecoder.decodeObject(forKey: "pelEpisodeDuration") as! String
        self.pelEpisodePublishDate = aDecoder.decodeObject(forKey: "pelEpisodePublishDate") as! Date
        self.pelEpisodeLastPaused = aDecoder.decodeDouble(forKey: "pelEpisodeLastPaused") //as! Double
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(pelEpisodeName, forKey: "pelEpisodeName")
        aCoder.encode(pelEpisodeShownotes, forKey: "pelEpisodeShownotes")
        aCoder.encode(pelEpisodeEnclosure, forKey: "pelEpisodeEnclosure")
        aCoder.encode(pelEpisodeSummary, forKey: "pelEpisodeSummary")
        aCoder.encode(pelEpisodeDuration, forKey:"pelEpisodeDuration")
        aCoder.encode(pelEpisodePublishDate, forKey: "pelEpisodePublishDate")
        aCoder.encode(pelEpisodeLastPaused, forKey: "pelEpisodeLastPaused")
    }
    
    override init() {
        
        self.pelEpisodeName = ""
        self.pelEpisodeShownotes = ""
        self.pelEpisodeEnclosure = ""
        self.pelEpisodeSummary = ""
        self.pelEpisodeDuration = ""
        self.pelEpisodePublishDate = Date()
        self.pelEpisodeLastPaused = 0.0
        super.init()
        
    }
}

