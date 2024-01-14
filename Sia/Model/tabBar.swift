//
//  tabBar.swift
//  Sia
//
//  Created by Emojiios on 05/03/2023.
//

import Foundation


class tabBar {
    
    var tab1 : String?
    var tab2 : String?
    var tab3 : String?
    var tab4 : String?
    var tab5 : String?
    
    init(dictionary:[String:Any]) {
    tab1 = dictionary["tab1"] as? String
    tab2 = dictionary["tab2"] as? String
    tab3 = dictionary["tab3"] as? String
    tab4 = dictionary["tab4"] as? String
    tab5 = dictionary["tab5"] as? String
    }
}
