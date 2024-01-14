//
//  Search.swift
//  Sia
//
//  Created by Emojiios on 11/04/2023.
//

import Foundation

class Search {
    var shows = [SearchData]()
    var places = [SearchData]()
    var events = [SearchData]()
    var categories = [SearchData]()
        
    init(dictionary:[String:Any]) {
        if let Shows = dictionary["shows"] as? [[String:Any]] {
        for item in Shows {
        shows.append(SearchData(dictionary: item))
        }
        }
        
        if let Places = dictionary["places"] as? [[String:Any]] {
        for item in Places {
        places.append(SearchData(dictionary: item))
        }
        }
        
        if let Events = dictionary["events"] as? [[String:Any]] {
        for item in Events {
        events.append(SearchData(dictionary: item))
        }
        }
        
        if let Categories = dictionary["categories"] as? [[String:Any]] {
        for item in Categories {
        categories.append(SearchData(dictionary: item))
        }
        }
    }
}

class SearchData {
    var id : Int?
    var image : String?
    var fav : Bool?
    var name : String?
    var description : String?
    var address : String?
    var categoryName : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        fav = dictionary["fav"] as? Bool
        name = dictionary["name"] as? String
        description = dictionary["description"] as? String
        address = dictionary["address"] as? String
        categoryName = dictionary["categoryName"] as? String
    }
}
