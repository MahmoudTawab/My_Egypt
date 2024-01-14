//
//  HomeScreen.swift
//  Sia
//
//  Created by Emojiios on 07/03/2023.
//

import Foundation

class HomeScreen {
    
    var jwt : String?
    var lang : Int?
    var isUser : Bool?
    var userData:UserData?
    var refreshToken : String?
    var reserveNumber : String?
    var whatsAppNumber : String?
    var screenData : ScreenData?
    var notification : HomeNotification?
    var refreshTokenExpiresOn : String?
    
    var categories = [Categories]()
    var happeningToday = [HappeningToday]()
    var upcomingEvents = [UpcomingEvents]()
    
    init(dictionary:[String:Any]) {
             
    lang = dictionary["lang"] as? Int
    isUser = dictionary["isUser"] as? Bool
    refreshTokenExpiresOn = dictionary["refreshTokenExpiresOn"] as? String
        
    reserveNumber = dictionary["reserveNumber"] as? String
    whatsAppNumber = dictionary["whatsAppNumber"] as? String
        
    if let Jwt = dictionary["jwt"] as? String {
    defaults.set(Jwt, forKey: "jwt")
    defaults.synchronize()
    }
    

    if let refreshToken = dictionary["refreshToken"] as? String {
    defaults.set(refreshToken, forKey: "refreshToken")
    defaults.synchronize()
    }
        
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let user = dictionary["userData"] as? [String:Any] {
    userData = UserData(dictionary: user)
    }
        
    if let DataNotification = dictionary["notification"] as? [String:Any] {
    notification = HomeNotification(dictionary: DataNotification)
    }
     
        
    if let DataCategories = dictionary["categories"] as? [[String:Any]] {
    for item in DataCategories {
    categories.append(Categories(dictionary: item))
    }
    }
        
    if let DataHappeningToday = dictionary["happeningToday"] as? [[String:Any]] {
    for item in DataHappeningToday {
    happeningToday.append(HappeningToday(dictionary: item))
    }
    }
        
    if let DataUpcomingEvents = dictionary["upcomingEvents"] as? [[String:Any]] {
    for item in DataUpcomingEvents {
    upcomingEvents.append(UpcomingEvents(dictionary: item))
    }
    }
    }
}

class UserData {
    
    var id : String?
    var firstName : String?
    var lastName : String?
    var email : String?
    var phoneNumber : String?
    var userName : String?
    var photo : String?
    var birthday : String?
    var isMail : Bool?
    var egyptianCitizen : Bool?
    var passportOrIdNumber : String?
    var nationaltyId : Int?
    var currencyId : Int?
    var cityId : Int?
    var latitudes : Double?
    var longitudes : Double?
    var lastConnection : String?
    var createdOn : String?
    var emailConfirmed : Bool?
    var blocked : Bool?
    var notificationsCount : Int?
    
    var name : String?
    var memberSince : String?
    var genderAndAge : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        email = dictionary["email"] as? String
        phoneNumber = dictionary["phoneNumber"] as? String
        userName = dictionary["userName"] as? String
        photo = dictionary["photo"] as? String
        birthday = dictionary["birthday"] as? String
        isMail = dictionary["isMail"] as? Bool
        egyptianCitizen = dictionary["egyptianCitizen"] as? Bool
        passportOrIdNumber = dictionary["passportOrIdNumber"] as? String
        nationaltyId = dictionary["nationaltyId"] as? Int
        currencyId = dictionary["currencyId"] as? Int
        cityId = dictionary["cityId"] as? Int
        latitudes = dictionary["latitudes"] as? Double
        longitudes = dictionary["longitudes"] as? Double
        lastConnection = dictionary["lastConnection"] as? String
        createdOn = dictionary["createdOn"] as? String
        emailConfirmed = dictionary["emailConfirmed"] as? Bool
        blocked = dictionary["blocked"] as? Bool
        notificationsCount = dictionary["notificationsCount"] as? Int
        
        name = dictionary["name"] as? String
        memberSince = dictionary["memberSince"] as? String
        genderAndAge = dictionary["genderAndAge"] as? String
    }
}

class HomeNotification {
    
    var id : Int?
    var title : String?
    var notificationMessage : String?
    var icon : String?
    var notificationTypeId : Int?
    var typeName : String?
    var isReaded : Bool?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        icon = dictionary["icon"] as? String
        title = dictionary["title"] as? String
        typeName = dictionary["typeName"] as? String
        isReaded = dictionary["isReaded"] as? Bool
        notificationTypeId = dictionary["notificationTypeId"] as? Int
        notificationMessage = dictionary["notificationMessage"] as? String
    }
    
}

class Categories {
    var id : Int?
    var photo : String?
    var categoryName : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        photo = dictionary["photo"] as? String
        categoryName = dictionary["categoryName"] as? String
    }
}

class HappeningToday {
    
    var id : Int?
    var placeId : Int?
    var eventId : Int?
    var placeName : String?
    var eventName : String?
    var image : String?
    var date : String?
    var isFavorite : Bool?
    var from : String?
    var to : String?
    var address : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        placeId = dictionary["placeId"] as? Int
        eventId = dictionary["eventId"] as? Int
        
        placeName = dictionary["placeName"] as? String
        eventName = dictionary["eventName"] as? String
        image = dictionary["image"] as? String
        
        date = dictionary["date"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
        from = dictionary["from"] as? String
        
        to = dictionary["to"] as? String
        address = dictionary["address"] as? String
    }
}

class UpcomingEvents {
    var id : Int?
    var placeId : Int?
    var eventId : Int?
    var placeName : String?
    var eventName : String?
    var image : String?
    var date : String?
    var isFavorite : Bool?
    var from : String?
    var to : String?
    var address : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        placeId = dictionary["placeId"] as? Int
        eventId = dictionary["eventId"] as? Int
        
        placeName = dictionary["placeName"] as? String
        eventName = dictionary["eventName"] as? String
        image = dictionary["image"] as? String
        
        date = dictionary["date"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
        from = dictionary["from"] as? String
        
        to = dictionary["to"] as? String
        address = dictionary["address"] as? String
    }
}
