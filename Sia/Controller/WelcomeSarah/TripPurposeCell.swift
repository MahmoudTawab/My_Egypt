//
//  TripPurposeCell.swift
//  Sia
//
//  Created by Emojiios on 17/10/2022.
//

import UIKit

protocol TripPurposeDelegate {
    func TripPurposeAction(_ Cell:TripPurposeCell)
}

class TripPurposeCell : UICollectionViewCell {
    
    var Delegate : TripPurposeDelegate?
    lazy var Label : MarqueeLabel = {
        let Label = MarqueeLabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 1
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.lineBreakMode = .byTruncatingHead
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(13))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TripPurposeAction)))
        return Label
    }()
    

    @objc func TripPurposeAction() {
        Delegate?.TripPurposeAction(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(Label)
        Label.topAnchor.constraint(equalTo:  self.topAnchor).isActive = true
        Label.bottomAnchor.constraint(equalTo:  self.bottomAnchor).isActive = true
        Label.leadingAnchor.constraint(equalTo:  self.leadingAnchor,constant: ControlX(5)).isActive = true
        Label.trailingAnchor.constraint(equalTo:  self.trailingAnchor,constant: ControlX(-5)).isActive = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TripPurposeAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
