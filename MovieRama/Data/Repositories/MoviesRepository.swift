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
    
    
    func getMovies(query: String?, page: Int) -> AnyPublisher<[Movie], Error> {
        restClient.get(query == nil ? TMDBApiEndpoint.popularMovies(page): TMDBApiEndpoint.searchMovies(page, query!)).map { (response: MoviesDTO) in
            response.items.map { $0.mapToDomain() }
        }.eraseToAnyPublisher()
    }
    
    func searchMoviesBy(query: String?, page: Int) -> AnyPublisher<[Movie], Error> {
        restClient.get(TMDBApiEndpoint.searchMovies(page, query ?? "")).map { (response: MoviesDTO) in
            response.items.map { $0.mapToDomain() }
        }.eraseToAnyPublisher()
    }
    
    func getMovie(id: Int) -> AnyPublisher<MovieFull, Error> {
        restClient.get(TMDBApiEndpoint.movie(id)).map { (response: MovieFullDTO) in
            response.mapToDomain()
        }.eraseToAnyPublisher()
    }
    
    func getMovieReviews(id: Int) -> AnyPublisher<[ReviewDTO], Error> {
        restClient.get(TMDBApiEndpoint.movieReviews(1, id)).map { (response: MovieReviewsDTO) in
            response.results
        }.eraseToAnyPublisher()
    }

    func getSimilarMovies(id: Int) -> AnyPublisher<[Movie], Error> {
        restClient.get(TMDBApiEndpoint.similarMovies(1, id)).map { (response: MoviesDTO) in
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
