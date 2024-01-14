//
//  PopUpGuest.swift
//  Sia
//
//  Created by Emojiios on 21/05/2023.
//

import UIKit

class PopUpGuest: PopUpDownView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        View.addSubview(TitleLabel)
        TitleLabel.frame = CGRect(x: ControlX(20), y: ControlY(30), width: view.frame.width - ControlX(40), height: ControlWidth(30))
        
        View.addSubview(DetailsLabel)
        DetailsLabel.frame = CGRect(x: ControlX(20), y: TitleLabel.frame.maxY + ControlY(5), width: view.frame.width - ControlX(40), height: ControlWidth(140))
        
        View.addSubview(ContinueButton)
        ContinueButton.frame = CGRect(x: ControlX(60), y: DetailsLabel.frame.maxY + ControlY(5), width: view.frame.width - ControlX(120), height: ControlWidth(50))
        
        View.addSubview(CancelButton)
        CancelButton.frame = CGRect(x: ControlX(20), y: ContinueButton.frame.maxY + ControlY(15), width: view.frame.width - ControlX(40), height: ControlWidth(50))
    }
    
    lazy var TitleLabel : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(20))
    return Label
    }()
    
    lazy var DetailsLabel : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.numberOfLines = 0
    Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
    Label.backgroundColor = .clear
    return Label
    }()

    lazy var ContinueButton : ButtonNotEnabled = {
    let Button = ButtonNotEnabled(type: .system)
    Button.Radius = true
    Button.backgroundColor = #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1)
    Button.titleLabel?.textAlignment = .center
    Button.setTitleColor(UIColor.white, for: .normal)
    Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size:  ControlWidth(18))
    return Button
    }()
        
    lazy var CancelButton : UIButton = {
    let Button = UIButton(type: .system)
    Button.backgroundColor = .clear
    Button.titleLabel?.textAlignment = .center
    Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size:  ControlWidth(18))
    Button.setTitleColor(#colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1), for: .normal)
    return Button
    }()
    
    
}
