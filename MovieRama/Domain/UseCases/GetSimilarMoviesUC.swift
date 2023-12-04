//
//  GetSimilarMoviesUC.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Foundation
import Combine

protocol IGetSimilarMoviesUC {
    func execute(id: Int) -> AnyPublisher<[Movie], Error>
}

final class GetSimilarMoviesUC: IGetSimilarMoviesUC {
    private let repo: IMoviesRepository
    private var cancelables = [AnyCancellable]()
    
    
    init(moviesRepo: IMoviesRepository) {
        self.repo = moviesRepo
    }

    func execute(id: Int) -> AnyPublisher<[Movie], Error> {
        return Publishers.Zip(
            repo.getSimilarMovies(id: id),
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
