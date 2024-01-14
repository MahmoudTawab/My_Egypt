//
//  ImageAndLabel.swift
//  ImageAndLabel
//
//  Created by Emoji Technology on 22/09/2021.
//

import UIKit

class ImageAndLabel: UIView {

    @IBInspectable var TextLabel:String = "" {
      didSet {
          Label.text = TextLabel
          
          Label.speed = .rate(CGFloat(TextLabel.count * 3))
          Label.speed = .duration(CGFloat(TextLabel.count ) * 0.4)
      }
    }
    
    var IconImageWidth:NSLayoutConstraint!
    var IconImageHeight:NSLayoutConstraint!
    @IBInspectable var IconSize:CGSize = CGSize(width: ControlHeight(25), height: ControlHeight(25)) {
      didSet {
          IconImageWidth.constant = IconSize.width
          IconImageHeight.constant = IconSize.height
          self.layoutIfNeeded()
      }
    }
    
    lazy var IconImage : UIButton = {
        let ImageView = UIButton()
        let image = UIImage(named: "right-arrow")
        ImageView.setImage(image, for: .normal)
        ImageView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var Label : MarqueeLabel = {
        let Label = MarqueeLabel()
        Label.backgroundColor = .clear
        Label.textColor = IconImage.tintColor
        Label.isUserInteractionEnabled = true
        Label.lineBreakMode = .byTruncatingHead
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Bold", size: ControlWidth(22))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pauseTap)))
        return Label
    }()
    
    @objc func pauseTap(_ recognizer: UIGestureRecognizer) {
        let continuousLabel2 = recognizer.view as! MarqueeLabel
        if recognizer.state == .ended {
            continuousLabel2.isPaused ? continuousLabel2.unpauseLabel() : continuousLabel2.pauseLabel()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(IconImage)
        IconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        IconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        IconImageWidth = IconImage.widthAnchor.constraint(equalToConstant: ControlHeight(38))
        IconImageWidth?.isActive = true
        
        IconImageHeight = IconImage.heightAnchor.constraint(equalToConstant: ControlHeight(38))
        IconImageHeight?.isActive = true

        addSubview(Label)
        Label.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        Label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        Label.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: ControlY(2)).isActive = true
        Label.leadingAnchor.constraint(equalTo: IconImage.trailingAnchor, constant: ControlX(10)).isActive = true
        
        IconImage.transform = "lang".localizable == "ar" ? CGAffineTransform(rotationAngle: .pi) : .identity

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
