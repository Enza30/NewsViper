//
//  CategoriesAssembly.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

class CategoriesAssembly{
    static func assemble() -> UIViewController {
        let view = CategoriesViewController()
        let manager = CategoriesTableViewManager()
        let presenter = CategoriesPresenter()
        let interactor = CategoriesInteractor()
        let router = CategoriesRouter()
        
        view.presenter = presenter
        
        manager.delegate = presenter 
    
        presenter.interactor =  interactor
        presenter.router = router
        presenter.view = view
        presenter.tableViewManager = manager
        
        router.view = view
        
        return view
    }
}
