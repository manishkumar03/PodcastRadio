//
//  AboutScreenViewController.swift
//  Podcast Radio
//
//  Created by Manish Bansal on 2017-10-21.
//  Copyright © 2017 Manish Bansal. All rights reserved.
//

import UIKit

class AboutScreenVC: UIViewController {

    var aboutText: String = ""
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myFont = "<font face='Avenir-Book' size='3' color= 'black'>%@"
        
        var html = "<HTML>"
        html += "<head>"
        html += "</head>"
        html += "<body>"
        html += "<p>Podcast Radio is an app which is designed to organize your podcast subscriptions. It only allows for streaming the episodes.</p>"
        html += "<p>Created by - Manish Kumar</p>"
        html += "</body>"
        html += "</HTML>"
        aboutText = String(format: myFont, html)

        webView.loadHTMLString(aboutText, baseURL: nil)
        
    }


}
