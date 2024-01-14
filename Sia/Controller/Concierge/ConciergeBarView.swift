//
//  ConciergeBarView.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

class ConciergeBarView: UIView {
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()
    
    lazy var Button : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "Group 57450"), for: .normal)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        return Button
    }()
    
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Label,Button])
        Stack.axis = .horizontal
        Stack.alignment = .center
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6999338371)
        addSubview(Stack)
        
        Stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        Stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        Stack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        Stack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
