//
//  NewsCollectionViewCell.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

struct HeadlinesCellViewModel {
    let news: News?
    let titleHeight: CGFloat
    let descriptionHeight: CGFloat
}

extension NewsCollectionViewCell {
    struct Appearance {
        let imageHeight: CGFloat = 250.0
        let seperatorHeight: CGFloat = 1.0
        let titleFont: UIFont = UIFont.boldSystemFont(ofSize: 28)
        let descriptionFont: UIFont = UIFont.systemFont(ofSize: 14)
    }
}

class NewsCollectionViewCell: UICollectionViewCell {
    
    var viewModel: HeadlinesCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel.text = viewModel.news?.title
            descriptionLabel.text = viewModel.news?.description
            
            if let imageURL = viewModel.news?.urlToImage {
                if imageURL == "null" {
                    imageView.image = UIImage.tabBarItems.source
                } else {
                    setCellImage(imageUrl: imageURL)
                }
            } else {
                imageView.image = UIImage.tabBarItems.source
            }

        }
    }
    
    private let appearance = Appearance()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.appearance.titleFont
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.appearance.descriptionFont
        label.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var seperator: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.snp.makeConstraints { (make) in
            make.height.equalTo(self.appearance.seperatorHeight)
        }
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, imageView, seperator])
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(contentStackView)
    }
    
    private func makeConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCellImage(imageUrl: String?) {
        guard let imageUrl = imageUrl else {
            return
        }
        if let imageUrl = URL (string: imageUrl) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: imageUrl,
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
                    .cacheOriginalImage
                ])
        }
    }
}
