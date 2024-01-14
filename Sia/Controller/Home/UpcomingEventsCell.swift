//
//  UpcomingEventsCell.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit

protocol UpcomingEventsDelegate {
    func UpcomingEventsAction(_ Cell:UpcomingEventsCell)
}

class UpcomingEventsCell : UICollectionViewCell {
    
    var Delegate : UpcomingEventsDelegate?
    lazy var ImageView : ImageViewGradient = {
        let ImageView = ImageViewGradient()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02018633992).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2011447828).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3955077087).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6033888836).cgColor]
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UpcomingEventsAction)))
        return ImageView
    }()

    lazy var GovernorateLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()
    
    lazy var EventTypeLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(16))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [GovernorateLabel,EventTypeLabel])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    lazy var HappeningNowButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "Group 57450"), for: .normal)
        Button.addTarget(self, action: #selector(UpcomingEventsAction), for: .touchUpInside)
        return Button
    }()
    
    @objc func UpcomingEventsAction() {
        Delegate?.UpcomingEventsAction(self)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(20)).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlY(-25)).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(10)).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
        
        
        addSubview(StackLabel)
        StackLabel.heightAnchor.constraint(equalToConstant: ControlWidth(90)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlY(-20)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: ImageView.leadingAnchor,constant: ControlX(20)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: ImageView.trailingAnchor,constant: ControlX(-65)).isActive = true
        
        addSubview(HappeningNowButton)
        HappeningNowButton.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        HappeningNowButton.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        HappeningNowButton.bottomAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlY(-25)).isActive = true
        HappeningNowButton.trailingAnchor.constraint(equalTo: ImageView.trailingAnchor,constant: ControlX(-15)).isActive = true
                
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UpcomingEventsAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
