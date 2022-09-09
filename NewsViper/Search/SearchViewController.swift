//
//  SearchViewController.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit
import SnapKit


protocol SearchViewInput: class{
    func presentAlert(title: String, message: String, action: ActionAlertModel?)
    func showActivityIndicator()
    func hideActivityIndicator()
}

extension SearchViewController {
    struct Appearance {
        let searchBarConstraint: CGFloat = 16.0
    }
}

class SearchViewController: BaseViewController {
    
    var presenter: SearchPresenterProtocol?
    var appearance = Appearance()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.keyboardDismissMode = .interactive
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)]
        
        navigationItem.searchController = searchController
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func setUpUI() {
        super.setUpUI()
        self.addKeyBoardObserver()
        addSubViews()
        makeConstraints()
        self.presenter?.collectionManager?.setUpCollectionView(collectionView: self.collectionView)
        self.presenter?.searchControllerManager?.setUpSearchController(searchController: self.searchController)
    }
    
    override func addSubViews() {
        super.addSubViews()
        self.view.addSubview(collectionView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).inset(15)
            make.leading.trailing.bottom.equalToSuperview().inset(15.0)
        }
    }
}

extension SearchViewController: SearchViewInput{
    
}

extension SearchViewController{
    
}
