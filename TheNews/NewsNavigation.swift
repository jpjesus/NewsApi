//
//  NewsNavigation.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import Moya

final class NewsNavigation {
    
    let provider = MoyaProvider<NewsAPI>()
    var navigationController: UINavigationController?
    
    init(with window: UIWindow) {
        let viewModel = NewsViewModel(with: provider)
        let vc = NewsViewController(with: viewModel)
        navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
