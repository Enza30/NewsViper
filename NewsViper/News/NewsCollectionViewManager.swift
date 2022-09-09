//
//  NewsCollectionViewManager.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

extension NewsCollectionViewManager {
    struct Appearance {
        let imageHeight: CGFloat = 250.0
        let insets: CGFloat = 10.0
        let titleFont: UIFont = UIFont.boldSystemFont(ofSize: 28)
        let descriptionFont: UIFont = UIFont.systemFont(ofSize: 14)
        let extraSpacing: CGFloat = 19.0
    }
}

protocol NewsCollectionViewManagerProtocol {
    func setUpCollectionView(collectionView: UICollectionView)
    func setupChats(news: [News])
}

class NewsCollectionViewManager: NSObject {
    weak var delegate: NewsCollectionViewManagerDelegate?
    weak var collectionView: UICollectionView?
    
    private var news: [News]?
    private let appearance = Appearance()
    
    private func getCellSize(at row: Int) -> CGSize {
        guard
            let collectionView = collectionView else {
            return CGSize.zero
        }
        let titleHeight = getTitleHeight(at: row)
        let descriptionHeight = getDescriptionHeight(at: row)
        
        return CGSize(width: collectionView.frame.size.width,
                      height: titleHeight + descriptionHeight + self.appearance.imageHeight + self.appearance.extraSpacing)
    }
    
    private func getTitleHeight(at row: Int) -> CGFloat {
        guard
            let title = news?[row].title,
            let collectionView = collectionView else { return CGFloat.zero }
        
        let maxMessageSize = CGSize(width: collectionView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let titleSize = NSString(string: title)
            .boundingRect(with: maxMessageSize, options: options, attributes: [NSAttributedString.Key.font : self.appearance.titleFont], context: nil)
        
        return titleSize.height
    }
    
    private func getDescriptionHeight(at row: Int) -> CGFloat {
        guard
            let description = news?[row].description,
            let collectionView = collectionView else { return CGFloat.zero }
        
        let maxMessageSize = CGSize(width: collectionView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let descriptionSize = NSString(string: description)
            .boundingRect(with: maxMessageSize, options: options, attributes: [NSAttributedString.Key.font: self.appearance.descriptionFont], context: nil)
        return descriptionSize.height
    }
}

extension NewsCollectionViewManager: NewsCollectionViewManagerProtocol {
    func setUpCollectionView(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseIdentifier)
    }
    
    func setupChats(news: [News]) {
        self.news = news
        self.collectionView?.reloadData()
    }
}

extension NewsCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseIdentifier, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = HeadlinesCellViewModel(news: news?[indexPath.row], titleHeight: getTitleHeight(at: indexPath.row), descriptionHeight: getDescriptionHeight(at: indexPath.row))
        cell.viewModel = cellViewModel
        return cell
    }
}

extension NewsCollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellClicked(news: news?[indexPath.row])
    }
}

extension NewsCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.getCellSize(at: indexPath.row)
    }
}
    

