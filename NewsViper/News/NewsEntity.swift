//
//  NewsEntity.swift
//  NewsViper
//
//  Created by Farendza Muda on 08/09/22.
//

import Foundation

struct NewsModel: Codable {
    let news: [News]
}

struct News: Codable {
    let source: Source
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}

struct Source: Codable {
    let name: String?
}
