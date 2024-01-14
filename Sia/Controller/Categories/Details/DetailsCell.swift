//
//  DetailsCell.swift
//  Sia
//
//  Created by Emojiios on 24/10/2022.
//

import UIKit

class DetailsCell: UICollectionViewCell {
    
    lazy var DetailsLabel : UILabel = {
      let Label = UILabel()
       Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       Label.numberOfLines = 2
       Label.textAlignment = .center
       Label.backgroundColor = .clear
       Label.translatesAutoresizingMaskIntoConstraints = false
       Label.font = UIFont(name: "Nexa-XBold", size: ControlWidth(17))
   return Label
   }()

   lazy var ImageView : ImageViewGradient = {
       let ImageView = ImageViewGradient()
       ImageView.backgroundColor = .clear
       ImageView.contentMode = .scaleAspectFill
       ImageView.translatesAutoresizingMaskIntoConstraints = false
       ImageView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02018633992).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2011447828).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3955077087).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6033888836).cgColor]
   return ImageView
   }()
    

    override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    ImageView.clipsToBounds = true
    ImageView.layer.cornerRadius = ControlWidth(16)
       
    addSubview(ImageView)
    ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    addSubview(DetailsLabel)
    DetailsLabel.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
    DetailsLabel.bottomAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlX(-10)).isActive = true
    DetailsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(10)).isActive = true
    DetailsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
}


