//
//  ChannelListCell.swift
//  This class describes the layout of table cells for channel list
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-09-03.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import UIKit

class ChannelListCellUI: UITableViewCell {
    
    /// Used to create a rounded rectangle which serves as the background view for the cell. All the other views in the cell are laid out relative to this view. It's made the background view for the contentView by the function `sendSubview(toBack:)`.
    var whiteRoundedView: UIView!
    
/** The following views, having 'channelCell' as the prefix, are used to display various attributes for the podcast channel. */
    
    /// ImageView used to show the podcast logo
    var channelCellImageView: UIImageView!
    
    /// Label to display the podcast title
    var channelCellChannelNameLabel: UILabel!
    
    /// Label to display the channel description
    var channelCellChannelDescriptionLabel: UILabel!
    
    /// Label used to display the names of the channel hosts. The tag <itunes:Author> occurs both at the channel level and at the episode level. Typically the tag at channel level contains the name of the company producing the podcast whereas the tag at episode level contains the names of the actual hosts.
    var channelCellChannelAuthorLabel: UILabel!
    
    /// Label showing the total number of episodes in this channel
    var channelCellEpisodeCountLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        
        let height01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Constants.kChannelCellHeight - Constants.padding)
        
        let width01 = NSLayoutConstraint(item: whiteRoundedView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: cellWidth - 2*Constants.padding)
        
        self.addConstraints([leading01, top01, height01, width01])
        
        whiteRoundedView.layer.backgroundColor = UIColor.white.cgColor
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 6.0
        whiteRoundedView.layer.shadowOffset = CGSize(width:-4, height:4)
        whiteRoundedView.layer.shadowOpacity = 0.3
        
        contentView.sendSubview(toBack: whiteRoundedView)
        
/*********************************************************************************/
// MARK: channelCellImageView implementation
/*********************************************************************************/
        
/** channelCellImageView will be positioned at top left of the whiteRoundedView. */
        
        channelCellImageView = UIImageView()
        self.addSubview(channelCellImageView)
        channelCellImageView.translatesAutoresizingMaskIntoConstraints = false
        channelCellImageView.image = UIImage()
        
        let leading02 = NSLayoutConstraint(item: channelCellImageView, attribute: .leading, relatedBy: .equal, toItem: whiteRoundedView, attribute: .leading, multiplier: 1, constant: Constants.padding)
        
        let top02 = NSLayoutConstraint(item: channelCellImageView, attribute: .top, relatedBy: .equal, toItem: whiteRoundedView, attribute: .top, multiplier: 1, constant: Constants.padding)
        
        let height02 = NSLayoutConstraint(item: channelCellImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 75)
        
        let width02 = NSLayoutConstraint(item: channelCellImageView, attribute: .width, relatedBy: .equal, toItem: channelCellImageView, attribute: .height, multiplier: 1, constant: 1)
        
        self.addConstraints([leading02, top02, height02, width02])

/*********************************************************************************/
// MARK: channelCellChannelNameLabel implementation
/*********************************************************************************/
        
