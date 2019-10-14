//
//  UIColorExtension.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Colors
extension UIColor {
    
    class func charcoal() -> UIColor {
        return UIColor(red: 67 / 255.0, green: 72 / 255.0, blue: 77 / 255.0, alpha: 1.0)
    }
    
    class func cleanGray() -> UIColor {
       return UIColor(red: 242 / 255.0, green: 244 / 255.0, blue: 246 / 255.0, alpha: 1.0)
    }
    
    class func purpleBrown(_ alpha: CGFloat = 0.6) -> UIColor {
        return UIColor(red: 35.0 / 255.0, green: 31.0 / 255.0, blue: 32.0 / 255.0, alpha: alpha)
    }
    
    class func cloudy() -> UIColor {
        return UIColor(red: 205 / 255.0, green: 209 / 255.0, blue: 221 / 255.0, alpha: 1.0)
    }
}

// MARK: - Fonts
extension UIFont {
    
    class func basicFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir", size: size)!
    }
    
}
