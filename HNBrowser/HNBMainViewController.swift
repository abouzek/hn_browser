//
//  HNBMainViewController.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/17/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import UIKit

class HNBMainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var stories: [HNBItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Top Stories"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        HNBNetwork.fetchTopStories(15) { items in
            self.stories = items
            self.tableView.reloadData()
        }
    }

}

extension HNBMainViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let story = self.stories[indexPath.row]
        if let urlString = story.url, url = NSURL(string: urlString), storyboard = self.storyboard {
            
            let webViewController = storyboard.instantiateViewControllerWithIdentifier(HNBWebViewController.storyboardIdentifier) as! HNBWebViewController
            webViewController.url = url
            webViewController.navigationItem.title = story.title
            
            if let navController = self.navigationController {
                navController.pushViewController(webViewController, animated: true)
                
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
                }
            }
        }
    }
    
}

extension HNBMainViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        var cellTitle = ""
        let story = self.stories[indexPath.row]
        if let title = story.title {
            cellTitle = title
        }
        cell.textLabel!.text = cellTitle
        
        var cellSubtitle = ""
        if let score = story.score, by = story.by {
            cellSubtitle = "\(score) points by \(by) | \(story.kids.count) comments"
        }
        cell.detailTextLabel!.text = cellSubtitle
        
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count;
    }
    
}
