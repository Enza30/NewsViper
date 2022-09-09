//
//  SourcesRouter.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

protocol SourcesRouterProtocol {
    var view: UIViewController? { get set }
    
    func createNewsSources(sourceName: String)
}

class SourcesRouter: SourcesRouterProtocol {
    weak var view: UIViewController?
    func createNewsSources(sourceName: String) {
        let newsView = NewsAssembly.assemble(endpoint: .getNewsFromSource(sourceName))
        newsView.title = sourceName
        view?.navigationController?.pushViewController(newsView, animated: true)
    }
}
