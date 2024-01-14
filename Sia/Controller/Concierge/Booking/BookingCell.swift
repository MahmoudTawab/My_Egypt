//
//  BookingCell.swift
//  Sia
//
//  Created by Emojiios on 20/10/2022.
//

import UIKit

protocol BookingDelegate {
    func BookingAction(_ Cell:BookingCell)
    func BookingBarAction(_ Cell:BookingCell)
}

class BookingCell : UICollectionViewCell {
    
    var Delegate : BookingDelegate?
    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BookingAction)))
        return ImageView
    }()
    
    @objc func BookingAction() {
        Delegate?.BookingAction(self)
    }
    
    lazy var TopBarView : ConciergeBarView = {
        let View = ConciergeBarView()
        View.isUserInteractionEnabled = true
        View.translatesAutoresizingMaskIntoConstraints = false
        View.Button.addTarget(self, action: #selector(ActionTopBar), for: .touchUpInside)
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionTopBar)))
        return View
    }()
    
    @objc func ActionTopBar() {
        Delegate?.BookingBarAction(self)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(TopBarView)
        TopBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        TopBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        TopBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        TopBarView.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BookingAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

