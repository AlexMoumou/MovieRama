//
//  GetMovieUC.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Combine

protocol IGetMovieUC {
    func execute(id: Int) -> AnyPublisher<MovieFull, Error>
}

final class GetMovieUC: IGetMovieUC {
    private let repo: IMoviesRepository
    
    init(moviesRepo: IMoviesRepository) {
        self.repo = moviesRepo
    }

    func execute(id: Int) -> AnyPublisher<MovieFull, Error> {
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
        
        return repo.getMovie(id: id).eraseToAnyPublisher()
    }
}
