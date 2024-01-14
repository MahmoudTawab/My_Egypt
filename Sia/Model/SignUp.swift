//
//  SignUp.swift
//  Sia
//
//  Created by Emojiios on 06/03/2023.
//

import Foundation

class SignUp {
    
    var screenData : ScreenData?
    var nationalties = [Nationalties]()
    
    init(dictionary:[String:Any]) {

    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let DataNationalties = dictionary["nationalties"] as? [[String:Any]] {
    for item in DataNationalties {
    nationalties.append(Nationalties(dictionary: item))
    }
    }
    }

}

class Nationalties {
    var id : Int?
    var nationaltyName : String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    nationaltyName = dictionary["nationaltyName"] as? String
    }
}
