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
        self.window.rootViewController = navigationController
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
        
        moviesCoordinator.callback = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .goToMovieDetailsWith(let id):
                self.showMovieDetailsWith(id: id)
            }
        }
        
        moviesCoordinator.start()
    }
    
    @MainActor func showMovieDetailsWith(id: String) {
//        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController)
//        childCoordinators[.MovieDetails] = movieDetailsCoordinator
        
//        movieDetailsCoordinator.callback = { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .Movies:
//                self.childCoordinators[.MovieDetails] = nil
//                self.navigationController.popViewController(animated: true)
//            }
//        }
        
//        movieDetailsCoordinator.start()
    }
}
