//
//  HNBStoryTableViewCell.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/18/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import UIKit

protocol HNBStoryTableViewCellDelegate {
    
    func storyCellDidPressCommentsButton(cell: HNBStoryTableViewCell)
    
}

class HNBStoryTableViewCell: UITableViewCell {
    
    static let nibName = "HNBStoryTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var separatorWidthConstraint: NSLayoutConstraint!
    
    var delegate: HNBStoryTableViewCellDelegate?
    
    override func awakeFromNib() {
        self.separatorWidthConstraint.constant = 0.5
    }
    
    func styleForStory(story: HNBItem) {
        self.titleLabel.text = story.title
        self.subtitleLabel.text = story.by
        if let score = story.score {
            self.scoreLabel.text = "\(score)"
        }
        self.commentsLabel.text = "\(story.kids.count) c"
    }
    
    @IBAction func commentsButtonPressed(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.storyCellDidPressCommentsButton(self)
        }
    }
}
