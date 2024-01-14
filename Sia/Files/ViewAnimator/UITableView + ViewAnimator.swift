//
//  UITableView + ViewAnimator.swift
//  ViewAnimator
//
//  Created by Marcos Griselli on 15/04/2018.
//

import Foundation
import UIKit

class TableViewAnimations : UITableView {

    //    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
    //    let zoomAnimation = AnimationType.zoom(scale: 0.2)
    //    let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    
    /// Gets the currently visibleCells of a section.
    ///
    /// - Parameter section: The section to filter the cells.
    /// - Returns: Array of visible UITableViewCell in the argument section.
    func visibleCells(in section: Int) -> [UITableViewCell] {
        return visibleCells.filter { indexPath(for: $0)?.section == section }
    }
    
    func SetAnimations(_ selector: @escaping () -> Void = {}) {
        self.reloadData()
        UIView.animate(views: self.visibleCells,
        animations: AnimationsView, options: [.curveEaseInOut],
                       completion: {
        selector()
        })
    }
    
    func RemoveAnimations(_ selector: @escaping () -> Void = {}) {
    UIView.animate(views: self.visibleCells,
                        animations: AnimationsView, reversed: true,
                        initialAlpha: 1.0,
                        finalAlpha: 0.0,
                        options: [.curveEaseIn],
                        completion: {
        selector()
    })
    }

}
