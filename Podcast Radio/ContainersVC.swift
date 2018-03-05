//
//  ContainersVC.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-11-02.
//  Copyright © 2017 Manish Kumar. All rights reserved.
//

import UIKit

class ContainersVC: UIViewController {
    
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var bottomContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Top container will contain the table view for podcasts.
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let leading01 = NSLayoutConstraint(item: topContainer, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        
        let top01 = NSLayoutConstraint(item: topContainer, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        
        let trailing01 = NSLayoutConstraint(item: topContainer, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        let bottom01 = NSLayoutConstraint(item: topContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -100)
        self.view.addConstraints([leading01, top01, trailing01, bottom01])
        
        /// Bottom container will contain the 'Now playing' controls.
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let leading02 = NSLayoutConstraint(item: bottomContainer, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        
        let top02 = NSLayoutConstraint(item: bottomContainer, attribute: .top, relatedBy: .equal, toItem: topContainer, attribute: .bottom, multiplier: 1, constant: 0)
        
        let trailing02 = NSLayoutConstraint(item: bottomContainer, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        let bottom02 = NSLayoutConstraint(item: bottomContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraints([leading02, top02, trailing02, bottom02])

    }

}
