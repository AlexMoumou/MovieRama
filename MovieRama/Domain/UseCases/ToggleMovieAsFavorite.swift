//
//  SetMovieAsFavorite.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Foundation
import Combine

protocol IToggleMovieAsFavoriteUC {
    func execute(id: Int) -> AnyPublisher<Bool, Never>
}

final class ToggleMovieAsFavoriteUC: IToggleMovieAsFavoriteUC {
    private let repo: IMoviesRepository
    private var cancelables = [AnyCancellable]()
    
    init(moviesRepo: IMoviesRepository) {
        self.repo = moviesRepo
    }

    func execute(id: Int) -> AnyPublisher<Bool, Never> {
        return repo.toggleFavoriteStatus(movieID: id).eraseToAnyPublisher()
    }
}
