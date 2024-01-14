//
//  NotificationSmallImage.swift
//  Sia
//
//  Created by Emojiios on 01/02/2023.
//


import UIKit

class NotificationSmallImage: SwipeTableViewCell {
        
    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
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
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(15))
        return Label
    }()
    
    lazy var CellBackground : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9147865772, green: 0.9181856513, blue: 0.9216593504, alpha: 1)
        View.clipsToBounds = true
        View.layer.cornerRadius = ControlX(12)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(CellBackground)
        CellBackground.topAnchor.constraint(equalTo: topAnchor,constant: ControlY(20)).isActive = true
        CellBackground.leftAnchor.constraint(equalTo: leftAnchor,constant: ControlY(15)).isActive = true
        CellBackground.rightAnchor.constraint(equalTo: rightAnchor,constant: ControlY(-15)).isActive = true
        CellBackground.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-20)).isActive = true
        
        CellBackground.addSubview(LabelDetails)
        LabelDetails.topAnchor.constraint(equalTo: topAnchor,constant: ControlY(30)).isActive = true
        LabelDetails.leadingAnchor.constraint(equalTo: CellBackground.leadingAnchor,constant: ControlY(80)).isActive = true
        LabelDetails.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor,constant: ControlY(-25)).isActive = true
        LabelDetails.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-30)).isActive = true
        
        
        CellBackground.addSubview(Image)
        Image.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Image.heightAnchor.constraint(equalTo: Image.widthAnchor).isActive = true
        Image.topAnchor.constraint(equalTo: CellBackground.topAnchor,constant: ControlY(10)).isActive = true
        Image.bottomAnchor.constraint(equalTo: CellBackground.bottomAnchor,constant: ControlY(-10)).isActive = true
        Image.leadingAnchor.constraint(equalTo: CellBackground.leadingAnchor,constant: ControlY(15)).isActive = true
        
        
        addSubview(IconRead)
        IconRead.topAnchor.constraint(equalTo: LabelDetails.topAnchor).isActive = true
        IconRead.widthAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        IconRead.heightAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        IconRead.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor,constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


