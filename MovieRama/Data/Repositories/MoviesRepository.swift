//
//  MoviesRepository.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import Combine

final class MoviesRepository: IMoviesRepository {
    
    private let restClient: IRestClient
        
    init(restClient: IRestClient) {
        self.restClient = restClient
    }
    
    
    func getPopularMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        restClient.get(TMDBApiEndpoint.popularMovies(page)).map { (response: MoviesDTO) in
            response.items.map { $0.mapToDomain() }
        }.eraseToAnyPublisher()
    }
    
    func searchMoviesBy(query: String?, page: Int) -> AnyPublisher<[Movie], Error> {
        restClient.get(TMDBApiEndpoint.searchMovies(page, query ?? "")).map { (response: MoviesDTO) in
            response.items.map { $0.mapToDomain() }
        }.eraseToAnyPublisher()
    }
    
//    func saveToFavorites(movieID: String) -> AnyPublisher<Bool, Error> {
//        
//    }
//    
//    func getFavoriteMovieIDs() -> AnyPublisher<[Int], Error> {
//        
//    }
    
    
}
