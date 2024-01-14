//
//  HomeCategories.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit

protocol HomeCategoriesDelegate {
    func HomeCategoriesAction(_ Cell:HomeCategories)
}

class HomeCategories : UICollectionViewCell {
    
    var Delegate : HomeCategoriesDelegate?    
    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TripPurposeAction)))
        return ImageView
    }()

    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.textAlignment = .center
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Bold" ,size: ControlWidth(12))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TripPurposeAction)))
        return Label
    }()
    
    @objc func TripPurposeAction() {
        Delegate?.HomeCategoriesAction(self)
    }
    
    lazy var StackView : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Image,Label])
        Stack.axis = .vertical
        Stack.alignment = .center
        Stack.backgroundColor = .clear
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(StackView)
        StackView.leadingAnchor.constraint(equalTo:  self.leadingAnchor).isActive = true
        StackView.trailingAnchor.constraint(equalTo:  self.trailingAnchor).isActive = true
        StackView.topAnchor.constraint(equalTo:  self.topAnchor,constant: ControlWidth(14)).isActive = true
        StackView.bottomAnchor.constraint(equalTo:  self.bottomAnchor,constant: ControlWidth(-14)).isActive = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TripPurposeAction)))
        
        StackView.arrangedSubviews[0].widthAnchor.constraint(equalTo: self.widthAnchor,constant: ControlWidth(-30)).isActive = true
        StackView.arrangedSubviews[0].heightAnchor.constraint(equalTo: StackView.arrangedSubviews[0].widthAnchor).isActive = true
        Image.layer.cornerRadius = (frame.width - ControlWidth(30)) / 2

    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
