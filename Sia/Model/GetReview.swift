//
//  ModelGetReview.swift
//  Sia
//
//  Created by Emojiios on 14/03/2023.
//

import Foundation

class ModelGetReview {
    
    var screenData : ScreenData?
    var review : Review?

    init(dictionary:[String:Any]) {
             
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let Datareview = dictionary["review"] as? [String:Any] {
    review = Review(dictionary: Datareview)
    }
    }
}

class Review {
    
    var id : Int?
    var rate : Double?
    var comment : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        rate = round(dictionary["rate"] as? Double ?? 0.0)
        comment = dictionary["comment"] as? String
    }
    
}
