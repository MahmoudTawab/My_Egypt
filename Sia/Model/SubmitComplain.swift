//
//  SubmitComplain.swift
//  Sia
//
//  Created by Emojiios on 03/04/2023.
//

import Foundation

class SubmitComplain {
    
    var screenData : ScreenData?
    var Topics = [ComplainTopics]()
    
    init(dictionary:[String:Any]) {
        
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let complainTopics = dictionary["complainTopics"] as? [[String:Any]] {
    for item in complainTopics {
    Topics.append(ComplainTopics(dictionary: item))
    }
    }
    }
}

class ComplainTopics {
    
    var id : Int?
    var topicName : String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    topicName = dictionary["topicName"] as? String
    }
}


