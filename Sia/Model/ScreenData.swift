//
//  ScreenData.swift
//  Sia
//
//  Created by Emojiios on 06/03/2023.
//

import Foundation

class ScreenData {
    
    var id: Int?
    var name : String?
    var title : String?
    var Bar : tabBar?
    var screenElements = [ScreenElements]()
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        title = dictionary["title"] as? String
        
        if let bar = dictionary["tabBar"] as? [String:Any] {
        Bar = tabBar(dictionary: bar)
        }
        
        if let ElementsScreen = dictionary["screenElements"] as? [[String:Any]] {
        for item in ElementsScreen {
        screenElements.append(ScreenElements(dictionary: item))
        }
        }
    }
}

class ScreenElements {

    var id: Int?
    var name : String?
    var lable : String?
    var radioText1 : String?
    var radioText2 : String?
    var placeholder : String?
    var validationMessages = [ValidationMessages]()

    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        lable = dictionary["lable"] as? String
        
        radioText1 = dictionary["radioText1"] as? String
        radioText2 = dictionary["radioText2"] as? String
        placeholder = dictionary["placeholder"] as? String
        
        if let validation = dictionary["validationMessages"] as? [[String:Any]] {
        for item in validation {
        validationMessages.append(ValidationMessages(dictionary: item))
        }
        }
    }
}

class ValidationMessages {

    var id: Int?
    var errorName : String?
    var errorMessage : String?

    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        errorName = dictionary["errorName"] as? String
        errorMessage = dictionary["errorMessage"] as? String
    }
}



func DataGetScreen(_ View:ViewController,_ screenId:Int ,_ DidEnd: @escaping ((ScreenData) -> Void),_ IfError: @escaping ((Bool) -> Void))  {
    if let url = defaults.string(forKey: "API") {
    let api = "\(url + GetScreenData)"
    
    View.ViewDots.beginRefreshing()
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["screenId": screenId]
    
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { dictionary in
    View.ViewDots.endRefreshing {}
    DidEnd(ScreenData(dictionary: dictionary))
    IfError(false)
    } array: { _ in
    } Err: { error in
    IfError(true)
    }

    }else{
    LodBaseUrl()
    View.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    }
    
}
