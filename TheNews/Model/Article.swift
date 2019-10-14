//
//  Article.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import RxDataSources

final class Article: Decodable {
    
    var author: String = ""
    var title: String = ""
    var articleDescription: String = ""
    var content: String = ""
    var source: Source = Source()
    var url: URL? {
        return URL(string: urlString)
    }
    var imageUrl: URL? {
        return URL(string: imageUrlString)
    }
    
    typealias Identity = String
    private var urlString: String = ""
    private var imageUrlString: String = ""
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case content
        case source
        case articuleDescription = "description"
        case urlString = "url"
        case imageUrlString = "urlToImage"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
        urlString = try container.decodeIfPresent(String.self, forKey: .urlString) ?? ""
        articleDescription =  try container.decodeIfPresent(String.self, forKey: .articuleDescription) ?? ""
        imageUrlString = try container.decodeIfPresent(String.self, forKey: .imageUrlString) ?? ""
        source = try container.decode(Source.self, forKey: .source)
    }
    
    init() {}
}

struct Source: Decodable {
    
    var id: String? = ""
    var name: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    init() {}
}
