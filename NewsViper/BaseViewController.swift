//
//  BaseViewController.swift
//  NewsViper
//
//  Created by Farendza Muda on 08/09/22.
//

import Foundation
import UIKit
import SnapKit

class BaseViewController: UIViewController {
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var indicatorBlurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    func setUpUI() {
        self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.addSubViews()
        self.makeConstraints()
    }
    
    func addSubViews() {
        self.view.addSubview(indicatorBlurView)
        self.indicatorBlurView.contentView.addSubview(indicator)
    }
    
    func makeConstraints() {
        indicatorBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func showActivityIndicator() {
        self.indicatorBlurView.isHidden = false
        self.view.bringSubviewToFront(self.indicatorBlurView)
        self.indicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.indicatorBlurView.isHidden = true
        self.indicator.stopAnimating()
    }
    
    func addKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardStartSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.handleKeyboardHeight(rect: keyboardStartSize)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let swipeGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboardOnSwipe))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        self.handleTapGesture()
        view.endEditing(true)
    }
    
    @objc func dismissKeyboardOnSwipe(gesture:UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            self.dismissKeyboard()
        }
    }
    
    func handleKeyboardHeight(rect: CGRect) {
    }
    func handleTapGesture(){
    }
}
