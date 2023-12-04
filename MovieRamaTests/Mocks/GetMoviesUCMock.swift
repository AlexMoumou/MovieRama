//
//  GetMoviesUCMock.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import XCTest
import Combine

class GetMoviesUCMock: IGetMoviesUC {
    var moviesState: [Movie]? = nil
    
    func execute(query: String?, page: Int) -> AnyPublisher<[Movie], Error> {
        guard let movies = moviesState else {
          fatalError("Result is nil")
        }
        
        return Just(movies)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
