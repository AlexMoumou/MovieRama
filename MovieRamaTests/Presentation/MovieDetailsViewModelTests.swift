//
//  MovieDetailsViewModelTests.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import XCTest

final class MovieDetailsViewModelTests: XCTestCase {

    var getMovieReviewsUC: GetMovieReviewsUCMock?
    var getMovieUC: GetMovieUCMock?
    var getSimilarMoviesUC: GetSimilarMoviesUCMock?
    var toggleMovieFavoriteStatucUC: ToggleMovieAsFavoriteUCMock?
    var sut: MovieDetailsViewModel?
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        sut = nil
        getMovieReviewsUC = nil
        getMovieUC = nil
        getSimilarMoviesUC = nil
        toggleMovieFavoriteStatucUC = nil
        super.tearDown()
    }
    
    func test_on_init_loads_all_data() {
        
        let similarMovies = [
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
            Movie.example().copyWith(id: 5),
        ]
        
        let movieReviews = [
            ReviewDTO.example()
        ]
        
        let fullMovie = MovieFull.example()

        getMovieReviewsUC = GetMovieReviewsUCMock()
        getMovieUC = GetMovieUCMock()
        getSimilarMoviesUC = GetSimilarMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        getMovieReviewsUC?.reviewsState = movieReviews
        getMovieUC?.movieState = fullMovie
        getSimilarMoviesUC?.moviesState = similarMovies
        toggleMovieFavoriteStatucUC?.result = true
        
        sut = MovieDetailsViewModel(getMovieUC: getMovieUC!, getMovieReviewsUC: getMovieReviewsUC!, getSimilarMoviesUC: getSimilarMoviesUC!, toggleMovieAsFavoriteUC: toggleMovieFavoriteStatucUC!, movieId: 1)

        XCTAssert(sut!.movieData == nil)
        XCTAssert(sut!.movieReviews == [])
        XCTAssert(sut!.similarMovies == [])
        
        waitForValue(of: sut!.$movieData, value: fullMovie)
        waitForValue(of: sut!.$movieReviews, value: movieReviews)
        waitForValue(of: sut!.$similarMovies, value: similarMovies)
        
        XCTAssert(sut!.movieData == fullMovie)
        XCTAssert(sut!.movieReviews == movieReviews)
        XCTAssert(sut!.similarMovies == similarMovies)
    }
    
    func test_on_success_favorite_status_updates_correctly() {
        
        let similarMovies = [
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
            Movie.example().copyWith(id: 5),
        ]
        
        let movieReviews = [
            ReviewDTO.example()
        ]
        
        let fullMovie = MovieFull.example().copyWith(isFavorite: false)
        
        let expectedfullMovie = MovieFull.example().copyWith(isFavorite: true)

        getMovieReviewsUC = GetMovieReviewsUCMock()
        getMovieUC = GetMovieUCMock()
        getSimilarMoviesUC = GetSimilarMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        getMovieReviewsUC?.reviewsState = movieReviews
        getMovieUC?.movieState = fullMovie
        getSimilarMoviesUC?.moviesState = similarMovies
        toggleMovieFavoriteStatucUC?.result = true
        
        sut = MovieDetailsViewModel(getMovieUC: getMovieUC!, getMovieReviewsUC: getMovieReviewsUC!, getSimilarMoviesUC: getSimilarMoviesUC!, toggleMovieAsFavoriteUC: toggleMovieFavoriteStatucUC!, movieId: 1)

        XCTAssert(sut!.movieData == nil)
        
        sut?.send(action: .toggleFavoriteStatus)
        
        waitForValue(of: sut!.$movieData, value: expectedfullMovie)
        
        XCTAssert(sut!.movieData == expectedfullMovie)
    }
    
    func test_on_back_fires_callback() {
        
        let similarMovies = [
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
            Movie.example().copyWith(id: 5),
        ]
        
        let movieReviews = [
            ReviewDTO.example()
        ]
        
        let fullMovie = MovieFull.example()
        
        getMovieReviewsUC = GetMovieReviewsUCMock()
        getMovieUC = GetMovieUCMock()
        getSimilarMoviesUC = GetSimilarMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        getMovieReviewsUC?.reviewsState = movieReviews
        getMovieUC?.movieState = fullMovie
        getSimilarMoviesUC?.moviesState = similarMovies
        toggleMovieFavoriteStatucUC?.result = true
        
        sut = MovieDetailsViewModel(getMovieUC: getMovieUC!, getMovieReviewsUC: getMovieReviewsUC!, getSimilarMoviesUC: getSimilarMoviesUC!, toggleMovieAsFavoriteUC: toggleMovieFavoriteStatucUC!, movieId: 1)
        
        let expectation = XCTestExpectation()
        
        sut?.callback = { _ in
            expectation.fulfill()
        }
        
        sut?.send(action: .goBack)
        
        //callback fires
        wait(for: [expectation], timeout: 0.4)
    }
}
