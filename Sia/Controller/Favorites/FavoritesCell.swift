//
//  FavoritesCell.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

protocol FavoritesDelegate {
    func FavoritesAction(_ Cell:FavoritesCell)
    func FavoritesButtonAction(_ Cell:FavoritesCell)
}

class FavoritesCell : UICollectionViewCell {
    
    var Delegate : FavoritesDelegate?
    lazy var ImageView : ImageViewGradient = {
        let ImageView = ImageViewGradient()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Test")
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02018633992).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2954545831).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.696925053).cgColor]
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FavoritesAction)))
        return ImageView
    }()
    
    @objc func FavoritesAction() {
        Delegate?.FavoritesAction(self)
    }

    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(16))
        return Label
    }()
    

    lazy var FavoritesButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.backgroundColor = .clear
        Button.layer.shadowOpacity = 0.6
        Button.layer.shadowOffset = .zero
        Button.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        Button.addTarget(self, action: #selector(FavoritesButtonAction), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func FavoritesButtonAction() {
    Delegate?.FavoritesButtonAction(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        addSubview(TitleLabel)
        TitleLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        TitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlY(-15)).isActive = true
        TitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        
        
        addSubview(FavoritesButton)
        FavoritesButton.widthAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        FavoritesButton.heightAnchor.constraint(equalTo: FavoritesButton.widthAnchor).isActive = true
        FavoritesButton.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(20)).isActive = true
        FavoritesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FavoritesAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
