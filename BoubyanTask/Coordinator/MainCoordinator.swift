//
//  MainCoordinator.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 11/06/2022.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var parent: Coordinator?
    var window: UIWindow?
    
    init(navigationController: UINavigationController, parent: Coordinator?, window: UIWindow?) {
        self.window = window
        self.navigationController = navigationController
        self.parent = parent
    }
    
    func start() {
        navigationController.delegate = self
        navigationController.navigationBar.prefersLargeTitles = true
        if let articlesVC = navigationController.viewControllers.first as? ArticlesVC {
            articlesVC.coordinator = self
        }
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateArticleDetailsScreen(article: ArticleModel) {
        let articleDetailsVC = ArticleDetailsVC(article: article)
        articleDetailsVC.coordinator = self
        navigationController.pushViewController(articleDetailsVC, animated: true)
    }
}


extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}
