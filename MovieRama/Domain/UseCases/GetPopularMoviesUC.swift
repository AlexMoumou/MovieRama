//
//  GetPopularMoviesUC.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import Foundation
import Combine

protocol IGetPopularMoviesUC {
    func execute(page: Int) -> AnyPublisher<[Movie], Error>
}

final class GetPopularMoviesUC: IGetPopularMoviesUC {
    private let repo: IMoviesRepository
    
    init(moviesRepo: IMoviesRepository) {
        self.repo = moviesRepo
    }

    func execute(page: Int) -> AnyPublisher<[Movie], Error> {
//        return Publishers.Zip(
//            repo.getPopularMovies(page: page),
//            repo.getFavoriteMovieIDs()
//        ).map { movies, favorites in
//            movies.map { movie in
//                if favorites.contains(movie.id) {
//                    return movie.copyWith(isFavorite: true)
//                } else {
//                    return movie
//                }
//            }
        
        return repo.getPopularMovies(page: page).eraseToAnyPublisher()
    
    }
}
