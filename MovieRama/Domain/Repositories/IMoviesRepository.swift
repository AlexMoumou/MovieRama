//
//  IMoviesRepository.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import Foundation
import Combine

protocol IMoviesRepository {
    func getPopularMovies(page: Int) -> AnyPublisher<[Movie], Error>
    func searchMoviesBy(query: String?, page: Int) -> AnyPublisher<[Movie], Error>
//    func saveToFavorites(movieID: String) -> AnyPublisher<Bool, Error>
//    func getFavoriteMovieIDs() -> AnyPublisher<[Int], Error>
}
