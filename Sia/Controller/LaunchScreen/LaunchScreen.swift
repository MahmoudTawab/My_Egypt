//
//  LaunchScreen.swift
//  Sia
//
//  Created by Emojiios on 11/10/2022.
//

import UIKit

class LaunchScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(StackImage)
        StackImage.frame = view.bounds
        
        AddDevice()
    }
        
    lazy var StackImage : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopImage,LogoImage,BottomImage])
        Stack.axis = .vertical
        Stack.alignment = .center
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        Stack.arrangedSubviews[0].widthAnchor.constraint(equalTo: Stack.widthAnchor).isActive = true
        Stack.arrangedSubviews[2].widthAnchor.constraint(equalTo: Stack.widthAnchor).isActive = true
        Stack.arrangedSubviews[1].heightAnchor.constraint(equalTo: Stack.heightAnchor, multiplier: 1/5).isActive = true
        Stack.arrangedSubviews[1].widthAnchor.constraint(equalTo: Stack.widthAnchor, multiplier: 1/1.7).isActive = true
        return Stack
    }()
    
    lazy var TopImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Top")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LogoImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = UIImage(named: "Logo")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var BottomImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Bottom")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    
    @objc func AddDevice() {
    let url = defaults.string(forKey: "API") == "" ? "https://siaapi01.azurewebsites.net/api/" : defaults.string(forKey: "API") ?? "https://siaapi01.azurewebsites.net/api/"
    let api = "\(url + SplashScreen)"

    let modelName = UIDevice.modelName
    let version = UIDevice.current.systemVersion
    let fireToken = defaults.string(forKey: "fireToken") ?? ""
        
    let UUID = UUID().uuidString
    defaults.set(UUID, forKey: "uuidString")
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? UUID
    let RefreshToken = defaults.string(forKey: "refreshToken") ?? ""
        
    let parameters:[String:Any] = ["token": "g0Ru1T8Q8gFElqFQLRxBHxU2FbRfZLoNCx6pPOnCtwwzRs0zw9",
                                "fireToken": fireToken,
                                "deviceID": udid,
                                "deviceModel": modelName,
                                "manuFacturer": "Iphone",
                                "osVersion": version,
                                "versionCode": "1",
                                "RefreshToken":RefreshToken]
        
    PostAPI(timeout: 30,api: api, token: nil, parameters: parameters) { _ in
    } dictionary: { dictionary in
    HomeScreenData = HomeScreen(dictionary: dictionary)
        
    if HomeScreenData?.lang == 2 {
    MOLH.setLanguageTo("ar")
    MOLH.reset()
    }else{
    MOLH.setLanguageTo("en")
    MOLH.reset()
    }
        
//    self.perform(#selector(self.ScreenPresent), with: self, afterDelay: 1)
    } array: { _ in
    } Err: { error in
    defaults.removeObject(forKey: "refreshToken")
    self.perform(#selector(self.AddDevice), with: self, afterDelay: 2)
    }
    }
    
//    @objc func ScreenPresent() {
//        if defaults.string(forKey: "refreshToken") == ""  {
//        FirstController(LocalizableScreen())
//        }else if defaults.string(forKey: "refreshToken") != nil && defaults.bool(forKey: "ShowLocalizable") == true {
//        FirstController(TabBarController())
//        }else if defaults.string(forKey: "refreshToken") != nil && defaults.bool(forKey: "ShowLocalizable") == false {
//        FirstController(LocalizableScreen())
//        }
//    }
}

