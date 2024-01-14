//
//  CategoryPlaces.swift
//  Sia
//
//  Created by Emojiios on 14/03/2023.
//

import Foundation

class CategoryPlaces {
    
    var screenData : ScreenData?
    var categories = [Categories]()
    var placesAndEvents = [PlacesAndEvents]()
    init(dictionary:[String:Any]) {
             
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let DataCategories = dictionary["categories"] as? [[String:Any]] {
    for item in DataCategories {
    categories.append(Categories(dictionary: item))
    }
    }
        
    if let places_Events = dictionary["placesAndEvents"] as? [[String:Any]] {
    for item in places_Events {
    placesAndEvents.append(PlacesAndEvents(dictionary: item))
    }
    }
    }
}

class PlacesAndEvents {
    
    var placeId : Int?
    var eventId : Int?
    var name : String?
    var image : String?
    
    init(dictionary:[String:Any]) {
        placeId = dictionary["placeId"] as? Int
        eventId = dictionary["eventId"] as? Int
        image = dictionary["image"] as? String
        name = dictionary["name"] as? String
    }
    
}


