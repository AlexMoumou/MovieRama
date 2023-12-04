//
//  MoviesViewModelTests.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import XCTest

final class MoviesViewModelTests: XCTestCase {

    var getMoviesUC: GetMoviesUCMock?
    var toggleMovieFavoriteStatucUC: ToggleMovieAsFavoriteUCMock?
    var sut: MoviesViewModel?
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        sut = nil
        getMoviesUC = nil
        toggleMovieFavoriteStatucUC = nil
        super.tearDown()
    }

    func test_successfull_load_without_query() {
        
        let initialMovies = [
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
        ]
        
        let expectedMovies = [
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
            Movie.example().copyWith(id: 5),
            Movie.example().copyWith(id: 6),
            Movie.example().copyWith(id: 7),
            Movie.example().copyWith(id: 8),
        ]
        
        getMoviesUC = GetMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        getMoviesUC?.moviesState = [
            Movie.example().copyWith(id: 5),
            Movie.example().copyWith(id: 6),
            Movie.example().copyWith(id: 7),
            Movie.example().copyWith(id: 8),
        ]
        
        toggleMovieFavoriteStatucUC?.result = true
        
        sut = MoviesViewModel(getMoviesUC: getMoviesUC!, toggleFavoriteStatusUC: toggleMovieFavoriteStatucUC!)
        
        
        sut?.moviesListPublish = initialMovies
        sut?.lastQuery = nil
        
        XCTAssert(sut?.page == 1)
        
        sut?.send(action: .load(query: nil))
        
        waitForValue(of: sut!.$moviesListPublish, value: expectedMovies)
        
        //Page indicates what will be loaded next
        XCTAssert(sut?.page == 2)
    }
    
    func test_successfull_load_with_new_query() {
        
        let initialMovies = [
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
        ]
        
        let expectedMovies = [
            Movie.example().copyWith(id: 5),
            Movie.example().copyWith(id: 6),
            Movie.example().copyWith(id: 7),
            Movie.example().copyWith(id: 8),
        ]
        
        getMoviesUC = GetMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        getMoviesUC?.moviesState = expectedMovies
        
        toggleMovieFavoriteStatucUC?.result = true
        
        sut = MoviesViewModel(getMoviesUC: getMoviesUC!, toggleFavoriteStatusUC: toggleMovieFavoriteStatucUC!)
        
        
        sut?.moviesListPublish = initialMovies
        sut?.lastQuery = nil
        
        XCTAssert(sut?.page == 1)
        
        sut?.send(action: .load(query: "lord+of+the+rings"))
        
        waitForValue(of: sut!.$moviesListPublish, value: expectedMovies)
        
        //Page indicates what will be loaded next
        XCTAssert(sut?.page == 2)
    }
    
    func test_successfull_refresh_updates_data_correctly() {
        
        let initialMovies = [
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
        ]
        
        let expectedMovies = [
            Movie.example().copyWith(id: 5),
            Movie.example().copyWith(id: 6),
            Movie.example().copyWith(id: 7),
            Movie.example().copyWith(id: 8),
        ]
        
        getMoviesUC = GetMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        getMoviesUC?.moviesState = expectedMovies
        
        toggleMovieFavoriteStatucUC?.result = true
        
        sut = MoviesViewModel(getMoviesUC: getMoviesUC!, toggleFavoriteStatusUC: toggleMovieFavoriteStatucUC!)
        
        sut?.moviesListPublish = initialMovies
        sut?.lastQuery = nil
        sut?.page = 5
        
        XCTAssert(sut?.page == 5)
        
        sut?.send(action: .refresh)
        
        waitForValue(of: sut!.$moviesListPublish, value: expectedMovies)
        
        //Page indicates what will be loaded next
        XCTAssert(sut?.page == 2)
    }
    
    func test_successfull_on_next_page_scroll_updates_data_correctly() {
        
        var initialMovies = [
            Movie.example().copyWith(id: 1),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
        ]
        
        let expectedMovies = [
            Movie.example().copyWith(id: 5),
            Movie.example().copyWith(id: 6),
            Movie.example().copyWith(id: 7),
            Movie.example().copyWith(id: 8),
        ]
        
        getMoviesUC = GetMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        getMoviesUC?.moviesState = expectedMovies
        
        toggleMovieFavoriteStatucUC?.result = true
        
        sut = MoviesViewModel(getMoviesUC: getMoviesUC!, toggleFavoriteStatusUC: toggleMovieFavoriteStatucUC!)
        
        sut?.moviesListPublish = initialMovies
        sut?.lastQuery = "test"
        sut?.page = 5
        
        XCTAssert(sut?.page == 5)
        XCTAssert(sut?.lastQuery == "test")
        
        sut?.send(action: .onScrollLoad)
        
        waitForValue(of: sut!.$moviesListPublish, value: initialMovies + expectedMovies)
        
        //Page indicates what will be loaded next
        XCTAssert(sut?.page == 6)
        
        //Query should not change on scroll of next page
        XCTAssert(sut?.lastQuery == "test")
    }
    
    func test_on_tap_movie_fires_callback() {
        
        getMoviesUC = GetMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        sut = MoviesViewModel(getMoviesUC: getMoviesUC!, toggleFavoriteStatusUC: toggleMovieFavoriteStatucUC!)
        
        let expectation = XCTestExpectation()
        
        sut?.callback = { _ in
            expectation.fulfill()
        }
        
        sut?.send(action: .tapMovieWith(id: 1))
        
        //callback fires
        wait(for: [expectation], timeout: 0.4)
    }
    
    func test_on_successfull_favorite_movie_updates_data_correctly() {
        
        var initialMovies = [
            Movie.example().copyWith(id: 1, isFavorite: false),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
        ]
        
        let expectedMovies = [
            Movie.example().copyWith(id: 1, isFavorite: true),
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
        ]
        
        getMoviesUC = GetMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        toggleMovieFavoriteStatucUC?.result = true
        
        sut = MoviesViewModel(getMoviesUC: getMoviesUC!, toggleFavoriteStatusUC: toggleMovieFavoriteStatucUC!)
        
        sut?.moviesListPublish = initialMovies
        
        sut?.send(action: .favoriteMovieWith(id: 1))
        
        waitForValue(of: sut!.$moviesListPublish, value: expectedMovies)
    }
    
}
