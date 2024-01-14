//
//  TransportationCell.swift
//  Sia
//
//  Created by Emojiios on 20/10/2022.
//

import UIKit

protocol TransportationDelegate {
    func TransportationAction(_ Cell:TransportationCell)
    func TransportationBarAction(_ Cell:TransportationCell)
}

class TransportationCell : UICollectionViewCell {
    
    var Delegate : TransportationDelegate?
    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TransportationAction)))
        return ImageView
    }()
    
    @objc func TransportationAction() {
        Delegate?.TransportationAction(self)
    }
    
    lazy var TopBarView : ConciergeBarView = {
        let View = ConciergeBarView()
        View.isUserInteractionEnabled = true
        View.translatesAutoresizingMaskIntoConstraints = false
        View.Button.addTarget(self, action: #selector(TransportationBarAction), for: .touchUpInside)
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TransportationBarAction)))
        return View
    }()
    
    @objc func TransportationBarAction() {
        Delegate?.TransportationBarAction(self)
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
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TransportationBarAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


