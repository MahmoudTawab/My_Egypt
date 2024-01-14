//
//  ModelCategories.swift
//  Sia
//
//  Created by Emojiios on 14/03/2023.
//

import Foundation

class ModelCategories {
    
    var screenData : ScreenData?
    var categories = [Categories]()
    init(dictionary:[String:Any]) {
             
    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let DataCategories = dictionary["categories"] as? [[String:Any]] {
    for item in DataCategories {
    categories.append(Categories(dictionary: item))
    }
    }

    }
}
