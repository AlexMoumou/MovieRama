//
//  GetSimilarMoviesUCMock.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import Combine

class GetSimilarMoviesUCMock: IGetSimilarMoviesUC {
    var moviesState: [Movie]? = nil
    
    func execute(id: Int) -> AnyPublisher<[Movie], Error> {
        guard let movies = moviesState else {
          fatalError("Result is nil")
        }
        
        return Just(movies)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
