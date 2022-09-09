//
//  AppInteractor.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit



class AppInteractor {
    
    private var coordinator: AppCoordinatorProtocol?
    private weak var windowScene: UIWindowScene!
    
    init(windowScene: UIWindowScene){
        self.windowScene = windowScene
        self.setupServiceLocator()
    }
    
    private func setupServiceLocator(){
        
        let networkService = NetworkService<NewsEndPoint>()
        ServiceLocator.shared.addService(service: networkService as NetworkService)
    }
    
}
