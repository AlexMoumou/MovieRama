//
//  GetSimilarMoviesUCTests.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import XCTest

final class GetSimilarMoviesUCTests: XCTestCase {

    var moviesRepositoryMock: MoviesRepositoryMock!
    var sut: IGetSimilarMoviesUC?
    
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
        moviesRepositoryMock.similarMoviesToReturn = movies
        
        sut = GetSimilarMoviesUC(moviesRepo: moviesRepositoryMock)
        
        
        waitForValue(of: sut!.execute(id: 1), value: excpectedMovies)
    }

}
