//
//  ImageViewGradient.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit

class ImageViewGradient: UIImageView {
    
    let gradientLayer = CAGradientLayer()
    var colors : [CGColor] = [] {
        didSet {
        gradientLayer.colors = colors
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: self.frame.height / 2, width: self.frame.width, height: self.frame.height / 2)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
