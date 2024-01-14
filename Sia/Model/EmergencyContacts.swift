//
//  EmergencyContacts.swift
//  Sia
//
//  Created by Emojiios on 04/04/2023.
//

import Foundation

class EmergencyContacts {
    
    var screenData : ScreenData?
    var emergencyContacts : Contacts?
    init(dictionary:[String:Any]) {
             
    if let contacts = dictionary["emergencyContacts"] as? [String:Any] {
    emergencyContacts = Contacts(dictionary: contacts)
    }
        
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
    }
}


class Contacts {
    
    
    var policeNumber : String?
    var ambulanceNumber : String?
    var fireBrigadeNumber : String?
    
    
    init(dictionary:[String:Any]) {
             
    policeNumber = dictionary["policeNumber"] as? String
    ambulanceNumber = dictionary["ambulanceNumber"] as? String
    fireBrigadeNumber = dictionary["fireBrigadeNumber"] as? String
    }
}
