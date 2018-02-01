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
    let dateFormatter = DateFormatter()
    var imageLogo = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        // Set properties for the table view
        tableView.separatorStyle = .none
        tableView.register(EpisodeListCellUI.self, forCellReuseIdentifier: "episodeListCell")
        tableView.backgroundColor = UIColor.orange
        
        // Get the logo image just once since it's same for all the episodes
        let imageRelativePath = channel.pclChannelArtworkImage
        let imageAbsolutePath = GlobalVariables.documentsDir.appendingPathComponent(imageRelativePath)
        let imageFilePath = imageAbsolutePath.path
        imageLogo = UIImage(contentsOfFile: imageFilePath)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channel.pclEpisodes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.kEpisodeCellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeListCell", for: indexPath) as! EpisodeListCellUI
        cell.episodeCellEpisodeNameLabel?.text = channel.pclEpisodes[indexPath.row].pelEpisodeName
        cell.episodeCellEpisodeSummaryLabel?.text = channel.pclEpisodes[indexPath.row].pelEpisodeSummary
        
        let inputDuration = channel.pclEpisodes[indexPath.row].pelEpisodeDuration
        let outputDuration = formatDurationValue(inputDuration)
        cell.episodeCellDurationLabel?.text = "Duration: " + outputDuration
        
        let publishDate = channel.pclEpisodes[indexPath.row].pelEpisodePublishDate
        cell.episodeCellPublishDateLabel?.text = dateFormatter.string(from: publishDate)
        
        //let imageFileURL = channel.pclChannelArtworkImage
        //let imageFilePath = imageFileURL.path
        //cell.episodeCellImageView.image = UIImage(contentsOfFile: imageFilePath)
        
        cell.episodeCellImageView.image = imageLogo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let episodeDetailsVC = storyboard?.instantiateViewController(withIdentifier: "episodeDetailsVC") as? EpisodeDetailsVC {
            episodeDetailsVC.episodeEnclosure = channel.pclEpisodes[indexPath.row].pelEpisodeEnclosure
            episodeDetailsVC.episodeShownotes = channel.pclEpisodes[indexPath.row].pelEpisodeShownotes
            episodeDetailsVC.episodeName = channel.pclEpisodes[indexPath.row].pelEpisodeName
            navigationController?.pushViewController(episodeDetailsVC, animated: true)
            
        }
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
