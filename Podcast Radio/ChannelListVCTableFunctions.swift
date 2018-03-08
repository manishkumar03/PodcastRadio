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
        return channelViewModel.getHeightForRowAt(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelViewModel.getNumberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelListCell", for: indexPath) as! ChannelListCellUI
        
        cell.channelCellChannelNameLabel?.text = channelViewModel.getChannelName(indexPath)
        cell.channelCellChannelDescriptionLabel?.text = channelViewModel.getChannelDescription(indexPath)
        cell.channelCellChannelAuthorLabel?.text = "Author: " + channelViewModel.getChannelAuthor(indexPath)
        cell.channelCellEpisodeCountLabel?.text = "Episode count: \(channelViewModel.getChannelEpisodeCount(indexPath))"
        cell.channelCellImageView.image = channelViewModel.getChannelImage(indexPath)

        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let episodeListVC = storyboard?.instantiateViewController(withIdentifier: "episodeListVC") as? EpisodeListVC {
            episodeListVC.channel = channelViewModel.getChannel(indexPath)
            episodeListVC.channelIndexPathRow = indexPath.row
            navigationController?.pushViewController(episodeListVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletePodcastChannel(indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            didDataChange = true
        }
    }
}


