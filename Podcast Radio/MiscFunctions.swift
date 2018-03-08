//
//  MiscFunctions.swift
//  Podcast Radio
//
//  Created by Manish Kumar on 2018-03-04.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//

import Foundation
import UIKit

/**
 Check if the phone has internet connection. It works for both Wi-fi and cellular connections.
 - Parameter None
 - Returns: None
 */
func checkInternetConnection() -> Bool {
    return Reachability.isConnectedToNetwork()
}

func showErrorAlertInternetConection() -> UIAlertController {
    let ac = UIAlertController(title: "Not connected to Internet",
                               message: "Some features of the app may not work correctly",
                               preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    ac.addAction(okAction)
    return ac    
}

func showMessageNoPodcastsFound() -> UIAlertController {
    let ac = UIAlertController(title: "No podcast subscriptions found",
                               message: "Please use the '+' button to add a podcast",
                               preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    ac.addAction(okAction)
    return ac
}

func showMessageNoSubscriptions() -> UIAlertController {
    let ac = UIAlertController(title: "No podcast subscriptions found",
                               message: "Please subscribe to at least one podcast",
                               preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    ac.addAction(okAction)
    return ac
}


func showMessageDefaultPodcastsLoaded() -> UIAlertController {
    let ac = UIAlertController(title: "No podcast subscriptions found",
                               message: "A set of default podcasts has been loaded",
                               preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    ac.addAction(okAction)
    return ac
}

func showErrorAlertInvalidURL() -> UIAlertController {
    let ac = UIAlertController(title: "Not a valid URL",
                               message: "Please enter a valid podcast URL.",
                               preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    ac.addAction(okAction)
    return ac
}

/**
 Check if this is a valid URL.
 - Parameter inputURL: The URL string to be checked for validity
 - Returns: A Boolean value
 */
func isValidUrl(_ inputUrl: String) -> Bool
{
    if let testUrl = URL(string: inputUrl)
    {
        if UIApplication.shared.canOpenURL(testUrl)
        {
            return true
        } else {
            return false
        }
        
    } else
    {
        return false
    }
}








