//
//  NewsViewInput.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

protocol NewsViewInput: class {
    func presentAlert(title: String, message: String, action: ActionAlertModel?)
    func showActivityIndicator()
    func hideActivityIndicator()
    func hideRefreshIndicator()
}
