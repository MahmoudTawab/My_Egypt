//
//  Language.swift
//  SHARMIVAL
//
//  Created by Emojiios on 12/09/2022.
//

import Foundation

class Language {
    
    var id = Int()
    var flage = String()
    var culture = String()
    var languageName = String()
    var screenTitle = String()
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int ?? 0
    flage = dictionary["flage"] as? String ?? ""
    culture = dictionary["culture"] as? String ?? ""
    languageName = dictionary["languageName"] as? String ?? ""
    screenTitle = dictionary["screenTitle"] as? String ?? ""
    }
    
    init(id:Int,flage:String,culture:String,languageName:String) {
    self.id = id
    self.flage = flage
    self.culture = culture
    self.languageName = languageName
    }
}
