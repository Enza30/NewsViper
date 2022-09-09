//
//  SearchInteractor.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

protocol SearchInteractorInput: class {
    func fetchSearchedNews(filter: String)
}

class SearchInteractor: SearchInteractorInput {
    weak var presenter: SearchPresenterInput?
    var apiManager: NetworkService<NewsEndPoint>?
    
    func fetchSearchedNews(filter: String) {
        apiManager?.networkRequest(from: .searchForNews(searchFilter: filter), modelType: NewsModel.self) { [weak self] (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let searchModel):
                    self?.presenter?.apiFetchSuccess(news: searchModel.news)
                case .failure(let error):
                    self?.presenter?.handleError(error: error)
                }
            }
        }
    }
}
