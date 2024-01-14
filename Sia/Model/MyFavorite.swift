//
//  MyFavorite.swift
//  Sia
//
//  Created by Emojiios on 16/03/2023.
//

import Foundation

class MyFavorite {
    
    var screenData : ScreenData?
    var places = [MyFavoritePlaces]()
    var Events = [MyFavoriteEvents]()
    var Shows = [MyFavoriteShows]()
    init(dictionary:[String:Any]) {
             
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
        
    if let DataPlaces = dictionary["places"] as? [[String:Any]] {
    for item in DataPlaces {
    places.append(MyFavoritePlaces(dictionary: item))
    }
    }
        
    if let DataEvents = dictionary["events"] as? [[String:Any]] {
    for item in DataEvents {
    Events.append(MyFavoriteEvents(dictionary: item))
    }
    }
        
    if let DataShows = dictionary["shows"] as? [[String:Any]] {
    for item in DataShows {
    Shows.append(MyFavoriteShows(dictionary: item))
    }
    }
        
    }
}


class MyFavoritePlaces {
    
    var plaseId : Int?
    var plaseName : String?
    var plaseImage : String?
    var isFavorite : Bool?
    
    init(dictionary:[String:Any]) {
        plaseId = dictionary["plaseId"] as? Int
        plaseName = dictionary["plaseName"] as? String
        plaseImage = dictionary["plaseImage"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
    }
    
}

class MyFavoriteEvents {
    
    var eventId : Int?
    var eventName : String?
    var eventImage : String?
    var isFavorite : Bool?
    
    init(dictionary:[String:Any]) {
        eventId = dictionary["eventId"] as? Int
        eventName = dictionary["eventName"] as? String
        eventImage = dictionary["eventImage"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
    }
    
}

class MyFavoriteShows {
    
    var showId : Int?
    var showName : String?
    var showImage : String?
    var isFavorite : Bool?
    
    init(dictionary:[String:Any]) {
        showId = dictionary["showId"] as? Int
        showName = dictionary["showName"] as? String
        showImage = dictionary["showImage"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
    }
    
}


