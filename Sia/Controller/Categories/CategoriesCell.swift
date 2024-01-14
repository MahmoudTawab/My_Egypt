//
//  CategoriesCell.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    lazy var CategoriesLabel : UILabel = {
      let Label = UILabel()
       Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       Label.numberOfLines = 3
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
       ImageView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02018633992).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2011447828).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3955077087).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6033888836).cgColor]
       ImageView.translatesAutoresizingMaskIntoConstraints = false
   return ImageView
   }()
    
    var TopBackground:NSLayoutConstraint?
    var BottomBackground:NSLayoutConstraint?
    var BackgroundHeight1:NSLayoutConstraint?
    var BackgroundHeight2:NSLayoutConstraint?

   override init(frame: CGRect) {
   super.init(frame: frame)
    backgroundColor = .clear
    ImageView.clipsToBounds = true
    ImageView.layer.cornerRadius = ControlWidth(16)
       
    addSubview(ImageView)
    ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    TopBackground = ImageView.topAnchor.constraint(equalTo: self.topAnchor)
    TopBackground?.isActive = true

    BottomBackground = ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    BottomBackground?.isActive = false
       
    BackgroundHeight1 = ImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
    BackgroundHeight1?.isActive = true

    BackgroundHeight2 = ImageView.heightAnchor.constraint(equalTo: self.heightAnchor , constant: ControlX(-20))
    BackgroundHeight2?.isActive = false
       
    addSubview(CategoriesLabel)
    CategoriesLabel.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
    CategoriesLabel.bottomAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlX(-10)).isActive = true
    CategoriesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(10)).isActive = true
    CategoriesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
       
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
}


