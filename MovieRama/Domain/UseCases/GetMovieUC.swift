//
//  GetMovieUC.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Combine
import Foundation

protocol IGetMovieUC {
    func execute(id: Int) -> AnyPublisher<MovieFull, Error>
}

final class GetMovieUC: IGetMovieUC {
    private let repo: IMoviesRepository
    private var cancelables = [AnyCancellable]()
    
    
    init(moviesRepo: IMoviesRepository) {
        self.repo = moviesRepo
    }

    func execute(id: Int) -> AnyPublisher<MovieFull, Error> {
        return Publishers.Zip(
            repo.getMovie(id: id),
            repo.getFavoriteMovieIDs().setFailureType(to: Error.self)
        )
        .map { movie, movieIds in
            
            if movieIds.contains(movie.id) {
                let newMovie = movie.copyWith(isFavorite: true)
                return newMovie
            }
            return movie
            
        }.eraseToAnyPublisher()
    }
}
