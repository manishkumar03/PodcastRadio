//
//  EpisodeListCell.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-04.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import UIKit

class EpisodeListCellUI: UITableViewCell {
    
    /// Used to create a rounded rectangle which serves as the background view for the cell. All the other views in the cell are laid out relative to this view. It's made the background view for the contentView by the function `sendSubview(toBack:)`.
    var whiteRoundedView: UIView!
    
/** The following views, having 'episodeCell' as the prefix, are used to display various attributes for the podcast episode. */
    
    /// ImageView used to show the podcast logo
    var episodeCellImageView: UIImageView!
    
    /// Label to display the episode title
    var episodeCellEpisodeNameLabel: UILabel!
    
    /// Label to display the episode description
    var episodeCellEpisodeSummaryLabel: UILabel!
    
    /// Label showing the episode duration
    var episodeCellDurationLabel: UILabel!
    
    /// Label showing the date the episode was published
    var episodeCellPublishDateLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupEpisodeListCell()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupEpisodeListCell() {
        let cellWidth = UIScreen.main.bounds.width
        self.backgroundColor = UIColor.orange
        
        /*********************************************************************************/
        // MARK: whiteRoundedView implementation
        /*********************************************************************************/
        
        /** whiteRoundedView will be created inside contentView by providing padding on all four sides. A shadowOffset of 4 points will be used to provide a 3D effect. This view will also make each channel have its own box. */
        
        let whiteRoundedView = UIView()
        self.addSubview(whiteRoundedView)
        whiteRoundedView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: Constants.padding)
        
