//  ChannelListVCTableFunctions.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-07.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import Foundation
import UIKit

extension ChannelListVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.kChannelCellHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsedPodcastChannels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelListCell", for: indexPath) as! ChannelListCellUI
        
        cell.channelCellChannelNameLabel?.text = parsedPodcastChannels[indexPath.row].pclChannelName
        cell.channelCellChannelDescriptionLabel?.text = parsedPodcastChannels[indexPath.row].pclChannelDescription
        
        let imageRelativePath = parsedPodcastChannels[indexPath.row].pclChannelArtworkImage
        let imageAbsolutePath = GlobalVariables.documentsDir.appendingPathComponent(imageRelativePath)
        let imageFilePath = imageAbsolutePath.path
        cell.channelCellImageView.image = UIImage(contentsOfFile: imageFilePath)
       
        cell.channelCellChannelAuthorLabel?.text = "Author: " + parsedPodcastChannels[indexPath.row].pclChannelAuthor
        cell.channelCellEpisodeCountLabel?.text = "Episode count: \(parsedPodcastChannels[indexPath.row].pclEpisodes.count)"
        return cell
    }
    
}

extension ChannelListVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let episodeListVC = storyboard?.instantiateViewController(withIdentifier: "episodeListVC") as? EpisodeListVC {
            episodeListVC.channel = parsedPodcastChannels[indexPath.row]
            navigationController?.pushViewController(episodeListVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            parsedPodcastChannels.remove(at: indexPath.row)
            urlPodcasts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            didDataChange = true
        }
    }
}


