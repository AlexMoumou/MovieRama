//
//  MoviesCoordinator.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import UIKit
import SwiftUI

enum MoviesCoordinatorResult {
    case goToMovieDetailsWith(id: Int)
}

class MoviesCoordinator: Coordinator {
    
    var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    var navigationController: UINavigationController
    //optional, if there was a different route to go
    var callback: (@MainActor (MoviesCoordinatorResult) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = AppDIContainer.shared.makeMoviesViewModel()
        vm.callback = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .goToMovieDetailsWith(let id):
                self.goToMovieDetailsWith(id: id)
            }
        }
        
        let vc = MoviesViewController.create(with: vm)
        
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToMovieDetailsWith(id: Int) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movieId: id)
        childCoordinators[.MovieDetails] = movieDetailsCoordinator
        
        movieDetailsCoordinator.callback = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .goBack:
                self.childCoordinators[.MovieDetails] = nil
                self.navigationController.popViewController(animated: true)
            }
        }
        
        movieDetailsCoordinator.start()
    }
}
