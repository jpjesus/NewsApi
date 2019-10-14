//
//  UIViewExtension.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setupShadow(radius: CGFloat, opacity: CGFloat, offset: CGFloat, color: UIColor = .black) {
        layer.shadowOffset = CGSize(width: 0, height: offset)
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = Float(opacity)
        layer.masksToBounds = false
    }
    
    func setupRoundedCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraintsToFit(view: self)
    }
    
    func addConstraintsToFit(view: UIView) {
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                 options: NSLayoutConstraint.FormatOptions(),
                                                                 metrics: nil,
                                                                 views: ["view": view])
        addConstraints(verticalConstraints)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                   options: NSLayoutConstraint.FormatOptions(),
                                                                   metrics: nil,
                                                                   views: ["view": view])
        addConstraints(horizontalConstraints)
    }
}
