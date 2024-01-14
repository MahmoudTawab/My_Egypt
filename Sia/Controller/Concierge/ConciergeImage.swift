//
//  ConciergeImage.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

class ConciergeImage: UIImageView {
    
    lazy var View : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        return View
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(View)
        View.frame = rect
    }
}

