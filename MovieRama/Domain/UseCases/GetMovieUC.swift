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
//        return Publishers.CombineLatest(
//            repo.getMovie(id: id),
//            repo.getSimilarMovies(id: 15125125)
//        ).receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                // Handle error / completion
//                // If either stream produces an error, the error will be forwarded in here
//            }, receiveValue: { movie, similarMovies in
//                movie.copyWith(similarMovies: similarMovies)
//
//                Just(movie).eraseToAnyPublisher()
//            })
//            // You only need to store this subscription - not publisher and publisher2 individually
//            .store(in: &cancelables)
            
        return repo.getMovie(id: id).eraseToAnyPublisher()
        
//        .sink(receiveCompletion: { _ in
//
//        }, receiveValue: { (movie, similarMovies) in
//            print(movie)
//            print(similarMovies)
//        })
//        .map { movie, similarMovies in
//            movie.copyWith(similarMovies: similarMovies)
//        }
//        .eraseToAnyPublisher()
    }
}
