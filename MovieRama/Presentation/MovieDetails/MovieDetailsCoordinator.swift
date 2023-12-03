//
//  MovieDetailsCoordinator.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import UIKit
import SwiftUI

enum MovieDetailsCoordinatorResult {
    case goBack
}

class MovieDetailsCoordinator: Coordinator {
    
    var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    var navigationController: UINavigationController
    //optional, if there was a different route to go
    var callback: (@MainActor (MovieDetailsCoordinatorResult) -> Void)?
    
    let movieId: Int
    
    init(navigationController: UINavigationController, movieId: Int) {
        self.navigationController = navigationController
        self.movieId = movieId
    }
    
    func start() {
        let vm = AppDIContainer.shared.makeMovieDetailsViewModel(movieId: movieId)
        
        vm.callback = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .goBack:
                self.callback!(.goBack)
            }
        }
        
        // Since the assignment stated 'If you want, you may use SwiftUI for the movie details screen only.'
        // Im doing the MovieDetails in SwiftUI just for showcase
        
        let vc = AppDIContainer.shared.makeMovieDetailsView(vm: vm)
        
        let host = UIHostingController(rootView: vc)
    
        navigationController.pushViewController(host, animated: true)
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        
    }
}
