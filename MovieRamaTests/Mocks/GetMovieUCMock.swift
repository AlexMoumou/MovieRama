//
//  GetMovieUCMock.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import Combine

class GetMovieUCMock: IGetMovieUC {
    var movieState: MovieFull? = nil
    
    func execute(id: Int) -> AnyPublisher<MovieFull, Error> {
        guard let movie = movieState else {
          fatalError("Result is nil")
        }
        
        return Just(movie)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}


