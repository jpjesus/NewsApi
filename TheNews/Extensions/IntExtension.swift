//
//  BoolExtension.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation

extension Int {
    
    static func isRowNumberModule(of number: Int, numberDivide: Int) -> Bool {
        if number == 0 {
            return true
        }
        return number % numberDivide == 0
    }
}
