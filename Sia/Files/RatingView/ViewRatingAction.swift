//
//  ViewRatingAction.swift
//  Cargood
//
//  Created by Mahmoud Abd El Tawab on 11/23/19.
//  Copyright © 2019 Mahmoud Abd El Tawab. All rights reserved.
//

import UIKit

class ViewRatingAction: UIView  {
    
    @IBInspectable var FaveButtonFrame:CGFloat = ControlWidth(45) {
      didSet {
          
      }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)

        AllRatingButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func AllRatingButton() {
                
    let StackVertical = UIStackView(arrangedSubviews: [Button1,Button2,Button3,Button4,Button5])
    StackVertical.axis = .horizontal
    StackVertical.spacing = ControlX(20)
    StackVertical.distribution = .fillEqually
    StackVertical.alignment = .center
    StackVertical.backgroundColor = .clear
    StackVertical.translatesAutoresizingMaskIntoConstraints = false
        
    addSubview(StackVertical)
    StackVertical.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    StackVertical.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    StackVertical.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    StackVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    Button1.setSelected(selected: true, animated: false)
    }
    
    lazy var Button1 : FaveButton = {
        let Button = FaveButton(frame: CGRect(x: 0, y: 0, width: FaveButtonFrame, height: FaveButtonFrame), faveIconNormal: UIImage(named: "Emptystar"))
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionButton1), for: .touchUpInside)
        return Button
    }()
    
    
    lazy var Button2 : FaveButton = {
        let Button = FaveButton(frame: CGRect(x: 0, y: 0, width: FaveButtonFrame, height: FaveButtonFrame), faveIconNormal: UIImage(named: "Emptystar"))
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionButton2), for: .touchUpInside)
        return Button
    }()
    
    lazy var Button3 : FaveButton = {
        let Button = FaveButton(frame: CGRect(x: 0, y: 0, width: FaveButtonFrame, height: FaveButtonFrame), faveIconNormal: UIImage(named: "Emptystar"))
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionButton3), for: .touchUpInside)
        return Button
    }()
    
    lazy var Button4 : FaveButton = {
        let Button = FaveButton(frame: CGRect(x: 0, y: 0, width: FaveButtonFrame, height: FaveButtonFrame), faveIconNormal: UIImage(named: "Emptystar"))
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionButton4), for: .touchUpInside)
        return Button
    }()
    
    lazy var Button5 : FaveButton = {
        let Button = FaveButton(frame: CGRect(x: 0, y: 0, width: FaveButtonFrame, height: FaveButtonFrame), faveIconNormal: UIImage(named: "Emptystar"))
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionButton5), for: .touchUpInside)
        return Button
    }()
    
    var rating = 0
    func RatingReading(Rating:Int ,animated:Bool ) {
        switch Rating {
        case 1:
            Button1.setSelected(selected: true, animated: animated)
            Button2.setSelected(selected: false, animated: animated)
            Button3.setSelected(selected: false, animated: animated)
            Button4.setSelected(selected: false, animated: animated)
            Button5.setSelected(selected: false, animated: animated)
            
            rating = 1
        case 2:
            Button1.setSelected(selected: true, animated: animated)
            Button2.setSelected(selected: true, animated: animated)
            Button3.setSelected(selected: false, animated: animated)
            Button4.setSelected(selected: false, animated: animated)
            Button5.setSelected(selected: false, animated: animated)
            
            rating = 2
        case 3:
            Button1.setSelected(selected: true, animated: animated)
            Button2.setSelected(selected: true, animated: animated)
            Button3.setSelected(selected: true, animated: animated)
            Button4.setSelected(selected: false, animated: animated)
            Button5.setSelected(selected: false, animated: animated)
            
            rating = 3
        case 4:
            Button1.setSelected(selected: true, animated: animated)
            Button2.setSelected(selected: true, animated: animated)
            Button3.setSelected(selected: true, animated: animated)
            Button4.setSelected(selected: true, animated: animated)
            Button5.setSelected(selected: false, animated: animated)
            
            rating = 4
        case 5:
            Button1.setSelected(selected: true, animated: animated)
            Button2.setSelected(selected: true, animated: animated)
            Button3.setSelected(selected: true, animated: animated)
            Button4.setSelected(selected: true, animated: animated)
            Button5.setSelected(selected: true, animated: animated)
            
            rating = 5
        default:
        break
        }
    }
    
    @objc func ActionButton1() {
        RatingReading(Rating: 1, animated: true)
    }
    
    @objc func ActionButton2() {
        RatingReading(Rating: 2, animated: true)
    }
    
    @objc func ActionButton3() {
        RatingReading(Rating: 3, animated: true)
    }
    
    @objc func ActionButton4() {
        RatingReading(Rating: 4, animated: true)
    }
    
    @objc func ActionButton5() {
        RatingReading(Rating: 5, animated: true)
    }
    
    func RatingEnabled() {
    Button1.isEnabled = false
    Button2.isEnabled = false
    Button3.isEnabled = false
    Button4.isEnabled = false
    Button5.isEnabled = false
    }
    
}
