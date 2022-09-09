//
//  SearchCollectionViewManager.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

extension SearchCollectionViewManager {
    struct Appearance {
        let imageHeight: CGFloat = 200.0
        let collectionViewInsets: CGFloat = 0.0
        let sourceFont: UIFont = .boldSystemFont(ofSize: 28)
        let titleFont: UIFont = .boldSystemFont(ofSize: 16)
    }
}

protocol SearchCollectionViewManagerProtocol {
    func setUpCollectionView(collectionView: UICollectionView)
    func setUpCells(news: [News])
}

class SearchCollectionViewManager: NSObject {
    
    weak var delegate: SearchCollectionViewManagerDelegate?
    weak var collectionView: UICollectionView?
    
    let appearance = Appearance()
    var news: [News]?
    
    private func getCellSize(at row: Int) -> CGSize {
        guard let collectionView = collectionView else {
            return CGSize.zero
        }
        return CGSize(width: collectionView.frame.size.width, height: self.appearance.imageHeight)
    }
    
    private func getTitleHeight(at row: Int) -> CGFloat {
        guard
            let title = news?[row].title,
            let collectionView = collectionView else {return CGFloat.zero}
        
        let maxMessageSize = CGSize(width: collectionView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let titleSize = NSString(string: title)
            .boundingRect(with: maxMessageSize, options: options, attributes: [NSAttributedString.Key.font : self.appearance.titleFont], context: nil)
        
        return titleSize.height
    }
    
    private func getSourceHeight(at row: Int) -> CGFloat {
        guard
            let source = news?[row].source.name,
            let collectionView = collectionView else { return CGFloat.zero}
        
        let maxMessageSize = CGSize(width: collectionView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let sourceSize = NSString(string: source)
            .boundingRect(with: maxMessageSize, options: options, attributes: [NSAttributedString.Key.font : self.appearance.sourceFont], context: nil)
        
        return sourceSize.height
    }
}

extension SearchCollectionViewManager: SearchCollectionViewManagerProtocol{
    func setUpCollectionView(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        self.collectionView?.contentInset = UIEdgeInsets(top: appearance.collectionViewInsets, left: appearance.collectionViewInsets, bottom: appearance.collectionViewInsets, right: appearance.collectionViewInsets)
    }
    
    func setUpCells(news: [News]) {
        self.news = news
        collectionView?.reloadData()
    }
}

extension SearchCollectionViewManager: UICollectionViewDelegate{}

extension SearchCollectionViewManager: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell()}
        let cellViewModel = SearchCellViewModel(news: news?[indexPath.row], sourceHeight: getSourceHeight(at: indexPath.row), titleHeight: getTitleHeight(at: indexPath.row))
        cell.viewModel = cellViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellClicked(news: news?[indexPath.row])
    }
}

extension SearchCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.getCellSize(at: indexPath.row)
    }
}
