//
//  ArticleViewController.swift
//  TheNews
//
//  Created by Jesus Parada on 10/14/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var fullNewsView: UIView!
    @IBOutlet weak var newProgressView: UIProgressView! {
        didSet {
            newProgressView.tintColor = .red
        }
    }
    
}
