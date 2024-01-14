//
//  Present.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit

class ViewController : UIViewController  {
        
    let TopHeight = UIApplication.shared.statusBarFrame.height
    
    var ShowWhatsUp : Bool = true {
        didSet {
        SetUpButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    ViewDots.removeFromSuperview()
    view.addSubview(ViewDots)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(ViewNoData)
        ViewNoData.frame = view.bounds
        
        
//        view.addSubview(Image)
//        Image.frame = CGRect(x: 40, y: view.center.y - 150, width: view.frame.width - 80, height: 300)
    }
    
    lazy var WhatsUpButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.alpha = 0
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "Group 57663"), for: .normal)
        Button.addTarget(self, action: #selector(ActionWhatsUp), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionWhatsUp() {
        ShowMessageAlert("SuccessIcon", "Start Your Chat", "We are ready to assist you, Do you need any assistance", false, {
         let WhatsappMessage = "Hello, I was surfing through the app and couldn't find what i need and i would appreciate your help".urlEncoded ?? ""
            
        let phone = HomeScreenData?.whatsAppNumber ?? "+201021111111"
        guard let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phone)&text=\(WhatsappMessage)") else {return}
                
        if UIApplication.shared.canOpenURL(whatsappURL) {
        if #available(iOS 10.0, *) {
        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        }else {
        UIApplication.shared.openURL(whatsappURL)
        }
        }
        
            
        },"Start")
    }
    
    lazy var CoinsButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.alpha = 0
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "Group 58578"), for: .normal)
        Button.addTarget(self, action: #selector(ActionCoins), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func ActionCoins() {
    Present(ViewController: self , ToViewController: EmergencyContactsVC())
    }
    
    func SetUpButton() {
    if WhatsUpButton.alpha == 0 && HomeScreenData?.whatsAppNumber != nil && ShowWhatsUp == true && CoinsButton.alpha == 0 {
    self.WhatsUpButton.frame = CGRect(x: self.view.frame.width + ControlWidth(75), y: self.view.frame.height - ControlWidth(160), width: ControlWidth(60), height: ControlWidth(60))
    self.CoinsButton.frame = CGRect(x: ControlWidth(-75), y: self.view.frame.height - ControlWidth(160), width: ControlWidth(58), height: ControlWidth(58))

    self.view.addSubview(self.WhatsUpButton)
    self.view.addSubview(self.CoinsButton)

            
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: []) {
    self.WhatsUpButton.alpha = 1
    self.WhatsUpButton.frame = CGRect(x: self.view.frame.width - ControlWidth(75), y: self.view.frame.height - ControlWidth(160), width: ControlWidth(60), height: ControlWidth(60))
    }
    }
      
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: []) {
    self.CoinsButton.alpha = 1
    self.CoinsButton.frame = CGRect(x: ControlWidth(15), y: self.view.frame.height - ControlWidth(159), width: ControlWidth(58), height: ControlWidth(58))
    }
    }
        
    }
    }
    
    lazy var ViewDots : DotsView = {
        let View = DotsView(frame: view.bounds)
        View.backgroundColor = .clear
        View.ViewPresent = self
        View.alpha = 0
        return View
    }()
    
    
    lazy var ViewNoData : ViewIsError = {
        let View = ViewIsError()
        View.backgroundColor = .clear
        View.isHidden = true
        View.ImageIcon = "ErrorService"
        View.TextRefresh = "Try Again"
        View.MessageTitle = "Something went wrong"
        View.MessageDetails = "Something went wrong while processing your request, please try again later"
        return View
    }()
    
    var ViewNoDataShow = false
    func SetUpIsError(_ Show:Bool ,_ selector: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.ViewNoData.alpha = 1
        self.ViewDots.endRefreshing(){}
            
        
        if !self.ViewNoDataShow {
        if Show {
        self.ViewNoDataShow = true
        self.ViewNoData.isHidden = false
        self.ViewNoData.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
        self.ViewNoData.transform = .identity})
        self.ViewNoData.RefreshButton.addAction(for: .touchUpInside) { (button) in
        selector()
        }
        }
        }
        }
    }
    
    
    
    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .red
        ImageView.contentMode = .scaleAspectFit
        return ImageView
    }()

    
    
}



