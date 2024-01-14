//
//  ShowDetails.swift
//  Sia
//
//  Created by Emojiios on 16/03/2023.
//

import Foundation

class ShowDetails {
    
    var canReserve : Bool?
    var screenData : ScreenData?
    var Details : AllShowDetails?
    
    init(dictionary:[String:Any]) {
    canReserve = dictionary["canReserve"] as? Bool
        
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let ShowDetails = dictionary["showDetails"] as? [String:Any] {
    Details = AllShowDetails(dictionary: ShowDetails)
    }

    }
}

class AllShowDetails {
    
    var id : Int?
    var showName : String?
    var image : String?
    var description : String?
    var from : String?
    var to : String?
    var waitingHours : Int?
    var facebook : String?
    var instagram : String?
    var youtube : String?
    var OfficialWebsite : String?

    var dressCode : String?
    var isFavorite : Bool?
    var branches : String?
    var hotline : String?
    var phoneNumber : String?
    var priceRange : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        showName = dictionary["showName"] as? String
        image = dictionary["image"] as? String
        description = dictionary["description"] as? String
        from = dictionary["from"] as? String
        to = dictionary["to"] as? String
        waitingHours = dictionary["waitingHours"] as? Int
        facebook = dictionary["facebook"] as? String
        instagram = dictionary["instagram"] as? String
        youtube = dictionary["youtube"] as? String
        OfficialWebsite = dictionary["officialWebsite"] as? String
        
        dressCode = dictionary["dressCode"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
        
        branches = dictionary["branches"] as? String
        hotline = dictionary["hotline"] as? String
        phoneNumber = dictionary["phoneNumber"] as? String
        priceRange = dictionary["priceRange"] as? String
        
    }
}

