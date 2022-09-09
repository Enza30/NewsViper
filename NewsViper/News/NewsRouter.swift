//
//  NewsRouter.swift
//  NewsViper
//
//  Created by Farendza Muda on 08/09/22.
//

import Foundation
import UIKit


protocol NewsRouterProtocol {
    var view: UIViewController? {get set}
    func createWebView(news: News?)
}

class NewsRouter: NewsRouterProtocol {
    weak var view: UIViewController?
    
    func createWebView(news: News?) {
        let webView = WebPageViewAssembly.assemble(news: news)
        view?.navigationController?.pushViewController(webView, animated: true)
    }
}
