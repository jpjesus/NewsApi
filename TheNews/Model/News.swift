//
//  New.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation

final class News: Decodable {
    
    var articles: [Article] = []
    
    enum CodingKeys: String, CodingKey {
        case articles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //totalResults = try container.decode(Int.self, forKey: .totalResults)
        articles = try container.decodeIfPresent([Article].self, forKey: .articles) ?? []
    }
    
    init() {}
}


