//
//  parseRSSFeed.swift
//  PeaBrain
//
//  Created by Manish Bansal on 2017-07-26.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import Foundation
import UIKit

class ParseRSSFeed: NSObject, XMLParserDelegate {
    var currentElement = String()
    var itemsHaveStarted: Bool = false
    var channelNameDone: Bool = false
    
    var podcast = PodcastChannelLayout()
    var episode = PodcastEpisodeLayout()
    
    var channelName = String()
    var channelDescription = String()
    var channelArtworkPath = String()
    var channelArtworkImage = String()
    var channelAuthor = String()
    
    var episodeTitle = String()
    var episodeDescription = String()
    var episodeEnclosure = String()
    var episodeSummary = String()
    var episodeDuration = String()
    var episodePublishDate = String()
    
    let dateFormatter = DateFormatter()
    

    //////////////////////////////////////////////////////////
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        switch elementName {
            
        case "channel":
            podcast = PodcastChannelLayout()
            
        case "item":
            itemsHaveStarted = true
            episodeTitle = ""
            episodeDescription = ""
            episodeEnclosure = ""
            episodeSummary = ""
            episodeDuration = ""
            episodePublishDate = ""
            episode = PodcastEpisodeLayout()
            
        case "enclosure":
            episodeEnclosure = attributeDict["url"]!
            
        case "itunes:image":
            channelArtworkPath = attributeDict["href"]!
            
        default: break
        }
        
        currentElement = elementName
    }
    
    
    //////////////////////////////////////////////////////////
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "channel" {
            channelName = channelName.trimmingCharacters(in: Constants.spaceSet)
            podcast.pclChannelName = channelName
            
            channelDescription = channelDescription.trimmingCharacters(in: Constants.spaceSet)
            podcast.pclChannelDescription = channelDescription
            
            channelArtworkPath = channelArtworkPath.trimmingCharacters(in: Constants.spaceSet)
            podcast.pclChannelArtworkPath = channelArtworkPath
            
            channelArtworkImage = downloadArtworkImage(channelArtworkPath)
            podcast.pclChannelArtworkImage = channelArtworkImage
            
            channelAuthor = channelAuthor.trimmingCharacters(in: Constants.spaceSet)
            podcast.pclChannelAuthor = channelAuthor
            
            //podcast.printPodcast()
            //parsedPodcastChannels.append(podcast)
        }
        
        if elementName == "item" {
            episodeTitle = episodeTitle.trimmingCharacters(in: Constants.spaceSet)
            episode.pelEpisodeName = episodeTitle
            
            episodeDescription = episodeDescription.trimmingCharacters(in: Constants.spaceSet)
            episode.pelEpisodeShownotes = episodeDescription
            
            episodeEnclosure = episodeEnclosure.trimmingCharacters(in: Constants.spaceSet)
            episode.pelEpisodeEnclosure = episodeEnclosure
            
            episodeSummary = episodeSummary.trimmingCharacters(in: Constants.spaceSet)
            if episodeSummary.isEmpty {
                episodeSummary = episodeDescription
            }
            
            episode.pelEpisodeSummary = episodeSummary
            
            episodeDuration = episodeDuration.trimmingCharacters(in: Constants.spaceSet)
            episode.pelEpisodeDuration = episodeDuration
            
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss zzz"
            
            episodePublishDate = episodePublishDate.trimmingCharacters(in: Constants.spaceSet)
            episode.pelEpisodePublishDate = dateFormatter.date(from: episodePublishDate)!
            
            podcast.pclEpisodes.append(episode)
        }
    }
    
    //////////////////////////////////////////////////////////
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == "title" {
            if itemsHaveStarted == true {
                episodeTitle.append(string)
            } else {
                if channelNameDone == false {
                    channelName.append(string)
                    channelNameDone = true                    
                }
                
                
            }
        }
        
        if currentElement == "description" || currentElement == "content:encoded" {
            if itemsHaveStarted == true {
                episodeDescription.append(string)
            } else {
                channelDescription.append(string)
            }
        }
        
        if currentElement == "itunes:author" {
            if itemsHaveStarted == true {
                
            } else {
                channelAuthor.append(string)
            }
        }
        
        if currentElement == "itunes:summary" 
            //currentElement == "itunes:summary" ||
            //currentElement == "summary"
        {
            if itemsHaveStarted == true {
                episodeSummary.append(string)
            } else {
                
            }
        }
        
        
        if currentElement == "pubDate" {
            if itemsHaveStarted == true {
                episodePublishDate.append(string)
            } else {
                
            }
        }
        
        if currentElement == "itunes:duration" {
            if itemsHaveStarted == true {
                episodeDuration.append(string)
            } else {
                
            }
        }        
}
    
    func parseRSSFeed(_ url: String) -> PodcastChannelLayout
    {
        let url = URL(string: url)
        if let rawData = try? Data(contentsOf: url!)
        {
            let xmlParser = XMLParser(data: rawData)
            xmlParser.delegate = self
            xmlParser.parse()
        }
        return podcast
    }
    
    func downloadArtworkImage(_ imageUrl: String) -> String
    {
        let artworkImageUrl = URL(string: imageUrl)
        let imageData = try? Data(contentsOf: artworkImageUrl!)
        let originalImage = UIImage(data: imageData!)
        let artworkImage = originalImage?.resizeImage(size: CGSize(width: 500, height: 500))
        let relativePath = "\(channelName)" + ".jpg"
        let imagePath = GlobalVariables.documentsDir.appendingPathComponent(relativePath)
        try? UIImageJPEGRepresentation(artworkImage!, 100)?.write(to: imagePath)
        
        //print("Parse Feed imagePath:", imagePath)
       
        return relativePath
    }
    

}
