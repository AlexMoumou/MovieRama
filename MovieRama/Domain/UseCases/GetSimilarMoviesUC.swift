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
            
        return repo.getSimilarMovies(id: id).eraseToAnyPublisher()
        
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
