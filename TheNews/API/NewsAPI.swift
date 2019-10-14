//
//  NewsAPI.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import Moya

let apiKey = "14cba831bc14481abaa77fd8960e0a7b"
let baseUrl = "https://newsapi.org/"

enum NewsAPI {
    case getTopHeadlines(page: Int, pageSize: Int)
}

extension NewsAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: baseUrl) else {
            fatalError("base url not configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getTopHeadlines(_,_):
            return "v2/top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTopHeadlines(_,_):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getTopHeadlines(_,_):
            guard let url = Bundle.main.url(forResource: "NewsAPI", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case .getTopHeadlines(let page,let pageSize):
            var params: [String: Any] = [:]
            params ["page"] = page
            params ["pageSize"] = pageSize
            params ["apiKey"] = apiKey
            params ["country"] = "us"
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
