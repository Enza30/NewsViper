//
//  CategoriesRouter.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

protocol CategoriesRouterProtocol {
    var view: UIViewController? {get set}
    func createNewsCategory(categoryName: String)
}

class CategoriesRouter: CategoriesRouterProtocol {
    weak var view: UIViewController?
    
    func createNewsCategory(categoryName: String) {
        let newsView = NewsAssembly.assemble(endpoint: .getNewsFromCategory(categoryName.lowercased()))
        newsView.title = categoryName
        view?.navigationController?.pushViewController(newsView, animated: true)
    }
}
