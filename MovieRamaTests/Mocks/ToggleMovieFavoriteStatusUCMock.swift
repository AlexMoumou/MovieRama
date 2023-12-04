//
//  ToggleMovieFavoriteStatusUCMock.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import XCTest
import Combine

class ToggleMovieAsFavoriteUCMock: IToggleMovieAsFavoriteUC {
    
    var result: Bool = false
    
    func execute(id: Int) -> AnyPublisher<Bool, Never> {
        return Just(result)
        .eraseToAnyPublisher()
    }
}
