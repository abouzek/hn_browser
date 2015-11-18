//
//  HNBItem.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/17/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import UIKit

class HNBItem: HNBModel {
    
    // According to documentation, id is the only required field
    var id: Int {
        return self.dict["id"] as! Int
    }
    
    var deleted: Bool? {
        if let deleted = self.dict["deleted"] as? Bool {
            return deleted
        }
        return nil
    }
    
    var type: String? {
        if let type = self.dict["type"] as? String {
            return type
        }
        return nil
    }
    
    var by: String? {
        if let by = self.dict["by"] as? String {
            return by
        }
        return nil
    }
    
    var time: NSTimeInterval? {
        if let time = self.dict["time"] as? NSTimeInterval {
            return time
        }
        return nil
    }
    
    var date: NSDate? {
        if let time = self.time {
            return NSDate(timeIntervalSince1970: time)
        }
        return nil
    }
    
    var text: String? {
        if let text = self.dict["text"] as? String {
            return text
        }
        return nil
    }
    
    var dead: Bool? {
        if let dead = self.dict["dead"] as? Bool {
            return dead
        }
        return nil
    }
    
    var parent: Int? {
        if let parent = self.dict["parent"] as? Int {
            return parent
        }
        return nil
    }
    
    var kids: [Int] {
        if let kids = self.dict["kids"] as? [Int] {
            return kids
        }
        return []
    }
    
    var url: String? {
        if let url = self.dict["url"] as? String {
            return url
        }
        return nil
    }
    
    var score: Int? {
        if let score = self.dict["score"] as? Int {
            return score
        }
        return nil
    }
    
    var title: String? {
        if let title = self.dict["title"] as? String {
            return title
        }
        return nil
    }
    
    var parts: [Int] {
        if let parts = self.dict["parts"] as? [Int] {
            return parts
        }
        return []
    }
    
    var descendants: [Int] {
        if let descendants = self.dict["descendants"] as? [Int] {
            return descendants
        }
        return []
    }

}