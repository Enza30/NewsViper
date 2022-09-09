//
//  SearchRouter.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

protocol SearchRouterProtocol {
    var view: UIViewController? { get set }
    func createWebView(news: News?)
}

class SearchRouter: SearchRouterProtocol {
    weak var view: UIViewController?
    
    func createWebView(news: News?) {
        let webView = WebPageViewAssembly.assemble(news: news)
        view?.navigationController?.pushViewController(webView, animated: true)
    }
}
