//
//  HNBMainFlexibleHeightBar.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/18/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import UIKit
import BLKFlexibleHeightBar

class HNBFlexibleHeightBar: BLKFlexibleHeightBar {
    
    internal var title: String?
    internal var label: UILabel!
    
    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        self.setupWithTitle(title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupWithTitle(title: String) {
        self.minimumBarHeight = 20
        self.backgroundColor = HNBConstants.HN_ORANGE
        
        self.behaviorDefiner = SquareCashStyleBehaviorDefiner()
        self.behaviorDefiner = self.behaviorDefiner
        
        self.label = UILabel()
        self.label.text = title
        self.label.font = UIFont.systemFontOfSize(20)
        self.label.textColor = HNBConstants.HN_WHITE
        self.label.sizeToFit()
        self.addSubview(label)
        
        let initialLayoutAttributes = BLKFlexibleHeightBarSubviewLayoutAttributes()
        initialLayoutAttributes.size = label.frame.size
        initialLayoutAttributes.center = CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds) + 10.0)
        label.addLayoutAttributes(initialLayoutAttributes, forProgress: 0)
        
        let finalLayoutAttributes = BLKFlexibleHeightBarSubviewLayoutAttributes(existingLayoutAttributes: initialLayoutAttributes)
        finalLayoutAttributes.alpha = 0
        let translation = CGAffineTransformMakeTranslation(0, -30)
        let scale = CGAffineTransformMakeScale(0.2, 0.2)
        finalLayoutAttributes.transform = CGAffineTransformConcat(scale, translation)
        label.addLayoutAttributes(finalLayoutAttributes, forProgress: 1)
    }
    
}
