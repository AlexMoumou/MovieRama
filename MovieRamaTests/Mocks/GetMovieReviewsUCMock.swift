//
//  GetMovieReviewsUCMock.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import Foundation
import Combine

class GetMovieReviewsUCMock: IGetMovieReviewsUC {
    
    var reviewsState: [ReviewDTO]? = nil
    
    func execute(id: Int) -> AnyPublisher<[ReviewDTO], Error> {
        guard let reviews = reviewsState else {
          fatalError("Result is nil")
        }
        
        return Just(reviews)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
