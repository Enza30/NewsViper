//
//  CategoriesPresenter.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

protocol CategoriesPresenterProtocol: class {
    var tableViewManager: CategoriesTableViewManagerProtocol? { get set }
}

protocol CategoriesPresenterInput: class {
    
}
protocol CategoriesTableViewManagerDelegate: class {
    func sourceSelected(at row: Int)
}

class CategoriesPresenter {
    weak var view: CategoriesViewInput?
    var tableViewManager: CategoriesTableViewManagerProtocol?
    var interactor: CategoriesInteractorInput?
    var router: CategoriesRouterProtocol?
}

extension CategoriesPresenter: CategoriesPresenterProtocol {
    
}
extension CategoriesPresenter: CategoriesTableViewManagerDelegate{
    func sourceSelected(at row: Int) {
        let category: String = Categories.categories[row].rawValue
        let chosenCategory = category.replacingOccurrences(of: " ", with: "-")
        self.router?.createNewsCategory(categoryName: chosenCategory)
    }
}

extension CategoriesPresenter: CategoriesPresenterInput {
    
}
