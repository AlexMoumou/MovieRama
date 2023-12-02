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
    
    //Sadly swift does not support property wrapper definition in a protocol
    var moviesList: Published<[Movie]>.Publisher { get }
    var moviesListPublish: [Movie] { get }
    
    var page: Int { get set }
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
    
    private let getPopularMoviesUC: IGetPopularMoviesUC
    @Published var moviesListPublish: [Movie] = []
    
    var moviesList: Published<[Movie]>.Publisher { $moviesListPublish }
    
    var page: Int = 1
    
    private var cancelables = [AnyCancellable]()
    var callback: (@MainActor (MoviesViewModelResult) -> Void)?
    
    init(getPopularMoviesUC: IGetPopularMoviesUC) {
        self.getPopularMoviesUC = getPopularMoviesUC
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
        getPopularMoviesUC.execute(page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.moviesListPublish = response
            })
            .store(in: &cancelables)
    }
    
    private func refreshMovies() {

    }
}
