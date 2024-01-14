//
//  CurrenciesAndCities.swift
//  Sia
//
//  Created by Emojiios on 06/03/2023.
//

import Foundation

class CurrenciesAndCities {
    
    var cities = [Cities]()
    var screenData : ScreenData?
    var currencies = [Currencies]()
    
    init(dictionary:[String:Any]) {

    if let DataScreen = dictionary["screenData"] as? [String:Any] {
    screenData = ScreenData(dictionary: DataScreen)
    }
        
    if let DataCurrencies = dictionary["currencies"] as? [[String:Any]] {
    for item in DataCurrencies {
    currencies.append(Currencies(dictionary: item))
    }
    }
        
    if let DataCities = dictionary["cities"] as? [[String:Any]] {
    for item in DataCities {
    cities.append(Cities(dictionary: item))
    }
    }
    }

}

class Currencies {
    var id : Int?
    var currencyName : String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    currencyName = dictionary["currencyName"] as? String
    }
}

class Cities {
    var id : Int?
    var cityName : String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    cityName = dictionary["cityName"] as? String
    }
}
