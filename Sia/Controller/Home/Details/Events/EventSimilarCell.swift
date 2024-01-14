//
//  EventSimilarCell.swift
//  Sia
//
//  Created by Emojiios on 25/10/2022.
//

import UIKit

protocol EventSimilarDelegate {
    func ActionReserve(_ Cell:EventSimilarCell)
    func EventSimilarAction(_ Cell:EventSimilarCell)
    func EventActionFavorites(_ Cell:EventSimilarCell)

}

class EventSimilarCell : UICollectionViewCell {
    
    var Delegate : EventSimilarDelegate?
    lazy var ImageView : ImageViewGradient = {
        let ImageView = ImageViewGradient()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(10)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02018633992).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2011447828).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3955077087).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6033888836).cgColor]
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SimilarPlacesAction)))
        return ImageView
    }()

    @objc func SimilarPlacesAction() {
        Delegate?.EventSimilarAction(self)
    }
    
    lazy var SimilarName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        return Label
    }()
    
    lazy var SimilarDescription : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(14))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        return Label
    }()
    
    lazy var Reserve : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = true
        Button.backgroundColor = #colorLiteral(red: 0.7583009601, green: 0.3631356359, blue: 0.1871258616, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(14))
        Button.addTarget(self, action: #selector(ActionReserve), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        return Button
    }()

    @objc func ActionReserve() {
        Delegate?.ActionReserve(self)
    }
    
    lazy var StackInfo : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [UIView(),Reserve])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        return Stack
    }()
    
    lazy var StackTypeAndRating : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SimilarName,RatingButton])
        Stack.axis = .horizontal
        Stack.alignment = .center
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Stack
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [StackTypeAndRating,SimilarDescription,StackInfo])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    lazy var RatingButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = .clear
        Button.setTitleColor(.white, for: .normal)
        Button.contentVerticalAlignment = .center
        Button.contentHorizontalAlignment = .trailing
        Button.titleEdgeInsets.top = ControlWidth(2)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size:  ControlWidth(14))
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        Button.setImage(UIImage(named: "magic-star")?.imageWithImage(scaledToSize: CGSize(width: ControlWidth(18), height: ControlWidth(18))), for: .normal)
        return Button
    }()

    
    
    lazy var FavoritesButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.backgroundColor = .clear
        Button.layer.shadowOpacity = 0.6
        Button.layer.shadowOffset = .zero
        Button.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionFavorites), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionFavorites() {
        Delegate?.EventActionFavorites(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlWidth(-150)).isActive = true
        
        addSubview(StackLabel)
        StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        StackLabel.heightAnchor.constraint(equalToConstant: ControlWidth(130)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlY(-10)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlY(-10)).isActive = true
        
        addSubview(FavoritesButton)
        FavoritesButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        FavoritesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        FavoritesButton.widthAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        FavoritesButton.heightAnchor.constraint(equalTo: FavoritesButton.widthAnchor).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SimilarPlacesAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

