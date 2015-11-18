//
//  HNBNetwork.swift
//  HNBrowser
//
//  Created by Alan Bouzek on 11/17/15.
//  Copyright © 2015 abouzek. All rights reserved.
//

import UIKit
import Alamofire

class HNBNetwork: NSObject {
    
    private static let baseUrl: String = "https://hacker-news.firebaseio.com/v0/"

    static func fetchTopStories(limit: Int, completion:([HNBItem] -> Void)) {
        Alamofire.request(.GET, baseUrl + "topstories.json")
            .responseJSON { response in
                if let allIds = response.result.value as? [Int] {
                    // Fake pagination, only load ids up to specified limit
                    var idsToLoad: [Int] = []
                    for index in 0..<limit {
                        idsToLoad.append(allIds[index])
                    }
                    loadItemsFromIds(idsToLoad, completion: completion)
                    
                } else {
                    // Handle error
                }
            }
    }
    
    private static func loadItemsFromIds(ids: [Int], completion:([HNBItem] -> Void)) {
        // Store the items mapped by id for fast access later
        var items: [Int: HNBItem] = [:]
        
        for id in ids {
            loadItemFromId(id, completion: { item in
                items[id] = item
                
                if items.count == ids.count {
                    // Loaded all items, but out of order
                    // Sort in order returned by service
                    var sortedItems: [HNBItem] = []
                    for loadedId in ids {
                        sortedItems.append(items[loadedId]!)
                    }
                    
                    completion(sortedItems)
                }
            })
        }

    }
    
    private static func loadItemFromId(id: Int, completion:(HNBItem -> Void)) {
        Alamofire.request(.GET, baseUrl + "item/\(id).json")
            .responseJSON { response in
                if let dict = response.result.value as? [String: AnyObject] {
                    completion(HNBItem(dict: dict))
                }
                else {
                    // Handle error
                }
        }
    }
    
}
