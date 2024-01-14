//
//  SiaInsightsViewVC.swift
//  Sia
//
//  Created by Emojiios on 30/05/2023.
//

import UIKit

class SiaInsightsViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        view.addSubview(Image)
        Image.frame = CGRect(x: ControlX(20), y: ControlY(120), width: view.frame.width - ControlX(40), height: view.frame.height - ControlY(160))
        
        view.addSubview(MessageTV)
        MessageTV.frame = CGRect(x: Image.frame.minX + ControlX(20), y: Image.frame.minY + ControlY(30), width: Image.frame.width - ControlX(40), height: Image.frame.height - ControlY(90))
        
        
        view.addSubview(SiaInsights)
        SiaInsights.frame = CGRect(x: view.center.x - ControlWidth(25), y: Image.frame.maxY - ControlY(50), width: ControlWidth(50), height: ControlWidth(50))
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlWidth(20), y: ControlY(60), width: ControlWidth(40), height: ControlWidth(40))
    }

    
    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "SiaInsightsView")
        return ImageView
    }()
    
    lazy var SiaInsights : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "SiaInsights2")
        return ImageView
    }()
    
    lazy var  MessageTV : UITextView = {
        let TV = UITextView()
        TV.textColor = .black
        TV.isEditable = false
        TV.isSelectable = false
        TV.backgroundColor = .clear
        TV.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(16))
        return TV
    }()

    lazy var Dismiss : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setTitle("✕", for: .normal)
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.addTarget(self, action: #selector(ActionDismiss), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(30))
        return Button
    }()
        
    @objc func ActionDismiss() {
      self.dismiss(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
}
