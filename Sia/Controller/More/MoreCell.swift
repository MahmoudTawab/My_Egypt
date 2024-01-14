//
//  MoreCell.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

protocol MoreDelegate {
    func MoreAction(_ Cell:MoreCell)
}

class MoreCell : UITableViewCell {
    
    var Delegate : MoreDelegate?
    lazy var MoreLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 0
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(22))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MoreAction)))
        return Label
    }()
    
   @objc func MoreAction() {
       Delegate?.MoreAction(self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.isHidden = true
        backgroundColor = .clear
    
        self.addSubview(MoreLabel)
        MoreLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(24)).isActive = true
        MoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlY(20)).isActive = true
        MoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlY(-20)).isActive = true
        MoreLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor ,constant: ControlY(-24)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MoreAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


