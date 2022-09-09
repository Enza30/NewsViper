//
//  WebPagePresenter.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

protocol WebPagePresenterProtocol: class {
    func viewDidLoad()
    
}

protocol WebPagePresenterInput: class {
    func changeFavouriteState(state: Bool)
    
}

class WebPagePresenter {
    weak var view: WebPageViewInput?
    var urlString: String?
    var news: News?
    var interactor: WebPageInteractorProtocol?
}

extension WebPagePresenter: WebPagePresenterProtocol {
    func viewDidLoad() {
        guard let urlString = self.urlString else { return }
        self.view?.showWebPage(url: urlString)
    }
    
}

extension WebPagePresenter: WebPagePresenterInput {
    func changeFavouriteState(state: Bool) {
        view?.changeFavouriteState(state: state)
    }
}
