//
//  GetMoviesUCTests.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulides on 04/12/23.
//

import XCTest

final class GetMoviesUCTests: XCTestCase {

    var moviesRepositoryMock: MoviesRepositoryMock!
    var sut: IGetMoviesUC?
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        moviesRepositoryMock = nil
        super.tearDown()
    }

    func test_the_correct_movies_are_correctly_updated() async {
        
        moviesRepositoryMock = MoviesRepositoryMock()
        
        let ids = [1,2,3]
        
        let movies = [
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
        ]
        
        let excpectedMovies = [
            Movie.example().copyWith(id: 1, isFavorite: true),
            Movie.example().copyWith(id: 2, isFavorite: true),
            Movie.example().copyWith(id: 3, isFavorite: true),
            Movie.example().copyWith(id: 4),
        ]
        
        moviesRepositoryMock.favouriteMovieidsToReturn = ids
        moviesRepositoryMock.moviesToReturn = movies
        
        sut = GetMoviesUC(moviesRepo: moviesRepositoryMock)
        
        
        waitForValue(of: sut!.execute(query: "test", page: 1), value: excpectedMovies)
    }

}
