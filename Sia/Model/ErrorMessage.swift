//
//  ErrorMessage.swift
//  Sia
//
//  Created by Emojiios on 25/05/2023.
//

import Foundation

class ErrorMessage {
    
    var statusCode : Int?
    var errorMessage : String?
    var technicalMessage : String?
    
    init(dictionary:[String:Any]) {
        statusCode = dictionary["statusCode"] as? Int
        errorMessage = dictionary["errorMessage"] as? String
        technicalMessage = dictionary["technicalMessage"] as? String
    }
}
