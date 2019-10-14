//
//  ArticleSectionModel.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import RxDataSources

struct ArticleSectionModel {
    var header: String
    var items: [Article]
}

extension ArticleSectionModel: SectionModelType {
    
    init(original: ArticleSectionModel, items: [Article]) {
        self = original
        self.items = items
    }
}
