//
//  GetMoviesUCTests.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulides on 04/12/23.
//

import XCTest

final class GetMoviesUCTests: XCTestCase {

    var moviesRepositoryMock: MoviesRepositoryMock!
    
    override func setUp() {
        moviesRepositoryMock = MoviesRepositoryMock()
    }

    override func tearDown() {
        moviesRepositoryMock = nil
    }

    func test_init() async {
        
    }

}
