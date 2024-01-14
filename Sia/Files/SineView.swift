//
//  SineView.swift
//  Sia
//
//  Created by Emojiios on 24/10/2022.
//

import UIKit

class SineView: UIImageView {
    
    let graphWidth: CGFloat = 1
    let amplitude: CGFloat = 0.025

    let gradientLayer = CAGradientLayer()
    var colors : [CGColor] = [] {
        didSet {
        gradientLayer.colors = colors
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = CGRect(x: 0, y: (self.frame.height / 2), width: self.frame.width, height: self.frame.height / 2)
        
        let width = self.frame.width
        let height = self.frame.height

        let origin = CGPoint(x: 0, y: height - ControlWidth(20))

        let path = UIBezierPath()
        path.move(to: origin)

        var endY: CGFloat = 0.0
        let step = 1.0
        for angle in stride(from: step, through: Double(width) * (step * step), by: step) {
            let x = origin.x + CGFloat(angle/360.0) * width * graphWidth
            let y = origin.y - CGFloat(-sin(angle/180.0 * Double.pi)) * height * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
            endY = y
        }
        path.addLine(to: CGPoint(x: width, y: endY))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: origin.y))

        UIColor.white.setFill()
        path.fill()
        UIColor.white.setStroke()
        path.stroke()
        
        let Layer = CAShapeLayer()
        Layer.path = path.cgPath
        Layer.fillColor = UIColor.white.cgColor

        self.layer.insertSublayer(Layer, at: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }

}
