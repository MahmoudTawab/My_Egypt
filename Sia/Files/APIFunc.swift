//
//  APIFunc.swift
//  APIFunc
//
//  Created by Emoji Technology on 27/09/2021.
//  Copyright © 2021 Mahmoud Tawab. All rights reserved.
//


import UIKit
import SDWebImage
import FirebaseStorage

   func PostAPI(timeout:Double = 40,api:String ,token:String?
                 , parameters:Any
                 , string: @escaping ((String) -> Void)
                 , dictionary: @escaping (([String: Any]) -> Void)
                 , array: @escaping (([[String: Any]]) -> Void)
                 , Err: @escaping ((String) -> Void)) {
        
        
    guard let Url = URL(string:api) else {return}
    var request = URLRequest(url: Url)
    request.httpMethod = "POST"
    request.timeoutInterval = timeout
    timeInterval = timeout + 2
      
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    if let Token = token {
    request.setValue( "Bearer \(Token)", forHTTPHeaderField: "Authorization")
    }

    do {
    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
    Err(error.localizedDescription)
    return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in

    guard let data = data else {
    if error != nil {
    DispatchQueue.main.async {
    Err(StatusCodes(-1001, "Connection Error!!" +  "\n" + "Please try again"))
    }
    }
    return
    }

    do {
    guard let response = response as? HTTPURLResponse else {return}
    if response.statusCode != 200 {
    if let Dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    DispatchQueue.main.async {
    if let Code = ErrorMessage(dictionary: Dictionary).statusCode ,let Message = ErrorMessage(dictionary: Dictionary).technicalMessage {
    Err(StatusCodes(Code, Message))
    }
    }
    }
    return
    }else{
    DispatchQueue.main.async {
    string("Successful")
    }
    }
        
//  let str = String(decoding: data, as: UTF8.self)
    do {
    let decodedPerson = try JSONDecoder().decode(String.self, from: data)
    
    if let data = decodedPerson.data(using: .utf8) {
    if let Dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    DispatchQueue.main.async {
    dictionary(Dictionary)
    }
    }
     
    if let Array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
    DispatchQueue.main.async {
    array(Array)
    }
    }
      
    }
    }catch{
    if let Array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
    DispatchQueue.main.async {
    array(Array)
    }
    }
        
    if let Dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    DispatchQueue.main.async {
    dictionary(Dictionary)
    }
    }
    }
    }catch{
    return
    }
    }.resume()
    }

  func StatusCodes(_ Status:Int ,_ Messag : String = "") -> String {

    switch Status {

        ///
    
    case 204:
    return Messag
        
    case 304:
    return Messag
        
       ///
    case 400:
    return Messag
       
       ///
    case 401:
    UpDateDevice()
    return ""
       
    ///
    case 404:
    return Messag
        
    case 405:
    return Messag
    
    ///
    case 406:
    return Messag
      
    case 500:
    return Messag
        
    case 600:
    return Messag
        
    case 601:
    return Messag
        
    case 602:
    return Messag
        
    case 604:
    return Messag
        
    ///
    case -1001:
    return Messag
       
    default:
    break
    }

    return ""
    }


   func ShowMessageAlert(_ IconTitle:String ,_ Title:String ,_ Message:String,_ DoneisHidden:Bool ,_ selector: @escaping () -> Void ,_ RightButton : String = "Try Again" ,_ LeftButton : String = "Close") {
        
    if var topController = UIApplication.shared.keyWindow?.rootViewController  {
    while let presentedViewController = topController.presentedViewController {
    topController = presentedViewController
    }
    
    let Controller = PopUpCenterView()
    Controller.MessageTitle = Title
    Controller.MessageDetails = Message
    Controller.ImageIcon = IconTitle
    Controller.StackIsHidden = false
    Controller.RightButton.isHidden = DoneisHidden
    Controller.LeftButton.setTitle(LeftButton, for: .normal)
    Controller.RightButton.setTitle(RightButton, for: .normal)



    Controller.RightButton.addAction(for: .touchUpInside) { (button) in
    selector()
    }
    
    Controller.modalPresentationStyle = .overFullScreen
    Controller.modalTransitionStyle = .crossDissolve
    topController.present(Controller, animated: true, completion: nil)
    }
    }

    func UpDateDevice() {
    let url = defaults.string(forKey: "API") == "" ? "https://siaapi01.azurewebsites.net/api/" : defaults.string(forKey: "API") ?? "https://siaapi01.azurewebsites.net/api/"
    let api = "\(url + SplashScreen)"

    let modelName = UIDevice.modelName
    let version = UIDevice.current.systemVersion
    let fireToken = defaults.string(forKey: "fireToken") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? defaults.string(forKey: "uuidString") ?? ""

    let parameters:[String:Any] = ["token": "g0Ru1T8Q8gFElqFQLRxBHxU2FbRfZLoNCx6pPOnCtwwzRs0zw9",
                                   "fireToken": fireToken,
                                   "deviceID": udid,
                                   "deviceModel": modelName,
                                   "manuFacturer": "Iphone",
                                   "osVersion": version,
                                   "versionCode": "1"]
        
    PostAPI(timeout: 20,api: api, token: nil, parameters: parameters) { _ in
    } dictionary: { dictionary in
    let _ = HomeScreen(dictionary: dictionary)
    } array: { _ in
    } Err: { error in
    }
   }


    func Storag(child1:String = "" ,child2:String = "",child3:String = "",child4:String = "" , image: UIImage, completionHandler: @escaping ((String) -> Void), Err: @escaping ((String) -> Void)) {
    let storage = Storage.storage().reference().child(child1).child(child2).child(child3).child(child4)
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    guard let data = image.jpegData(compressionQuality: 0.75) else {return}
    storage.putData(data, metadata: metaData, completion: { (url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    storage.downloadURL {(url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    guard let add_downloadUrl = url?.absoluteString else{return}
    completionHandler(add_downloadUrl)
    }
    })
    }


 func StoragRemove(child1:String = "" ,child2:String = "",child3:String = "",child4:String = "")  {
     let storage = Storage.storage().reference().child(child1).child(child2).child(child3).child(child4)
     storage.delete(completion: { error in
     print(error ?? "")
     })
}


func StoragUpDate(child1:String = "" ,child2:String = "",child3:String = "",child4:String = "")  {
    let storage = Storage.storage().reference().child(child1).child(child2).child(child3).child(child4)
    storage.delete(completion: { error in
    print(error ?? "")
    })
}
