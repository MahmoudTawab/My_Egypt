//
//  GpsTrackingCell.swift
//  Sia
//
//  Created by Emojiios on 02/02/2023.
//

import UIKit

protocol GpsTrackingDelegate {
    func GpsTrackingAction(_ Cell:GpsTrackingCell)
}

class GpsTrackingCell : UICollectionViewCell {
    
    var Delegate:GpsTrackingDelegate?
    lazy var ButtonLabel : ButtonNotEnabled = {
        let Button = ButtonNotEnabled()
        Button.tintColor = #colorLiteral(red: 0.9684386849, green: 0.8215563297, blue: 0.5260710716, alpha: 1)
        Button.backgroundColor = .clear
        Button.titleLabel?.numberOfLines = 2
        Button.contentVerticalAlignment = .center
        Button.contentHorizontalAlignment = .center
        Button.titleLabel?.textAlignment = .center
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setBackgroundImage(UIImage(named: "MorePath"), for: .normal)
        Button.titleLabel?.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(17))
        Button.addTarget(self, action: #selector(GpsTrackingAction), for: .touchUpInside)
        Button.titleEdgeInsets = UIEdgeInsets(top: 0, left: ControlX(20), bottom: 0, right: ControlX(20))
        return Button
    }()
    
    @objc func GpsTrackingAction() {
        Delegate?.GpsTrackingAction(self)
    }
        
    var IsLeading:NSLayoutConstraint?
    var IsTrailing:NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ButtonLabel)
        ButtonLabel.centerYAnchor.constraint(equalTo:  self.centerYAnchor).isActive = true
        ButtonLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2).isActive = true
        
        IsLeading = ButtonLabel.leadingAnchor.constraint(equalTo:  self.leadingAnchor,constant: ControlX(65))
        IsLeading?.isActive = true
        
        IsTrailing = ButtonLabel.trailingAnchor.constraint(equalTo:  self.trailingAnchor,constant: ControlX(-65))
        IsTrailing?.isActive = true
        
        ButtonLabel.widthAnchor.constraint(equalToConstant: ControlWidth(165)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GpsTrackingAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

