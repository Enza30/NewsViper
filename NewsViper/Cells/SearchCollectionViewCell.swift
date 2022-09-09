//
//  SearchCollectionViewCell.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

struct SearchCellViewModel {
    let news: News?
    let sourceHeight: CGFloat
    let titleHeight: CGFloat
}

extension SearchCollectionViewCell {
    struct Appearance{
        let imageHeight: CGFloat = 200.0
        let sourceFont: UIFont = .boldSystemFont(ofSize: 28)
        let titleFont: UIFont = .boldSystemFont(ofSize: 16)
        let labelConstraints: CGFloat = 16.0
    }
}

class SearchCollectionViewCell: UICollectionViewCell {
    
    var viewModel: SearchCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            sourceLabel.text = viewModel.news?.source.name
            titleLabel.text = viewModel.news?.title
            
            imageView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            setCellImage(imageUrl: viewModel.news?.urlToImage)
        }
    }
    
    private let appearance = Appearance()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = self.appearance.sourceFont
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = self.appearance.titleFont
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8.0
        return image
    }()
    
    private lazy var view: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.clipsToBounds = true
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(imageView)
        self.imageView.addSubview(view)
        view.addSubview(sourceLabel)
        view.addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.trailing.equalTo(-appearance.labelConstraints)
            make.leading.equalTo(appearance.labelConstraints)
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(-appearance.labelConstraints)
            make.bottom.equalTo(titleLabel.snp.top).offset(-4)
            make.leading.equalTo(appearance.labelConstraints)
        }
        
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCellImage(imageUrl: String?) {
        guard let imageUrl = imageUrl else {
            return
        }
        if let imageUrl = URL(string: imageUrl){
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: imageUrl,
                options:[
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
                    .cacheOriginalImage
            ])
        }

    }
}
