//
//  ArticleService.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 11/06/2022.
//

import Foundation
import Moya

enum ArticleService {
    case getMostViewed(period: PeriodEnum)
}

extension ArticleService: TargetType {
    
    
    var baseURL: URL {
        return Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .getMostViewed(let period):
            return "/svc/mostpopular/v2/viewed/\(period.rawValue).json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMostViewed: return .get
        }
    }
    
    var sampleData: Data {
        return loadLocalJsonFile()
    }

    var task: Task {
        switch self {
        case .getMostViewed:
            let params = ["api-key": Environment.apiKey]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}


extension ArticleService {
    
    func loadLocalJsonFile() -> Data {
        guard let url = Bundle.main.url(forResource: "LocalArticles", withExtension: "json") else {
            fatalError()
        }
        return try! Data(contentsOf: url)
    }
}
