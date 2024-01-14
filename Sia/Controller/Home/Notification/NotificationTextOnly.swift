//
//  NotificationTextOnly.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

protocol NotificationTextOnlyDelegate {
    func NotificationTextAction(_ Cell:NotificationTextOnly)
}

class NotificationTextOnly: SwipeTableViewCell {
        
    
    var Delegate : NotificationTextOnlyDelegate?
    lazy var IconRead : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        View.layer.cornerRadius = ControlWidth(6)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1445993483, green: 0.1824055314, blue: 0.2151901722, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(15))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NotificationTextAction)))
        return Label
    }()
    
    lazy var CellBackground : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9147865772, green: 0.9181856513, blue: 0.9216593504, alpha: 1)
        View.clipsToBounds = true
        View.isUserInteractionEnabled = true
        View.layer.cornerRadius = ControlX(12)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NotificationTextAction)))
        return View
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(CellBackground)
        CellBackground.topAnchor.constraint(equalTo: topAnchor,constant: ControlY(10)).isActive = true
        CellBackground.leftAnchor.constraint(equalTo: leftAnchor,constant: ControlY(15)).isActive = true
        CellBackground.rightAnchor.constraint(equalTo: rightAnchor,constant: ControlY(-15)).isActive = true
        CellBackground.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-10)).isActive = true
        
        CellBackground.addSubview(LabelDetails)
        LabelDetails.topAnchor.constraint(equalTo: CellBackground.topAnchor,constant: ControlY(15)).isActive = true
        LabelDetails.leadingAnchor.constraint(equalTo: CellBackground.leadingAnchor,constant: ControlY(15)).isActive = true
        LabelDetails.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor,constant: ControlY(-25)).isActive = true
        LabelDetails.bottomAnchor.constraint(equalTo: CellBackground.bottomAnchor ,constant: ControlY(-15)).isActive = true
        
        addSubview(IconRead)
        IconRead.topAnchor.constraint(equalTo: LabelDetails.topAnchor).isActive = true
        IconRead.widthAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        IconRead.heightAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        IconRead.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor,constant: ControlX(-15)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NotificationTextAction)))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func NotificationTextAction() {
        Delegate?.NotificationTextAction(self)
    }
    
}


