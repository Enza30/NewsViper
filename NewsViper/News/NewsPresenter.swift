//
//  NewsPresenter.swift
//  NewsViper
//
//  Created by Farendza Muda on 08/09/22.
//

import Foundation


protocol NewsPresenterProtocol: class {
    func viewDidLoad()
    var collectionManager: NewsCollectionViewManagerProtocol? {get set}
}

protocol NewsPresenterInput: class {
    func apiFetchSuccess(news: [News])
    func handleError(error: Error)
}

protocol NewsCollectionViewManagerDelegate: class {
    func cellClicked(news: News?)
}

class NewsPresenter {
    weak var view: NewsViewInput?
    var interactor: NewsInteractorInput?
    var router: NewsRouterProtocol?
    var collectionManager: NewsCollectionViewManagerProtocol?
}

extension NewsPresenter: NewsPresenterProtocol{
    func viewDidLoad() {
        view?.showActivityIndicator()
        interactor?.fetchTrendingNews()
    }
}

extension NewsPresenter: NewsPresenterInput {
    func apiFetchSuccess(news: [News]) {
        view?.hideActivityIndicator()
        view?.hideRefreshIndicator()
        self.collectionManager?.setupChats(news: news)
    }
    
    func handleError(error: Error) {
        view?.hideActivityIndicator()
        self.view?.presentAlert(title: "error", message: error.localizedDescription, action: ActionAlertModel(actionText: "OK", actionHandler: {}))
    }
}

extension NewsPresenter: NewsCollectionViewManagerDelegate {
    func cellClicked(news: News?) {
        router?.createWebView(news: news)
    }
}
