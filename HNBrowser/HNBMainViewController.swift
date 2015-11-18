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
    private var refreshControl: UIRefreshControl!
    private var stories: [HNBItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Top Stories"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.registerNib(UINib(nibName: HNBStoryTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: HNBStoryTableViewCell.nibName)

        self.refresh()
    }
    
    func refresh() {
        HNBNetwork.fetchTopStories(15) { items in
            self.stories = items
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }

}

extension HNBMainViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let story = self.stories[indexPath.row]
        if let url = NSURL(string: story.url), storyboard = self.storyboard {
            
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
        let cell = tableView.dequeueReusableCellWithIdentifier(HNBStoryTableViewCell.nibName) as! HNBStoryTableViewCell
        let story = self.stories[indexPath.row]
        cell.styleForStory(story)
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count;
    }
    
}
