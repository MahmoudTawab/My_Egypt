//
//  SearchMap.swift
//  Sia
//
//  Created by Emojiios on 31/05/2023.
//

import Foundation

class SearchMap {
        
    var lat : String?
    var lon : String?
    var type : String?
    var display_name : String?
    
    init(dictionary:[String:Any]) {
        lat = dictionary["lat"] as? String
        lon = dictionary["lon"] as? String
        type = dictionary["type"] as? String
        display_name = dictionary["display_name"] as? String
    }
}
