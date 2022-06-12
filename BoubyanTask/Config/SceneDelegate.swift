//
//  SceneDelegate.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 11/06/2022.
//

import UIKit
import Moya

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        appInitiation(scene: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate {
    
    func assignMainCoordinator(window: UIWindow?, rootVC: UIViewController){
        let navigation = UINavigationController(rootViewController: rootVC)
        coordinator = MainCoordinator(navigationController: navigation, parent: nil, window: window)
        coordinator?.start()
    }
    
    func appInitiation(scene: UIWindowScene){
        
        let endpointClosure = { (target: ArticleService) -> Endpoint in
            
            let url = target.baseURL.absoluteString + target.path
            let endPoint = Endpoint(url: url,
                                    sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                    method: target.method,
                                    task: target.task,
                                    httpHeaderFields: target.headers)
            
            print(endPoint.url)
            print(endPoint.task)
            print(endPoint.method)
            print(endPoint.httpHeaderFields ?? ["":""])
            
            return endPoint
        }
        let provider = MoyaProvider<ArticleService>(endpointClosure: endpointClosure)
        let articleRepository = ArticleRepository(provider: provider)
        let articleViewModel = ArticlesViewModel(repository: articleRepository)
        let vc = ArticlesVC(viewModel: articleViewModel)
        window = UIWindow(windowScene: scene)
        assignMainCoordinator(window: window, rootVC: vc)
    }
}
