//
//  MoviesViewModel.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import Foundation
import Combine

protocol IMoviesViewModel: ObservableObject {
    func send(action: MoviesViewModelAction)
    var moviesList: [Movie] { get set }
    var page: String? { get set }
    var callback: (@MainActor (MoviesViewModelResult) -> Void)? { get set }
}

enum MoviesViewModelResult {
    case goToMovieDetailsWith(id: String)
}

enum MoviesViewModelAction {
    case load
    case refresh
    case tapMovieWith(id: String)
}

class MoviesViewModel: IMoviesViewModel {
    
    @Published var moviesList: [Movie] = []
    @Published var page: String?
    
    private var cancelables = [AnyCancellable]()
    var callback: (@MainActor (MoviesViewModelResult) -> Void)?
    
    init() {
    }
    
    func send(action: MoviesViewModelAction) {
        switch action {
        case .load:
            loadMovies()
        case .refresh:
            refreshMovies()
        case .tapMovieWith(let id):
            Task { await callback?(.goToMovieDetailsWith(id: id)) }
        }
    }
    
    private func loadMovies() {
    }
    
    private func refreshMovies() {

    }
}
