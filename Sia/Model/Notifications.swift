//
//  Notifications.swift
//  Sia
//
//  Created by Emojiios on 04/04/2023.
//

import Foundation


class ModelNotification {

    var id: Int?
    var title : String?
    var screenTitle : String?
    var notificationMessage : String?
    var icon : String?
    var typeName : String?
    var placeName : String?
    var eventName : String?
    var showName : String?
    var placeImage : String?
    var eventImage : String?
    var showImage : String?
    var ratePlaces : Double?
    var rateEvent : Double?
    var placeFav : Bool?
    var eventFav : Bool?
    var showFav : Bool?
    var read : Bool?

    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    title = dictionary["title"] as? String
    screenTitle = dictionary["screenTitle"] as? String
    notificationMessage = dictionary["notificationMessage"] as? String
    icon = dictionary["icon"] as? String
    typeName = dictionary["typeName"] as? String
    placeName = dictionary["placeName"] as? String
    eventName = dictionary["eventName"] as? String
    showName = dictionary["showName"] as? String
        
    placeImage = dictionary["placeImage"] as? String
    eventImage = dictionary["eventImage"] as? String
    showImage = dictionary["showImage"] as? String
        
    ratePlaces = dictionary["ratePlaces"] as? Double
    rateEvent = dictionary["rateEvent"] as? Double
    placeFav = dictionary["placeFav"] as? Bool
    eventFav = dictionary["eventFav"] as? Bool
    showFav = dictionary["showFav"] as? Bool
    read = dictionary["read"] as? Bool
    }
}
