//
//  HNBModel.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/17/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import Foundation

class HNBModel: NSObject {
    
    internal var dict: [String: AnyObject];
    
    override var description: String {
        return dict.description
    }
    
    required init(dict: [String: AnyObject]) {
        self.dict = dict;
    }
    
}
