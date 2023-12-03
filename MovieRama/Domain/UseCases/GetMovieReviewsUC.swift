//
//  GetMovieReviewsUC.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Foundation
import Combine

protocol IGetMovieReviewsUC {
    func execute(id: Int) -> AnyPublisher<[ReviewDTO], Error>
}

final class GetMovieReviewsUC: IGetMovieReviewsUC {
    private let repo: IMoviesRepository
    private var cancelables = [AnyCancellable]()
    
    
    init(moviesRepo: IMoviesRepository) {
        self.repo = moviesRepo
    }

    func execute(id: Int) -> AnyPublisher<[ReviewDTO], Error> {
        return repo.getMovieReviews(id: id).eraseToAnyPublisher()
    }
}
