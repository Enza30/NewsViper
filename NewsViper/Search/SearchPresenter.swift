//
//  SearchPresenter.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

protocol SearchPresenterProtocol: class {
    func searchForNews(by name: String)
    var collectionManager: SearchCollectionViewManagerProtocol? { get set}
    var searchControllerManager: searchControllerManagerProtocol? {get set}
}

protocol SearchPresenterInput: class {
    func apiFetchSuccess(news: [News])
    func handleError(error: Error)
}

protocol SearchCollectionViewManagerDelegate: class {
    func cellClicked(news: News?)
}

protocol SearchBarManagerDelegate: class {
    func searchClicked(name: String)
}

class SearchPresenter {
    weak var view: SearchViewInput?
    var interactor: SearchInteractorInput?
    var router: SearchRouter?
    var collectionManager: SearchCollectionViewManagerProtocol?
    var searchControllerManager: searchControllerManagerProtocol?
    var searchBarDelegate: SearchBarManagerDelegate?
}

extension SearchPresenter: SearchPresenterProtocol {
    func searchForNews(by name: String) {
        view?.showActivityIndicator()
        interactor?.fetchSearchedNews(filter: name)
    }
}

extension SearchPresenter: SearchPresenterInput {
    func apiFetchSuccess(news: [News]) {
        view?.hideActivityIndicator()
        self.collectionManager?.setUpCells(news: news)
    }
    
    func handleError(error: Error) {
        view?.hideActivityIndicator()
        self.view?.presentAlert(title: "error", message: error.localizedDescription, action: ActionAlertModel(actionText: "OK", actionHandler: {}))
    }
}

extension SearchPresenter: SearchCollectionViewManagerDelegate {
    func cellClicked(news: News?) {
        router?.createWebView(news: news)
    }
}

extension SearchPresenter: SearchBarManagerDelegate {
    func searchClicked(name: String) {
        interactor?.fetchSearchedNews(filter: name)
    }
}
