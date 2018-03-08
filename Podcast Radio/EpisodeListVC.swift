//
//  EpisodeListVC.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-04.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import UIKit

class EpisodeListVC: UITableViewController {
    var channel: PodcastChannelLayout = PodcastChannelLayout()
    var channelIndexPathRow: Int = -1
    var imageLogo = UIImage()
    
    lazy var episodeViewModel: EpisodeViewModel = {
        return EpisodeViewModel(self.channel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        
        // Set properties for the table view
        tableView.separatorStyle = .none
        tableView.register(EpisodeListCellUI.self, forCellReuseIdentifier: "episodeListCell")
        tableView.backgroundColor = UIColor.orange
        
        // Get the logo image just once since it's same for all the episodes
        imageLogo = episodeViewModel.getEpisodeImage()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeViewModel.getNumberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return episodeViewModel.getHeightForRowAt(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeListCell", for: indexPath) as! EpisodeListCellUI
        cell.episodeCellEpisodeNameLabel?.text = episodeViewModel.getEpisodeName(indexPath)
        cell.episodeCellEpisodeSummaryLabel?.text = episodeViewModel.getEpisodeSummary(indexPath)
        cell.episodeCellDurationLabel?.text = "Duration: " + episodeViewModel.getEpisodeDuration(indexPath)
        cell.episodeCellPublishDateLabel?.text = episodeViewModel.getEpisodePublishDate(indexPath)        
        cell.episodeCellImageView.image = imageLogo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let episodeDetailsVC = storyboard?.instantiateViewController(withIdentifier: "episodeDetailsVC") as? EpisodeDetailsVC {
            episodeDetailsVC.episodeEnclosure = episodeViewModel.getEpisodeEnclosure(indexPath)
            episodeDetailsVC.episodeShownotes = episodeViewModel.getEpisodeShownotes(indexPath)
            episodeDetailsVC.episodeName = episodeViewModel.getEpisodeName(indexPath)
            episodeDetailsVC.channelIndexPathRow = channelIndexPathRow
            episodeDetailsVC.episodeIndexPathRow = indexPath.row
            episodeDetailsVC.episodeLastPaused = episodeViewModel.getEpisodeLastPaused(indexPath)
            navigationController?.pushViewController(episodeDetailsVC, animated: true)            
        }
    }

}
