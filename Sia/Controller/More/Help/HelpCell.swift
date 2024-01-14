//
//  HelpCell.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

protocol HelpDelegate {
    func HelpAction(_ Cell:HelpCell)
}

class HelpCell : UICollectionViewCell {
    
    var Delegate:HelpDelegate?
    lazy var ButtonLabel : ButtonNotEnabled = {
        let Button = ButtonNotEnabled()
        Button.tintColor = #colorLiteral(red: 0.8505190611, green: 0.9327031374, blue: 0.9911902547, alpha: 1)
        Button.backgroundColor = .clear
        Button.titleLabel?.numberOfLines = 2
        Button.contentVerticalAlignment = .center
        Button.contentHorizontalAlignment = .center
        Button.titleLabel?.textAlignment = .center
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setBackgroundImage(UIImage(named: "MorePath"), for: .normal)
        Button.addTarget(self, action: #selector(HelpAction), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(17))
        Button.titleEdgeInsets = UIEdgeInsets(top: 0, left: ControlX(20), bottom: 0, right: ControlX(20))
        return Button
    }()
    
    @objc func HelpAction() {
        Delegate?.HelpAction(self)
    }

    
    var IsLeading:NSLayoutConstraint?
    var IsTrailing:NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ButtonLabel)
        ButtonLabel.centerYAnchor.constraint(equalTo:  self.centerYAnchor).isActive = true
        ButtonLabel.heightAnchor.constraint(equalTo: heightAnchor,constant: ControlX(-60)).isActive = true

        IsLeading = ButtonLabel.leadingAnchor.constraint(equalTo:  self.leadingAnchor,constant: ControlX(65))
        IsLeading?.isActive = true
        
        IsTrailing = ButtonLabel.trailingAnchor.constraint(equalTo:  self.trailingAnchor,constant: ControlX(-65))
        IsTrailing?.isActive = true
        
        ButtonLabel.widthAnchor.constraint(equalToConstant: ControlWidth(165)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HelpAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