/** channelCellChannelNameLabel will be positioned at the right of channelCellImageView  */
        
        channelCellChannelNameLabel = UILabel()
        self.addSubview(channelCellChannelNameLabel)
        channelCellChannelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        channelCellChannelNameLabel.font = UIFont(name: "Avenir-Book", size: 16.0)
        
        let leading03 = NSLayoutConstraint(item: channelCellChannelNameLabel, attribute: .leading, relatedBy: .equal, toItem: channelCellImageView, attribute: .trailing, multiplier: 1, constant: Constants.padding)
        
        let top03 = NSLayoutConstraint(item: channelCellChannelNameLabel, attribute: .top, relatedBy: .equal, toItem: whiteRoundedView, attribute: .top, multiplier: 1, constant: Constants.padding)
        
        let height03 = NSLayoutConstraint(item: channelCellChannelNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        
        let width03 = NSLayoutConstraint(item: channelCellChannelNameLabel, attribute: .trailing, relatedBy: .equal, toItem: whiteRoundedView, attribute: .trailing, multiplier: 1, constant: -1*Constants.padding)

        self.addConstraints([leading03, top03, height03, width03])

/*********************************************************************************/
// MARK: channelCellChannelDescriptionLabel implementation
/*********************************************************************************/
        
/** channelCellChannelDescriptionLabel will be positioned just below the channelCellChannelNameLabel */
        
        channelCellChannelDescriptionLabel = UILabel()
        self.addSubview(channelCellChannelDescriptionLabel)
        channelCellChannelDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        channelCellChannelDescriptionLabel.font = UIFont(name: "Avenir-Book", size: 12.0)
        channelCellChannelDescriptionLabel.numberOfLines = 5
        
        let leading04 = NSLayoutConstraint(item: channelCellChannelDescriptionLabel, attribute: .leading, relatedBy: .equal, toItem: channelCellImageView, attribute: .trailing, multiplier: 1, constant: Constants.padding)
        
        let top04 = NSLayoutConstraint(item: channelCellChannelDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: channelCellChannelNameLabel, attribute: .bottom, multiplier: 1, constant: 0)
        
        let height04 = NSLayoutConstraint(item: channelCellChannelDescriptionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 85)
        
        let width04 = NSLayoutConstraint(item: channelCellChannelDescriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: whiteRoundedView, attribute: .trailing, multiplier: 1, constant: -1*Constants.padding)

        self.addConstraints([leading04, top04, height04, width04])

/*********************************************************************************/
// MARK: channelCellChannelAuthorLabel implementation
/*********************************************************************************/
        
/** channelCellChannelAuthorLabel will be positioned below the channelCellChannelDescriptionLabel, left justified */
        
        channelCellChannelAuthorLabel = UILabel()
        self.addSubview(channelCellChannelAuthorLabel)
        channelCellChannelAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        channelCellChannelAuthorLabel.font = UIFont(name: "Avenir-Book", size: 14.0)
        
        let leading05 = NSLayoutConstraint(item: channelCellChannelAuthorLabel, attribute: .leading, relatedBy: .equal, toItem: whiteRoundedView, attribute: .leading, multiplier: 1, constant: Constants.padding)
        
        let top05 = NSLayoutConstraint(item: channelCellChannelAuthorLabel, attribute: .top, relatedBy: .equal, toItem: channelCellChannelDescriptionLabel, attribute: .bottom, multiplier: 1, constant: 0)
        
        let height05 = NSLayoutConstraint(item: channelCellChannelAuthorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15)
        
        let width05 = NSLayoutConstraint(item: channelCellChannelAuthorLabel, attribute: .trailing, relatedBy: .equal, toItem: whiteRoundedView, attribute: .trailing, multiplier: 1, constant: -1*Constants.padding)

        self.addConstraints([leading05, top05, height05, width05])
       
/*********************************************************************************/
// MARK: channelCellEpisodeCountLabel implementation
/*********************************************************************************/
        
/** channelCellEpisodeCountLabel will be positioned below the channelCellChannelDescriptionLabel, right justified */

        channelCellEpisodeCountLabel = UILabel()
        channelCellEpisodeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(channelCellEpisodeCountLabel)
        channelCellEpisodeCountLabel.font = UIFont(name: "Avenir-Book", size: 14.0)
        channelCellEpisodeCountLabel.textAlignment = .right
        
        let trailing06 = NSLayoutConstraint(item: channelCellEpisodeCountLabel, attribute: .trailing, relatedBy: .equal, toItem: whiteRoundedView, attribute: .trailing, multiplier: 1, constant: -1*Constants.padding)
        
        let bottom06 = NSLayoutConstraint(item: channelCellEpisodeCountLabel, attribute: .bottom, relatedBy: .equal, toItem: whiteRoundedView, attribute: .bottom, multiplier: 1, constant: -1*Constants.padding)
        
        let height06 = NSLayoutConstraint(item: channelCellEpisodeCountLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15)
        
        let width06 = NSLayoutConstraint(item: channelCellEpisodeCountLabel, attribute: .width, relatedBy: .equal, toItem: channelCellChannelDescriptionLabel, attribute: .width, multiplier: 1, constant: 0)

        self.addConstraints([trailing06, bottom06, height06, width06])

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
