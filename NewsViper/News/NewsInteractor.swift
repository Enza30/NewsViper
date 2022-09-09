//
//  NewsInteractor.swift
//  NewsViper
//
//  Created by Farendza Muda on 08/09/22.
//

import Foundation

protocol NewsInteractorInput: class {
    func fetchTrendingNews()
}

class NewsInteractor: NewsInteractorInput {
    weak var presenter: NewsPresenterInput?
    var apiManager: NetworkService<NewsEndPoint>?
    var endpoint: NewsEndPoint?
    
    func fetchTrendingNews() {
        guard let endpoint = endpoint else {
            return
        }
        apiManager?.networkRequest(from: endpoint, modelType: NewsModel.self, completion: { [weak self] (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let newsModel):
                    self?.presenter?.apiFetchSuccess(news: newsModel.news)
                case .failure(let error):
                    self?.presenter?.handleError(error: error)
                }
            }
        })

    }
}
