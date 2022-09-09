//
//  NewsViewController.swift
//  NewsViper
//
//  Created by Farendza Muda on 08/09/22.
//

import Foundation
import UIKit

class NewsViewController: BaseViewController {
    
    var presenter: NewsPresenterProtocol?
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionVIew.keyboardDismissMode = .interactive
        collectionVIew.backgroundColor = .clear
        return collectionVIew
    }()
    
    private lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(userPulledView), for: .valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        return refreshControl
    }()
    
    @objc private func userPulledView() {
        self.presenter?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        presenter?.viewDidLoad()
    }
    
    override func setUpUI() {
        super.setUpUI()
        addSubViews()
        makeConstraints()
        
        self.presenter?.collectionManager?.setUpCollectionView(collectionView: self.collectionView)
    }
    
    override func addSubViews() {
        super.addSubViews()
        self.view.addSubview(collectionView)
        collectionView.refreshControl = refreshController
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.bottom.equalToSuperview().inset(15.0)
        }
    }
    
}

extension NewsViewController: NewsViewInput {
    func hideRefreshIndicator() {
        self.refreshController.endRefreshing()
    }
}
