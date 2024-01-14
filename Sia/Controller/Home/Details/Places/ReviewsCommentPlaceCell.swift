//
//  ReviewsCommentPlaceCell.swift
//  Sia
//
//  Created by Emojiios on 15/03/2023.
//

import UIKit

class ReviewsCommentPlaceCell: UITableViewCell  {
        
    lazy var UserImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Profile")
        ImageView.layer.cornerRadius = ControlWidth(15)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        return ImageView
    }()

    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        return Label
    }()
    
    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LabelName,LabelDate])
    Stack.axis = .vertical
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.distribution = .equalSpacing
    return Stack
    }()
    
    lazy var ViewRating : CosmosView = {
        let view = CosmosView()
        view.settings.fillMode = .full
        view.settings.textColor = .clear
        view.settings.textMargin = 10
        view.settings.updateOnTouch = false
        view.settings.starSize = ControlWidth(15)
        view.settings.emptyImage = UIImage(named: "Emptystar")
        view.settings.filledImage = UIImage(named: "magic-star")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        return view
    }()
    
    
    lazy var TopStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [UserImage,StackLabel,ViewRating])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Stack
    }()

    lazy var Comment : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(15))
        return Label
    }()
    
    lazy var StackView : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopStack,Comment])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.isHidden = true
                
        addSubview(StackView)
        StackView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(10)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-15)).isActive = true
        StackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        StackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






