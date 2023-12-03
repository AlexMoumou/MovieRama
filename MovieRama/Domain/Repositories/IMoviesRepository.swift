//
//  IMoviesRepository.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import Foundation
import Combine

protocol IMoviesRepository {
    func getMovies(query: String?, page: Int) -> AnyPublisher<[Movie], Error>
    func getMovie(id: Int) -> AnyPublisher<MovieFull, Error>
    func getMovieReviews(id: Int) -> AnyPublisher<[ReviewDTO], Error>
    func getSimilarMovies(id: Int) -> AnyPublisher<[Movie], Error>
//    func saveToFavorites(movieID: String) -> AnyPublisher<Bool, Error>
//    func getFavoriteMovieIDs() -> AnyPublisher<[Int], Error>
}
