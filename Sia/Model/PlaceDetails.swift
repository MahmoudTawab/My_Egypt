//
//  PlaceDetails.swift
//  Sia
//
//  Created by Emojiios on 15/03/2023.
//

import Foundation

class PlaceDetails {
    
    var canReserve : Bool?
    var screenData : ScreenData?
    var AllDetails : AllDetailsPlace?
    var SimilarPlaces = [PlaceSimilar]()
    var ShowsPlace = [PlaceShows]()
    var ReviewsPlace = [PlaceReviews]()

    
    init(dictionary:[String:Any]) {
    canReserve = dictionary["canReserve"] as? Bool
        
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let Details = dictionary["placeDetails"] as? [String:Any] {
    AllDetails = AllDetailsPlace(dictionary: Details)
    }
        
    if let similarPlaces = dictionary["similarPlaces"] as? [[String:Any]] {
    for item in similarPlaces {
    SimilarPlaces.append(PlaceSimilar(dictionary: item))
    }
    }
        
    if let placeShows = dictionary["placeShows"] as? [[String:Any]] {
    for item in placeShows {
    ShowsPlace.append(PlaceShows(dictionary: item))
    }
    }
        
    if let reviewsPlace = dictionary["placeReviews"] as? [[String:Any]] {
    for item in reviewsPlace {
    ReviewsPlace.append(PlaceReviews(dictionary: item))
    }
    }
    }
}



class AllDetailsPlace {
    
    var id : Int?
    var placeName : String?
    var image : String?
    var description : String?
    var address : String?
    var from : String?
    var to : String?
    var waitingHours : Int?
    var facebook : String?
    var instagram : String?
    var youtube : String?
    var hotline : String?
    var phoneNumber : String?
    var branches : String?
    var priceRange : String?
    var dressCode : String?
    var rate : Double?
    var isFavorite : Bool?
    var insights : Bool?
    var insightsContent : String?
    var OfficialWebsite : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        placeName = dictionary["placeName"] as? String
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

class PlaceSimilar {
    
    var id : Int?
    var placeName : String?
    var image : String?
    var description : String?
    var address : String?
    var isFavorite : Bool?
    var rate : Double?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        placeName = dictionary["placeName"] as? String
        image = dictionary["image"] as? String
        description = dictionary["description"] as? String
        address = dictionary["address"] as? String
        rate = round(dictionary["rate"] as? Double ?? 0.0) 
        isFavorite = dictionary["isFavorite"] as? Bool
    }
}

class PlaceShows {
    
    var id : Int?
    var placeId : Int?
    var showName : String?
    var image : String?
    var description : String?
    var date : String?
    var from : String?
    var to : String?
    var isFavorite : Bool?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        placeId = dictionary["placeId"] as? Int
        showName = dictionary["showName"] as? String
        image = dictionary["image"] as? String
        description = dictionary["description"] as? String
        
        date = dictionary["date"] as? String
        from = dictionary["from"] as? String
        
        to = dictionary["to"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
    }
}


class PlaceReviews {
    
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
