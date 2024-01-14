//
//  MyInformation.swift
//  Sia
//
//  Created by Emojiios on 15/03/2023.
//

import Foundation

class MyInformation {
    
    var userData:UserData?
    var screenData : ScreenData?
    var nationalties = [Nationalties]()
    
    init(dictionary:[String:Any]) {

    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let user = dictionary["userData"] as? [String:Any] {
    userData = UserData(dictionary: user)
    }
        
        
    if let DataNationalties = dictionary["nationalties"] as? [[String:Any]] {
    for item in DataNationalties {
    nationalties.append(Nationalties(dictionary: item))
    }
    }
        
    }
}
