//
//  AppCoordinator.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import UIKit

enum AppChildCoordinator {
    case Movies
    case MovieDetails
}

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let diContainer: AppDIContainer
    var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    var navigationController: UINavigationController
    
    init(window: UIWindow, container: AppDIContainer) {
        self.diContainer = container
        self.window = window
        navigationController = UINavigationController()

        setupGlobalAppearance()
        
        self.window.rootViewController = navigationController
    }
    
    func setupGlobalAppearance() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .highlighted)
    }
    
    func start() {
        // Here we could do logic for navigating between top level features e.g. login -> Home
        Task {
            await showMovies()
        }
    }
    
    @MainActor func showMovies() {
        let moviesCoordinator = MoviesCoordinator(navigationController: navigationController)
        childCoordinators[.Movies] = moviesCoordinator
        
        moviesCoordinator.start()
    }
}
