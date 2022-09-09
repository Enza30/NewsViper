//
//  CategoriesViewController.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit
import SnapKit


protocol CategoriesViewInput: class {
    func presentAlert(title: String, message: String, action: ActionAlertModel?)
}

class CategoriesViewController: BaseViewController {
    var presenter: CategoriesPresenterProtocol?
    
    private lazy var categoriesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .none
        tableView.keyboardDismissMode = .interactive
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUI() {
        super.setUpUI()
        self.addSubViews()
        self.makeConstraints()
        self.presenter?.tableViewManager?.setUpTableView(tableView: categoriesTableView)
    }
    
    override func addSubViews() {
        super.addSubViews()
        self.view.addSubview(categoriesTableView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        categoriesTableView.snp.makeConstraints { (make) in
            make.bottom.trailing.leading.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
        }
    }
}

extension CategoriesViewController: CategoriesViewInput {
    
}
