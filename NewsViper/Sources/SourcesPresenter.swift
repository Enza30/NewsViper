//
//  SourcesPresenter.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

protocol SourcesPresenterProtocol: class {
    func viewDidLoad()
    var tableViewManager: SourcesTableViewManagerProtocol? { get set }
}

//Interactor To Presenter
protocol SourcesPresenterInput: class {
    func apiFetchSuccess(sources: [Sources])
    func handleError(error: Error)
}


//Manager To Presenter
protocol SourcesTableViewManagerDelegate: class {
    func sourceSelected(at row: Int)
}

class SourcesPresenter {
    
    weak var view: SourcesViewInput?
    var interactor: SourcesInteractorInput?
    var router: SourcesRouterProtocol?
    var tableViewManager: SourcesTableViewManagerProtocol?
    var sources: [Sources]?
    
}

//MARK: - SourcesPresenterProtocol
extension SourcesPresenter: SourcesPresenterProtocol {
    func viewDidLoad() {
        view?.showActivityIndicator()
        interactor?.fetchTrendingSources()
    }
}

//MARK: - SourcesPresenterInput
extension SourcesPresenter: SourcesPresenterInput {
    func apiFetchSuccess(sources: [Sources]) {
        view?.hideActivityIndicator()
        self.sources = sources
        self.tableViewManager?.setUpCells(sources: sources)
    }
    
    func handleError(error: Error) {
        view?.hideActivityIndicator()
        self.view?.presentAlert(title: "error", message: error.localizedDescription, action: ActionAlertModel(actionText: "Ok", actionHandler: {}))
    }
    
    
}


//MARK: - SourcesCollectionViewManagerDelegate
extension SourcesPresenter: SourcesTableViewManagerDelegate {
    func sourceSelected(at row: Int) {
        guard let sourceName = sources?[row].name else { return }
        let textToSearch = sourceName.replacingOccurrences(of: " ", with: "-")
        self.router?.createNewsSources(sourceName: textToSearch)
    }
}
