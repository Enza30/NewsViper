//
//  NewsAssembly.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

class NewsAssembly {
    static func assemble(endpoint: NewsEndPoint) -> UIViewController {
        let view = NewsViewController()
        let collectionManager = NewsCollectionViewManager()
        let presenter = NewsPresenter()
        let interactor = NewsInteractor()
        let router = NewsRouter()
        
        view.presenter = presenter
        
        collectionManager.delegate = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.collectionManager = collectionManager
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.apiManager = ServiceLocator.shared.getService()
        interactor.endpoint = endpoint
        
        router.view = view
        
        return view
    }
}
