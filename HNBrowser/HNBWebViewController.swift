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
    private var flexibleBar: HNBBackButtonFlexibleHeightBar!
    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = self.navigationItem.title {
            self.flexibleBar = HNBBackButtonFlexibleHeightBar(title: title, frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 70))
            self.webView.scrollView.delegate = self.flexibleBar.behaviorDefiner
            self.webView.scrollView.contentInset = UIEdgeInsets(top: self.flexibleBar.maximumBarHeight - 20, left: 0, bottom: 0, right: 0)
            self.flexibleBar.delegate = self
            self.view.addSubview(self.flexibleBar)
        }
        
        if let url = self.url {
            let request = NSURLRequest(URL: url)
            self.webView.loadRequest(request)
        }
        
    }
    
}

extension HNBWebViewController: HNBBackButtonFlexibleHeightBarDelegate {
    
    func flexibleHeightBarDidPressBackButton(bar: HNBBackButtonFlexibleHeightBar, button: UIButton) {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
    }
    
}
