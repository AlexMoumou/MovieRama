//
//  GetPopularMoviesUC.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import Foundation
import Combine

protocol IGetMoviesUC {
    func execute(query: String?, page: Int) -> AnyPublisher<[Movie], Error>
}

final class GetMoviesUC: IGetMoviesUC {
    private let repo: IMoviesRepository
    
    init(moviesRepo: IMoviesRepository) {
        self.repo = moviesRepo
    }

    func execute(query: String?, page: Int) -> AnyPublisher<[Movie], Error> {
        return Publishers.Zip(
            repo.getMovies(query: query, page: page),
            repo.getFavoriteMovieIDs().setFailureType(to: Error.self)
        )
        .map { movies, movieIds in
            
            var mutatedMovies = movies
            
            for (i, movie) in movies.enumerated() {
                if movieIds.contains(movie.id) {
                    mutatedMovies[i] = movie.copyWith(isFavorite: true)
                }
            }
            
            return mutatedMovies
            
        }.eraseToAnyPublisher()
    }
}
