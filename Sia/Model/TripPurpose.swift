//
//  TripPurpose.swift
//  Sia
//
//  Created by Emojiios on 23/02/2023.
//

import Foundation

class TripPurpose {
    
    var listTrip = [ListTrip]()
    var screenData : ScreenData?
    var screenElements = [ScreenElements]()
    var UserTrips = [Int]()
    
    init(dictionary:[String:Any]) {

    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let List = dictionary["listTrip"] as? [[String:Any]] {
    for item in List {
    listTrip.append(ListTrip(dictionary: item))
    }
    }
        
    if let userTrips = dictionary["userTrips"] as? [Int] {
    for item in userTrips {
    UserTrips.append(item)
    }
    }
    }
}

class ListTrip {
    
    var id : Int?
    var purposeName : String?

    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    purposeName = dictionary["purposeName"] as? String
    }

}


