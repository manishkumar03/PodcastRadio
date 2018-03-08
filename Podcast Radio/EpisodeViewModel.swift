//
//  EpisodeViewModel.swift
//  Podcast Radio
//
//  Created by Manish Kumar on 2018-03-08.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//

import Foundation
import UIKit

class EpisodeViewModel {
    let channel: PodcastChannelLayout
    let dateFormatter = DateFormatter()
    
    init(_ channel: PodcastChannelLayout) {
        self.channel = channel
    }

    func getNumberOfRowsInSection(_ section: Int) -> Int {
        return channel.pclEpisodes.count
    }
    
    func getHeightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        return Constants.kEpisodeCellHeight
    }
    
    func getEpisodeName(_ indexPath: IndexPath) -> String {
        return channel.pclEpisodes[indexPath.row].pelEpisodeName
    }
    
    func getEpisodeSummary(_ indexPath: IndexPath) -> String {
        return channel.pclEpisodes[indexPath.row].pelEpisodeSummary
    }
    
    func getEpisodeDuration(_ indexPath: IndexPath) -> String {
        let inputDuration = channel.pclEpisodes[indexPath.row].pelEpisodeDuration
        let outputDuration = formatDurationValue(inputDuration)
        return outputDuration
    }
    
    func getEpisodeShownotes(_ indexPath: IndexPath) -> String {
        return channel.pclEpisodes[indexPath.row].pelEpisodeShownotes
    }
    
    func getEpisodeEnclosure(_ indexPath: IndexPath) -> String {
        return channel.pclEpisodes[indexPath.row].pelEpisodeEnclosure
    }
    
    func getEpisodeLastPaused(_ indexPath: IndexPath) -> Double {
        return channel.pclEpisodes[indexPath.row].pelEpisodeLastPaused
    }
    
    func getEpisodeImage() -> UIImage {
        // Get the logo image just once since it's same for all the episodes
        let imageRelativePath = channel.pclChannelArtworkImage
        let imageAbsolutePath = GlobalVariables.documentsDir.appendingPathComponent(imageRelativePath)
        let imageFilePath = imageAbsolutePath.path
        return UIImage(contentsOfFile: imageFilePath)!
    }
    
    func getEpisodePublishDate(_ indexPath: IndexPath) -> String {
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let publishDate = channel.pclEpisodes[indexPath.row].pelEpisodePublishDate       
        return dateFormatter.string(from: publishDate)
    }
    
    /**
     Some podcasts have the duration in seconds (e.g. - 1772). This function will convert such values to
     standard HH:mm:ss format.
     - Parameter duration: Episode duration in seconds
     - Returns: Episode duration in HH:mm:ss format.
     */
    func formatDurationValue(_ duration: String) -> String {
        var outputString = ""
        if let intDuration = Int(duration) {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            outputString = formatter.string(from: TimeInterval(intDuration))!
        } else {
            outputString = duration
        }
        return outputString
    }
}
