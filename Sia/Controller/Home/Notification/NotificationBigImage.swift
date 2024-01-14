//
//  NotificationBigImage.swift
//  Sia
//
//  Created by Emojiios on 01/02/2023.
//

import UIKit

protocol NotificationBigImageDelegate {
    func CellBigImageAction(_ Cell:NotificationBigImage)
}

class NotificationBigImage : SwipeTableViewCell {
    
    var Delegate : NotificationBigImageDelegate?
    lazy var Image : ImageViewGradient = {
        let ImageView = ImageViewGradient()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(8)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02018633992).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2954545831).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.696925053).cgColor]
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageAction)))
        return ImageView
    }()
    
    @objc func ImageAction() {
        Delegate?.CellBigImageAction(self)
    }
    
    lazy var FavoritesButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.backgroundColor = .clear
        Button.layer.shadowOpacity = 0.6
        Button.layer.shadowOffset = .zero
        Button.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(FavoritesButtonAction), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func FavoritesButtonAction() {
    Delegate?.CellBigImageAction(self)
    }
    
    lazy var RatingButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.backgroundColor = .clear
        Button.contentVerticalAlignment = .center
        Button.contentHorizontalAlignment = .leading
        Button.titleEdgeInsets.top = ControlWidth(2)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size:  ControlWidth(15))
        Button.setTitleColor(#colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1), for: .normal)
        Button.setImage(UIImage(named: "magic-star")?.imageWithImage(scaledToSize: CGSize(width: ControlWidth(18), height: ControlWidth(18))), for: .normal)
        return Button
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(16))
        return Label
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
        CellBackground.topAnchor.constraint(equalTo: topAnchor,constant: ControlY(10)).isActive = true
        CellBackground.leftAnchor.constraint(equalTo: leftAnchor,constant: ControlY(15)).isActive = true
        CellBackground.rightAnchor.constraint(equalTo: rightAnchor,constant: ControlY(-15)).isActive = true
        CellBackground.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-15)).isActive = true
        
        CellBackground.addSubview(Image)
        Image.heightAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
        Image.topAnchor.constraint(equalTo: CellBackground.topAnchor,constant: ControlY(15)).isActive = true
        Image.leadingAnchor.constraint(equalTo: CellBackground.leadingAnchor,constant: ControlY(15)).isActive = true
        Image.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor,constant: ControlY(-15)).isActive = true
        
        addSubview(TitleLabel)
        TitleLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        TitleLabel.bottomAnchor.constraint(equalTo: Image.bottomAnchor,constant: ControlY(-15)).isActive = true
        TitleLabel.leadingAnchor.constraint(equalTo: Image.leadingAnchor,constant: ControlX(15)).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: Image.trailingAnchor,constant: ControlX(-80)).isActive = true
        
        addSubview(RatingButton)
        RatingButton.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        RatingButton.heightAnchor.constraint(equalTo: TitleLabel.heightAnchor).isActive = true
        RatingButton.centerYAnchor.constraint(equalTo: TitleLabel.centerYAnchor).isActive = true
        RatingButton.trailingAnchor.constraint(equalTo: Image.trailingAnchor,constant: ControlX(-10)).isActive = true
        
        CellBackground.addSubview(LabelDetails)
        LabelDetails.topAnchor.constraint(equalTo: Image.bottomAnchor,constant: ControlY(20)).isActive = true
        LabelDetails.leadingAnchor.constraint(equalTo: CellBackground.leadingAnchor,constant: ControlY(15)).isActive = true
        LabelDetails.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor,constant: ControlY(-25)).isActive = true
        LabelDetails.bottomAnchor.constraint(equalTo: CellBackground.bottomAnchor ,constant: ControlY(-20)).isActive = true
        
        addSubview(FavoritesButton)
        FavoritesButton.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        FavoritesButton.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        FavoritesButton.topAnchor.constraint(equalTo: CellBackground.topAnchor,constant: ControlY(15)).isActive = true
        FavoritesButton.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor,constant: ControlX(-15)).isActive = true
        
        addSubview(IconRead)
        IconRead.topAnchor.constraint(equalTo: LabelDetails.topAnchor).isActive = true
        IconRead.widthAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        IconRead.heightAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        IconRead.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor,constant: ControlX(-15)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

