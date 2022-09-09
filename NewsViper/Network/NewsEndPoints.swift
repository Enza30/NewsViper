//
//  NewsEndPoints.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

protocol EndPointProtocol {
    var locale: String { get }
    var region: String { get }
    var completeURL: String { get }
    var APIKey: String { get }
}

extension EndPointProtocol {
    var locale: String {
        return Locale.current.languageCode ?? "en"
    }
    
    var region: String {
        return Locale.current.regionCode ?? "us"
    }
    
    var APIKey: String {
        return Secrets.APIKey
    }
}

enum NewsEndPoint: EndPointProtocol {
    case getTopHeadlines
    case getNewsFromCategory(_ category: String)
    case getSources
    case getNewsFromSource(_ source: String)
    case searchForNews(searchFilter: String)
    
    private var baseURL: String {
        return "https://newsapi.org/v2"
    }
    
    private var absoluteURL: String {
        switch self {
        case .getTopHeadlines, .getNewsFromCategory:
            return baseURL + "/top-headlines?"
        case .getSources:
            return baseURL + "/sources?"
        case .getNewsFromSource, .searchForNews:
            return baseURL + "/everything?"
        }
    }
    
    var completeURL: String {
        switch self {
        case .getTopHeadlines:
            return self.absoluteURL + "Country=" + self.region + "&ApiKey=" + self.APIKey
        case let .getNewsFromCategory(category):
            return self.absoluteURL + "Country=" + self.region + "&Category=" + category + "&ApiKey=" + self.APIKey
        case .getSources:
            return self.absoluteURL + "language=" + self.locale + "&Country=" + "US" + "&ApiKey=" + self.APIKey
        case let .getNewsFromSource(source):
            return self.absoluteURL + "sources=" + source + "&language=" + self.locale + "&ApiKey=" + self.APIKey
        case let .searchForNews(searchFilter: filter):
            print(self.absoluteURL + "q=" + filter + "&language=" + self.locale + "&ApiKey=" + self.APIKey)
            return self.absoluteURL + "q=" + filter + "&language=" + self.locale + "&ApiKey=" + self.APIKey
        }
    }
    
}
