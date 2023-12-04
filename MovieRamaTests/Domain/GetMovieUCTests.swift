//
//  GetMovieUCTests.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import XCTest

final class GetMovieUCTests: XCTestCase {

    var moviesRepositoryMock: MoviesRepositoryMock!
    var sut: IGetMovieUC?
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        moviesRepositoryMock = nil
        super.tearDown()
    }

    func test_theMovieUpdates_whenIdinFavorites() async {
        
        moviesRepositoryMock = MoviesRepositoryMock()
        
        let ids = [1,2,3]
        
        let movie = MovieFull.example().copyWith(id: 2, isFavorite: false)
        
        let excpectedMovie = MovieFull.example().copyWith(id: 2, isFavorite: true)
        
        moviesRepositoryMock.favouriteMovieidsToReturn = ids
        moviesRepositoryMock.fullMovieToReturn = movie
        
        sut = GetMovieUC(moviesRepo: moviesRepositoryMock)
        
        
        waitForValue(of: sut!.execute(id: 1), value: excpectedMovie)
    }
    
    func test_theMovieDoesNotUpdate_whenId_NotinFavorites() async {
        
        moviesRepositoryMock = MoviesRepositoryMock()
        
        let ids = [1,3]
        
        let movie = MovieFull.example().copyWith(id: 2, isFavorite: false)
        
        let excpectedMovie = MovieFull.example().copyWith(id: 2, isFavorite: false)
        
        moviesRepositoryMock.favouriteMovieidsToReturn = ids
        moviesRepositoryMock.fullMovieToReturn = movie
        
        sut = GetMovieUC(moviesRepo: moviesRepositoryMock)
        
        
        waitForValue(of: sut!.execute(id: 1), value: excpectedMovie)
    }

}
