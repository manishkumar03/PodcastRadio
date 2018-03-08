//
//  ChannelViewModel.swift
//  Podcast Radio
//
//  Created by Manish Kumar on 2018-03-08.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//

import Foundation
import UIKit

class ChannelViewModel {
    
    func getNumberOfRowsInSection(_ section: Int) -> Int {
        return parsedPodcastChannels.count
    }
    
    func getHeightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        return Constants.kChannelCellHeight
    }
    
    func getChannelName(_ indexPath: IndexPath) -> String {
        return parsedPodcastChannels[indexPath.row].pclChannelName
    }
    
    func getChannelDescription(_ indexPath: IndexPath) -> String {
        return parsedPodcastChannels[indexPath.row].pclChannelDescription
    }
    
    func getChannelAuthor(_ indexPath: IndexPath) -> String {
        return parsedPodcastChannels[indexPath.row].pclChannelAuthor
    }
    
    func getChannelEpisodeCount(_ indexPath: IndexPath) -> Int {
        return parsedPodcastChannels[indexPath.row].pclEpisodes.count
    }
    
    func getChannelImage(_ indexPath: IndexPath) -> UIImage {
        let imageRelativePath = parsedPodcastChannels[indexPath.row].pclChannelArtworkImage
        let imageAbsolutePath = GlobalVariables.documentsDir.appendingPathComponent(imageRelativePath)
        let imageFilePath = imageAbsolutePath.path
        return UIImage(contentsOfFile: imageFilePath)!
    }
    
    func getChannel(_ indexPath: IndexPath) -> PodcastChannelLayout {
        return parsedPodcastChannels[indexPath.row]
    }
}
