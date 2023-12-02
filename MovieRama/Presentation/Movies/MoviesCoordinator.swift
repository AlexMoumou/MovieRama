//
//  MoviesCoordinator.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import UIKit
import SwiftUI

enum MoviesCoordinatorResult {
    case goToMovieDetailsWith(id: String)
}

class MoviesCoordinator: Coordinator {
    
    var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    var navigationController: UINavigationController
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
                self.callback?(.goToMovieDetailsWith(id: id))
            }
        }
        
        let vc = MoviesViewController.create(with: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
