//
//  AppCoordinator.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol: class {
    func createLandingPage(scene: UIWindowScene)
    func createHomePages(scene: UIWindowScene)
}

class AppCoordinator {
    var window: UIWindow?
}

extension AppCoordinator {
    
    private func createNewsVC() -> UINavigationController {
        let newsViewController = NewsAssembly.assemble(endpoint: .getTopHeadlines)
        newsViewController.title = "News"
        newsViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage.tabBarItems.news, selectedImage: UIImage.tabBarItems.news)
        
        return UINavigationController(rootViewController: newsViewController)
    }
    
    private func createSourcesVC() -> UINavigationController {
        let sourcesViewController = SourcesAssembly.assemble()
        sourcesViewController.title = "Sources"
        sourcesViewController.tabBarItem = UITabBarItem(title: "Sources", image: UIImage.tabBarItems.source, selectedImage: UIImage.tabBarItems.source)
        return UINavigationController(rootViewController: sourcesViewController)
    }
    
    private func createSearchVC() -> UINavigationController {
        let searchViewController = SearchAssembly.assemble()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage.tabBarItems.search, selectedImage: UIImage.tabBarItems.search)
        return UINavigationController(rootViewController: searchViewController)
    }
    
    private func createCategoriesVC() -> UINavigationController {
        let favouritesViewController = CategoriesAssembly.assemble()
        favouritesViewController.title = "Categories"
        favouritesViewController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage.tabBarItems.categories, selectedImage: UIImage.tabBarItems.categories)
        return UINavigationController(rootViewController: favouritesViewController)
    }
    private func createTabBar() -> UITabBarController{
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = UIColor.tintColor
        
        tabBar.viewControllers = [createNewsVC(), createSourcesVC(), createSearchVC(), createCategoriesVC()]
        return tabBar
    }
}

extension AppCoordinator : AppCoordinatorProtocol {
    func createLandingPage(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }
    
    func createHomePages(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }
}
    

