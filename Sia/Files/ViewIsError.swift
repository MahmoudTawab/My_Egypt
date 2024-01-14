//
//  ViewIsError.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 13/12/2021.
//

import UIKit

class ViewIsError: UIView {
    
    @IBInspectable var TextRefresh:String = "" {
      didSet {
        RefreshButton.setTitle(TextRefresh, for: .normal)
      }
    }
    
    @IBInspectable var ImageIcon:String = "" {
      didSet {
        IconImage.image = UIImage(named: ImageIcon)
      }
    }
    
    @IBInspectable var MessageTitle:String = "" {
      didSet {
      TitleLabel.text = MessageTitle
      }
    }
    
    @IBInspectable var MessageDetails:String = "" {
      didSet {
      Details.text = MessageDetails
      }
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(Background)
        Background.frame = rect
        
        addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: ControlX(20), y: ControlY(100), width: rect.width - ControlX(40), height: rect.height - ControlY(200))
        
        ViewScroll.addSubview(IconImage)
        ViewScroll.addSubview(TitleLabel)
                
        IconImage.frame = CGRect(x: ControlX(20), y:  ControlX(100), width: ViewScroll.frame.width - ControlX(40), height: ViewScroll.frame.height / 2.6)
            
        TitleLabel.frame = CGRect(x: ControlX(20), y: IconImage.frame.maxY + ControlX(20), width: ViewScroll.frame.width - ControlWidth(40), height: ControlWidth(30))
        
        ViewScroll.addSubview(Details)
        ViewScroll.addSubview(RefreshButton)
          
        Details.frame = CGRect(x: 0, y: TitleLabel.frame.maxY + ControlX(10), width: ViewScroll.frame.width, height: ControlWidth(90))
        RefreshButton.frame = CGRect(x: 0, y: ViewScroll.frame.height - ControlWidth(70), width: ViewScroll.frame.width, height: ControlWidth(50))
        
        ViewScroll.updateContentViewSize(ControlY(10))
    }

    lazy var Background : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Welcome2")
        return Image
    }()
    
    lazy var IconImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        return ImageView
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-XBold", size: ControlWidth(18))
        return Label
    }()
    
    lazy var Details : UITextView = {
        let TV = UITextView()
        TV.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        TV.textAlignment = .center
        TV.isSelectable = false
        TV.isEditable = false
        TV.backgroundColor = .clear
        TV.spasing = ControlWidth(4)
        TV.keyboardAppearance = .light
        TV.font = UIFont(name: "Nexa-Regular", size: ControlWidth(16))
        return TV
    }()
    
    lazy var RefreshButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.clipsToBounds = true
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()

    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()
}
