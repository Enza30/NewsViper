//
//  SearchAssembly.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

class SearchAssembly {
    static func assemble() -> UIViewController {
        
        let view = SearchViewController()
        let collectionManager = SearchCollectionViewManager()
        let searchControllerManager = SearchControllerManager()
        let preseneter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        
        view.presenter = preseneter
        
        collectionManager.delegate = preseneter
        searchControllerManager.delegate = preseneter
        
        preseneter.view = view
        preseneter.interactor = interactor
        preseneter.router = router
        preseneter.collectionManager = collectionManager
        preseneter.searchControllerManager = searchControllerManager
        
        interactor.presenter = preseneter
        interactor.apiManager = ServiceLocator.shared.getService()
        
        router.view = view
        
        return view
    }
    
}