        let top01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: Constants.padding)
        
        let height01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Constants.kEpisodeCellHeight - Constants.padding)
        
        let width01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: cellWidth - 2*Constants.padding)
        
        self.addConstraints([leading01, top01, height01, width01])
        
        whiteRoundedView.layer.backgroundColor = UIColor.white.cgColor
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 6.0
        whiteRoundedView.layer.shadowOffset = CGSize(width:-4, height:4)
        whiteRoundedView.layer.shadowOpacity = 0.3
        
        contentView.sendSubview(toBack: whiteRoundedView)
        
        /*********************************************************************************/
        // MARK: episodeCellImageView implementation
        /*********************************************************************************/
        
        /** episodeCellImageView will be positioned at top left of the whiteRoundedView */
        
        episodeCellImageView = UIImageView()
        self.addSubview(episodeCellImageView)
        episodeCellImageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "vector.png")!
        episodeCellImageView.image = image
        
        let leading02 = NSLayoutConstraint(item: episodeCellImageView, attribute: .leading, relatedBy: .equal, toItem: whiteRoundedView, attribute: .leading, multiplier: 1, constant: Constants.padding)
        
        let top02 = NSLayoutConstraint(item: episodeCellImageView, attribute: .top, relatedBy: .equal, toItem: whiteRoundedView, attribute: .top, multiplier: 1, constant: Constants.padding)
        
        let height02 = NSLayoutConstraint(item: episodeCellImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        let width02 = NSLayoutConstraint(item: episodeCellImageView, attribute: .width, relatedBy: .equal, toItem: episodeCellImageView, attribute: .height, multiplier: 1, constant: 1)
        
        self.addConstraints([leading02, top02, height02, width02])
        
        /*********************************************************************************/
        // MARK: episodeCellEpisodeNameLabel implementation
        /*********************************************************************************/
        
        /** episodeCellEpisodeNameLabel will be positioned at the right of episodeCellImageView */
        
        episodeCellEpisodeNameLabel = UILabel()
        self.addSubview(episodeCellEpisodeNameLabel)
        episodeCellEpisodeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeCellEpisodeNameLabel.font = UIFont(name: "Avenir-Book", size: 16.0)
        
        let leading03 = NSLayoutConstraint(item: episodeCellEpisodeNameLabel, attribute: .leading, relatedBy: .equal, toItem: episodeCellImageView, attribute: .trailing, multiplier: 1, constant: Constants.padding)
        
        let top03 = NSLayoutConstraint(item: episodeCellEpisodeNameLabel, attribute: .top, relatedBy: .equal, toItem: whiteRoundedView, attribute: .top, multiplier: 1, constant: Constants.padding)
        
        let height03 = NSLayoutConstraint(item: episodeCellEpisodeNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)
        
        let width03 = NSLayoutConstraint(item: episodeCellEpisodeNameLabel, attribute: .trailing, relatedBy: .equal, toItem: whiteRoundedView, attribute: .trailing, multiplier: 1, constant: -1*Constants.padding)
        
        self.addConstraints([leading03, top03, height03, width03])
        
        /*********************************************************************************/
        // MARK: episodeCellEpisodeSummaryLabel implementation
        /*********************************************************************************/
        
        /** episodeCellEpisodeSummaryLabel will be positioned just below the episodeCellEpisodeNameLabel */
        
        episodeCellEpisodeSummaryLabel = UILabel()
        self.addSubview(episodeCellEpisodeSummaryLabel)
        episodeCellEpisodeSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeCellEpisodeSummaryLabel.font = UIFont(name: "Avenir-Book", size: 12.0)
        episodeCellEpisodeSummaryLabel.numberOfLines = 4
        
        let leading04 = NSLayoutConstraint(item: episodeCellEpisodeSummaryLabel, attribute: .leading, relatedBy: .equal, toItem: episodeCellImageView, attribute: .trailing, multiplier: 1, constant: Constants.padding)
        
        let top04 = NSLayoutConstraint(item: episodeCellEpisodeSummaryLabel, attribute: .top, relatedBy: .equal, toItem: episodeCellEpisodeNameLabel, attribute: .bottom, multiplier: 1, constant: 0)
        
        let height04 = NSLayoutConstraint(item: episodeCellEpisodeSummaryLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 75)
        
        let width04 = NSLayoutConstraint(item: episodeCellEpisodeSummaryLabel, attribute: .trailing, relatedBy: .equal, toItem: whiteRoundedView, attribute: .trailing, multiplier: 1, constant: -1*Constants.padding)
        
        self.addConstraints([leading04, top04, height04, width04])
        
        /*********************************************************************************/
        // MARK: episodeCellPublishDateLabel implementation
        /*********************************************************************************/
        
        /** episodeCellPublishDateLabel will be positioned below the episodeCellEpisodeSummaryLabel, right justified */
        episodeCellPublishDateLabel = UILabel()
        episodeCellPublishDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(episodeCellPublishDateLabel)
        episodeCellPublishDateLabel.font = UIFont(name: "Avenir-Book", size: 14.0)
        episodeCellPublishDateLabel.textAlignment = .right
        
        let trailing05 = NSLayoutConstraint(item: episodeCellPublishDateLabel, attribute: .trailing, relatedBy: .equal, toItem: whiteRoundedView, attribute: .trailing, multiplier: 1, constant: -1*Constants.padding)
        
        let bottom05 = NSLayoutConstraint(item: episodeCellPublishDateLabel, attribute: .bottom, relatedBy: .equal, toItem: whiteRoundedView, attribute: .bottom, multiplier: 1, constant: -1*Constants.padding)
        
        let height05 = NSLayoutConstraint(item: episodeCellPublishDateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        
        let width05 = NSLayoutConstraint(item: episodeCellPublishDateLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (cellWidth - 2*Constants.padding)/2)
        
        self.addConstraints([trailing05, bottom05, height05, width05])
        
        /*********************************************************************************/
        // MARK: episodeCellDurationLabel implementation
        /*********************************************************************************/
        
        /** episodeCellDurationLabel will be positioned below the episodeCellEpisodeSummaryLabel, left justified */
        
        episodeCellDurationLabel = UILabel()
        episodeCellDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(episodeCellDurationLabel)
        episodeCellDurationLabel.font = UIFont(name: "Avenir-Book", size: 14.0)
        episodeCellDurationLabel.textAlignment = .left
        
        let leading06 = NSLayoutConstraint(item: episodeCellDurationLabel, attribute: .leading, relatedBy: .equal, toItem: whiteRoundedView, attribute: .leading, multiplier: 1, constant: Constants.padding)
        
        let bottom06 = NSLayoutConstraint(item: episodeCellDurationLabel, attribute: .bottom, relatedBy: .equal, toItem: whiteRoundedView, attribute: .bottom, multiplier: 1, constant: -1*Constants.padding)
        
        let height06 = NSLayoutConstraint(item: episodeCellDurationLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        
        let width06 = NSLayoutConstraint(item: episodeCellDurationLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (cellWidth - 2*Constants.padding)/2)
        
        self.addConstraints([leading06, bottom06, height06, width06])
        
    }


}
