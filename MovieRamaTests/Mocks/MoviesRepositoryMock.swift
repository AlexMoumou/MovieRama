//
//  MoviesRepositoryMock.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulides on 04/12/23.
//

import Foundation
import Combine

class MoviesRepositoryMock: IMoviesRepository {
    
    var fullMovieToReturn: MovieFull = MovieFull.example()
    var moviesToReturn: [Movie] = []
    var similarMoviesToReturn: [Movie] = []
    var reviewsToReturn: [ReviewDTO] = []
    var favouriteMovieidsToReturn: [Int] = []
    var toggleFavoriteStatusResult: Bool = false
    
    func getMovies(query: String?, page: Int) -> AnyPublisher<[Movie], Error> {
        Just(moviesToReturn).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getMovie(id: Int) -> AnyPublisher<MovieFull, Error> {
        Just(fullMovieToReturn).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getMovieReviews(id: Int) -> AnyPublisher<[ReviewDTO], Error> {
        Just(reviewsToReturn).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getSimilarMovies(id: Int) -> AnyPublisher<[Movie], Error> {
        Just(similarMoviesToReturn).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func toggleFavoriteStatus(movieID: Int) -> AnyPublisher<Bool, Never> {
        Just(toggleFavoriteStatusResult).eraseToAnyPublisher()
    }
    
    func getFavoriteMovieIDs() -> AnyPublisher<[Int], Never> {
        Just(favouriteMovieidsToReturn).eraseToAnyPublisher()
    }
    
    
}
