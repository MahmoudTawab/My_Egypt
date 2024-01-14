//
//  EventDetails.swift
//  Sia
//
//  Created by Emojiios on 15/03/2023.
//

import Foundation

class EventDetails {
    
    var canReserve : Bool?
    var screenData : ScreenData?
    var AllDetails : AllDetailsEvent?
    var SimilarEvents = [EventSimilar]()
    var ShowsEvent = [EventShows]()
    var ReviewsEvent = [EventReviews]()

    
    init(dictionary:[String:Any]) {
    canReserve = dictionary["canReserve"] as? Bool
        
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let Details = dictionary["eventDetails"] as? [String:Any] {
    AllDetails = AllDetailsEvent(dictionary: Details)
    }
        
    if let similarEvents = dictionary["similarEvents"] as? [[String:Any]] {
    for item in similarEvents {
    SimilarEvents.append(EventSimilar(dictionary: item))
    }
    }
        
    if let eventShows = dictionary["eventShows"] as? [[String:Any]] {
    for item in eventShows {
    ShowsEvent.append(EventShows(dictionary: item))
    }
    }
        
    if let reviewsEvent = dictionary["eventReviews"] as? [[String:Any]] {
    for item in reviewsEvent {
    ReviewsEvent.append(EventReviews(dictionary: item))
    }
    }
    }
}



class AllDetailsEvent {
    
    var id : Int?
    var eventName : String?
    var image : String?
    var description : String?
    var address : String?
    var from : String?
    var to : String?
    var waitingHours : Int?
    var facebook : String?
    var instagram : String?
    var youtube : String?
    var OfficialWebsite : String?

    var hotline : String?
    var phoneNumber : String?
    var branches : String?
    var priceRange : String?
    var dressCode : String?
    var rate : Double?
    var isFavorite : Bool?
    
    var insights : Bool?
    var insightsContent : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        eventName = dictionary["eventName"] as? String
        image = dictionary["image"] as? String
        description = dictionary["description"] as? String
        address = dictionary["address"] as? String
        from = dictionary["from"] as? String
        to = dictionary["to"] as? String
        waitingHours = dictionary["waitingHours"] as? Int
        facebook = dictionary["facebook"] as? String
        instagram = dictionary["instagram"] as? String
        youtube = dictionary["youtube"] as? String
        OfficialWebsite = dictionary["officialWebsite"] as? String
        
        hotline = dictionary["hotline"] as? String
        phoneNumber = dictionary["phoneNumber"] as? String
        branches = dictionary["branches"] as? String

        priceRange = dictionary["priceRange"] as? String
        dressCode = dictionary["dressCode"] as? String
        rate = round(dictionary["rate"] as? Double ?? 0.0)
        isFavorite = dictionary["isFavorite"] as? Bool
        
        insights = dictionary["insights"] as? Bool
        insightsContent = dictionary["insightsContent"] as? String
    }
}

class EventSimilar {
    
    var id : Int?
    var eventName : String?
    var image : String?
    var description : String?
    var address : String?
    var isFavorite : Bool?
    var rate : Double?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        eventName = dictionary["eventName"] as? String
        image = dictionary["image"] as? String
        description = dictionary["description"] as? String
        address = dictionary["address"] as? String
        rate = round(dictionary["rate"] as? Double ?? 0.0)
        isFavorite = dictionary["isFavorite"] as? Bool
    }
}

class EventShows {
    
    var id : Int?
    var eventId : Int?
    var showName : String?
    var image : String?
    var description : String?
    var address : String?

    var date : String?
    var from : String?
    var to : String?
    var isFavorite : Bool?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        eventId = dictionary["eventId"] as? Int
        showName = dictionary["showName"] as? String
        image = dictionary["image"] as? String
        description = dictionary["description"] as? String
        address = dictionary["address"] as? String
        
        date = dictionary["date"] as? String
        from = dictionary["from"] as? String
        
        to = dictionary["to"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
    }
}


class EventReviews {
    
    var id : Int?
    var userName : String?
    var userPhoto : String?
    var rate : Double?
    var comment : String?
    var ratedIn : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        userName = dictionary["userName"] as? String
        userPhoto = dictionary["userPhoto"] as? String
        rate = round(dictionary["rate"] as? Double ?? 0.0)
        comment = dictionary["comment"] as? String
        ratedIn = dictionary["ratedIn"] as? String
    }
}
