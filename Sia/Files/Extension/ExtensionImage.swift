//
//  ExtensionImage.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

extension UIImage {
    
    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)

        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }

        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)

        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }
    
    func imageWithImage(scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysTemplate)
    }
    
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    func toAttributedString(with heightRatio: CGFloat, tint color: UIColor? = nil) -> NSAttributedString {
        let attachment = NSTextAttachment()
        var image = self

        if let tintColor = color {
            image.withRenderingMode(.alwaysTemplate)
            image = image.tint(with: tintColor)
        }

        attachment.image = image

        let ratio: CGFloat = image.size.width / image.size.height
        let attachmentBounds = attachment.bounds

        attachment.bounds = CGRect(x: attachmentBounds.origin.x,
                                   y: attachmentBounds.origin.y - ControlY(5),
                                   width: ratio * heightRatio,
                                   height: heightRatio)

        return NSAttributedString(attachment: attachment)
    }
}

