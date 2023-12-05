//
//  MovieDetailsViewTests.swift
//  MovieRamaTests
//
//  Created by Alex Moumoulidis on 5/12/23.
//

import XCTest
import SnapshotTesting
import SwiftUI

final class MovieDetailsViewTests: XCTestCase {

    var movieDetailsViewModel: MovieDetailsViewModel?
    var getMovieReviewsUC: GetMovieReviewsUCMock?
    var getMovieUC: GetMovieUCMock?
    var getSimilarMoviesUC: GetSimilarMoviesUCMock?
    var toggleMovieFavoriteStatucUC: ToggleMovieAsFavoriteUCMock?
    
    override func setUpWithError() throws {

        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        movieDetailsViewModel = nil
        getMovieReviewsUC = nil
        getMovieUC = nil
        getSimilarMoviesUC = nil
        toggleMovieFavoriteStatucUC = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefaultMovieDetailsSnapshot() throws {
        
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
        
        movieDetailsViewModel = MovieDetailsViewModel(getMovieUC: getMovieUC!, getMovieReviewsUC: getMovieReviewsUC!, getSimilarMoviesUC: getSimilarMoviesUC!, toggleMovieAsFavoriteUC: toggleMovieFavoriteStatucUC!, movieId: 1)
        
        waitForValue(of: movieDetailsViewModel!.$movieData, value: fullMovie)
        waitForValue(of: movieDetailsViewModel!.$movieReviews, value: movieReviews)
        waitForValue(of: movieDetailsViewModel!.$similarMovies, value: similarMovies)
        
        //image loading needs to be abstracted so that we can have a screenshot with the images
        
        let movieDeets = MovieDetailsView(vm: movieDetailsViewModel!)
        assertSnapshot(matching: movieDeets.toVC(), as: .image)
    }
    
    func testMovieIsFavoriteSnapshot() throws {
        
        let similarMovies = [
            Movie.example().copyWith(id: 2),
            Movie.example().copyWith(id: 3),
            Movie.example().copyWith(id: 4),
            Movie.example().copyWith(id: 5),
        ]
        
        let movieReviews = [
            ReviewDTO.example()
        ]
        
        let fullMovie = MovieFull.example().copyWith(isFavorite: true)

        getMovieReviewsUC = GetMovieReviewsUCMock()
        getMovieUC = GetMovieUCMock()
        getSimilarMoviesUC = GetSimilarMoviesUCMock()
        toggleMovieFavoriteStatucUC = ToggleMovieAsFavoriteUCMock()
        
        getMovieReviewsUC?.reviewsState = movieReviews
        getMovieUC?.movieState = fullMovie
        getSimilarMoviesUC?.moviesState = similarMovies
        toggleMovieFavoriteStatucUC?.result = true
        
        movieDetailsViewModel = MovieDetailsViewModel(getMovieUC: getMovieUC!, getMovieReviewsUC: getMovieReviewsUC!, getSimilarMoviesUC: getSimilarMoviesUC!, toggleMovieAsFavoriteUC: toggleMovieFavoriteStatucUC!, movieId: 1)
        
        waitForValue(of: movieDetailsViewModel!.$movieData, value: fullMovie)
        waitForValue(of: movieDetailsViewModel!.$movieReviews, value: movieReviews)
        waitForValue(of: movieDetailsViewModel!.$similarMovies, value: similarMovies)
        
        //image loading needs to be abstracted so that we can have a screenshot with the images
        
        let movieDeets = MovieDetailsView(vm: movieDetailsViewModel!)
        assertSnapshot(matching: movieDeets.toVC(), as: .image)
    }
    
}

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
