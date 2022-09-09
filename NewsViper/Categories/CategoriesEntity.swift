//
//  CategoriesEntity.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import SwiftUI

struct Categories {
    static let categories: [categories] = [.business, .entertainment, .general, .health, .science, .sports, .technology]
}

enum categories: String {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
}
