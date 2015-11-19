//
//  HNBBackButtonFlexibleHeightBar.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/18/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import UIKit
import BLKFlexibleHeightBar

protocol HNBBackButtonFlexibleHeightBarDelegate {
    
    func flexibleHeightBarDidPressBackButton(bar: HNBBackButtonFlexibleHeightBar, button: UIButton)
    
}

class HNBBackButtonFlexibleHeightBar: HNBFlexibleHeightBar {
    
    var delegate: HNBBackButtonFlexibleHeightBarDelegate?
    internal var backButton: UIButton!
    
    internal override func setupWithTitle(title: String) {
        self.minimumBarHeight = 50
        self.backgroundColor = HNBConstants.HN_ORANGE
        
        self.behaviorDefiner = SquareCashStyleBehaviorDefiner()
        self.behaviorDefiner = self.behaviorDefiner
        
        self.setupLabelWithTitle(title)
        self.setupBackButton()
    }
    
    private func setupLabelWithTitle(title: String) {
        self.label = UILabel()
        self.label.text = title
        self.label.font = UIFont.systemFontOfSize(20)
        self.label.textColor = HNBConstants.HN_WHITE
        self.label.sizeToFit()
        self.addSubview(label)
        
        self.setupLabelLayoutAttributes()
    }
    
    private func setupLabelLayoutAttributes() {
        let initialLayoutAttributes = BLKFlexibleHeightBarSubviewLayoutAttributes()
        initialLayoutAttributes.size = CGSize(width: UIScreen.mainScreen().bounds.width - 60, height: self.label.bounds.height)
        initialLayoutAttributes.center = CGPoint(x: CGRectGetMidX(self.bounds) + 30, y: CGRectGetMidY(self.bounds) + 10.0)
        self.label.addLayoutAttributes(initialLayoutAttributes, forProgress: 0)
        
        let finalLayoutAttributes = BLKFlexibleHeightBarSubviewLayoutAttributes(existingLayoutAttributes: initialLayoutAttributes)
        finalLayoutAttributes.alpha = 1
        let translation = CGAffineTransformMakeTranslation(-20, -12)
        let scale = CGAffineTransformMakeScale(0.8, 0.8)
        finalLayoutAttributes.transform = CGAffineTransformConcat(scale, translation)
        self.label.addLayoutAttributes(finalLayoutAttributes, forProgress: 1)
    }
    
    private func setupBackButton() {
        self.backButton = UIButton()
        self.backButton.setTitle("", forState: .Normal)
        self.backButton.tintColor = HNBConstants.HN_WHITE
        let image = UIImage(named: "back-arrow")?.imageWithRenderingMode(.AlwaysTemplate)
        self.backButton.setImage(image, forState: .Normal)
        self.backButton.addTarget(self, action: "backButtonPressed:", forControlEvents: .TouchUpInside)
        self.backButton.sizeToFit()
        self.addSubview(self.backButton)
        
        self.setupBackButtonLayoutAttributes()
    }
    
    private func setupBackButtonLayoutAttributes() {
        let initialLayoutAttributes = BLKFlexibleHeightBarSubviewLayoutAttributes()
        initialLayoutAttributes.size = self.backButton.frame.size
        initialLayoutAttributes.center = CGPoint(x: 30, y: CGRectGetMidY(self.bounds) + 10.0)
        self.backButton.addLayoutAttributes(initialLayoutAttributes, forProgress: 0)
        
        let finalLayoutAttributes = BLKFlexibleHeightBarSubviewLayoutAttributes(existingLayoutAttributes: initialLayoutAttributes)
        finalLayoutAttributes.alpha = 1
        let translation = CGAffineTransformMakeTranslation(0, -12)
        let scale = CGAffineTransformMakeScale(0.8, 0.8)
        finalLayoutAttributes.transform = CGAffineTransformConcat(scale, translation)
        self.backButton.addLayoutAttributes(finalLayoutAttributes, forProgress: 1)
    }
    
    func backButtonPressed(button: UIButton) {
        if let delegate = self.delegate {
            delegate.flexibleHeightBarDidPressBackButton(self, button: button)
        }
    }
    
}
