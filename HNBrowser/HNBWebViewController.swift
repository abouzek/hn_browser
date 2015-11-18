//
//  HNBWebViewController.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/17/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import UIKit

class HNBWebViewController: UIViewController {
    
    static let storyboardIdentifier = "HNBWebViewController"
    
    @IBOutlet weak var webView: UIWebView!
    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = self.url {
            let request = NSURLRequest(URL: url)
            self.webView.loadRequest(request)
        }
    
    }

}
