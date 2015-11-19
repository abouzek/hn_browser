//
//  HNBMainViewController.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/17/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import UIKit
import BLKFlexibleHeightBar

class HNBMainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var flexibleBar: HNBFlexibleHeightBar!
    private var delegateSplitter: BLKDelegateSplitter!
    private var refreshControl: UIRefreshControl!
    private var stories: [HNBItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navController = self.navigationController {
            navController.setNavigationBarHidden(true, animated: false)
            self.flexibleBar = HNBFlexibleHeightBar(title: "Top Stories", frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 70))
            self.delegateSplitter = BLKDelegateSplitter(firstDelegate: self, secondDelegate: self.flexibleBar.behaviorDefiner)
            self.view.addSubview(flexibleBar)
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.contentInset = UIEdgeInsets(top: self.flexibleBar.maximumBarHeight - 20, left: 0, bottom: 0, right: 0)
        self.tableView.delegate = self.delegateSplitter
        self.tableView.dataSource = self;
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.registerNib(UINib(nibName: HNBStoryTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: HNBStoryTableViewCell.nibName)

        self.refresh()
    }
    
    func refresh() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "Fetching new content...")
        self.refreshControl.beginRefreshing()
        HNBNetwork.fetchTopStories(15) { items in
            self.stories = items
            self.refreshControl.endRefreshing()
            self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
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
        cell.delegate = self
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count;
    }
    
}

extension HNBMainViewController: HNBStoryTableViewCellDelegate {
    
    func storyCellDidPressCommentsButton(cell: HNBStoryTableViewCell) {
        // Show comments view
        if let storyboard = self.storyboard, navController = self.navigationController {
            let commentsViewController = storyboard.instantiateViewControllerWithIdentifier(HNBCommentsViewController.storyboardIdentifier) as! HNBCommentsViewController
            navController.pushViewController(commentsViewController, animated: true)
        }
    }
    
}
