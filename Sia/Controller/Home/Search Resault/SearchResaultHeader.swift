//
//  SearchResaultHeader.swift
//  Sia
//
//  Created by Emojiios on 16/02/2023.
//

import UIKit

class SearchResaultHeader: UICollectionReusableView {
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(18))
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(Label)
        Label.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
