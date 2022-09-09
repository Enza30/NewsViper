//
//  SourceEntity.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

struct SourcesModel: Codable {
    let sources: [Sources]
}

struct Sources: Codable {
    let name: String?
}
