//
//  SourcesTableViewCell.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit
import SnapKit

struct SourcesCellViewModel{
    let sources: Sources?
}

struct CategoriesCellViewModel {
    let category: String?
}

extension SourcesTableViewCell {
    struct Appearance {
        let sourceNameFont: UIFont = .boldSystemFont(ofSize: 16)
        let sourceNameColor: UIColor = .black
    }
}

class SourcesTableViewCell: UITableViewCell {
    
    var viewModel: SourcesCellViewModel?{
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            sourceNameLabel.text = viewModel.sources?.name
        }
    }
    
    var categoryViewModel: CategoriesCellViewModel? {
        didSet{
            guard let viewModel = categoryViewModel else {
                return
            }
            sourceNameLabel.text = viewModel.category
        }
    }
    
    private let appearance = Appearance()
    
    private lazy var sourceNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.appearance.sourceNameFont
        label.numberOfLines = 0
        label.textColor = self.appearance.sourceNameColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubviews()
        self.backgroundColor = .clear
        makeConstraints()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(sourceNameLabel)
    }
    
    private func makeConstraints(){
        sourceNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(16)
        }
    }
    
}
