//
//  HappeningNowCell.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit

protocol HappeningNowDelegate {
    func HappeningNowAction(_ Cell:HappeningNowCell)
}

class HappeningNowCell : UICollectionViewCell {
    
    var Delegate : HappeningNowDelegate?
    lazy var ImageView : ImageViewGradient = {
        let ImageView = ImageViewGradient()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.colors = [#colorLiteral(red: 0.9783384204, green: 0.8178021312, blue: 0.4856868386, alpha: 0.02019640864).cgColor, #colorLiteral(red: 0.9783384204, green: 0.8178021312, blue: 0.4856868386, alpha: 0.3010022429).cgColor, #colorLiteral(red: 0.9783384204, green: 0.8178021312, blue: 0.4856868386, alpha: 0.5).cgColor, #colorLiteral(red: 0.9783384204, green: 0.8178021312, blue: 0.4856868386, alpha: 0.6994528219).cgColor]
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HappeningNowAction)))
        return ImageView
    }()
    
    @objc func HappeningNowAction() {
        Delegate?.HappeningNowAction(self)
    }
    

    lazy var DateLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 0
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(17))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()
    
    lazy var NameLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 0
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DateLabel,TitleLabel,NameLabel])
        Stack.axis = .vertical
        Stack.alignment = .center
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(15)).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlY(-15)).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        
        addSubview(StackLabel)
        StackLabel.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlY(-35)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: ImageView.leadingAnchor,constant: ControlX(32)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: ImageView.trailingAnchor,constant: ControlX(-32)).isActive = true
                
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HappeningNowAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        ImageView.layer.cornerRadius = ImageView.frame.width / 2
    }
}

