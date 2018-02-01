//
//  SingletonClass.swift
//  Podcast Radio
//
//  Created by Manish Kumar on 2018-01-24.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//
import Foundation

class GlobalVariables {
  
    // To store local data
    static let fm = FileManager.default
    static let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).last!
    static let channelPath = documentsDir.appendingPathComponent("PodcastRadioChannels").path
    static let urlPath = documentsDir.appendingPathComponent("PodcastRadioUrls").path
}


