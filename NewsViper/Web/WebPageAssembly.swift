//
//  WebPageAssembly.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

class WebPageViewAssembly {
    public static func assemble(news: News?) -> UIViewController {
        let view = WebPageViewController()
        let presenter = WebPagePresenter()
        let interactor = WebPageInteractor()
        
        view.title = news?.source.name
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.news = news
        presenter.view = view
        presenter.urlString = news?.url
        
        interactor.presenter = presenter
        
        return view
    }
}
