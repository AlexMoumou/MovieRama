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
    case goToMovieDetailsWith(id: Int)
}

enum MoviesViewModelAction {
    case load(query: String?)
    case onScrollLoad
    case refresh
    case tapMovieWith(id: Int)
    case favoriteMovieWith(id: Int)
}

class MoviesViewModel: IMoviesViewModel {
    
    private let getMoviesUC: IGetMoviesUC
    private let toggleFavoriteStatusUC: IToggleMovieAsFavoriteUC
    
    @Published var moviesListPublish: [Movie] = []
    var moviesList: Published<[Movie]>.Publisher { $moviesListPublish }
    
    var page: Int = 1
    
    var lastQuery: String? = nil
    var isLoading: Bool = false
    var isEndOfResults: Bool = false
    
    private var cancelables = [AnyCancellable]()
    var callback: (@MainActor (MoviesViewModelResult) -> Void)?
    
    init(getMoviesUC: IGetMoviesUC, toggleFavoriteStatusUC: IToggleMovieAsFavoriteUC) {
        self.getMoviesUC = getMoviesUC
        self.toggleFavoriteStatusUC = toggleFavoriteStatusUC
    }
    
    func send(action: MoviesViewModelAction) {
        switch action {
        case .load(let query):
            if lastQuery != query {
                lastQuery = nil
                page = 1
                moviesListPublish = []
                isEndOfResults = false
            }
            loadMovies(query: query)
        case .onScrollLoad:
            loadMovies(query: lastQuery)
        case .refresh:
            refreshMovies()
        case .tapMovieWith(let id):
            Task { await callback?(.goToMovieDetailsWith(id: id)) }
        case .favoriteMovieWith(let id):
            favoriteMovieWith(id: id)
        }
    
    }
    
    private func loadMovies(query: String? = nil) {
        
        if isLoading || isEndOfResults { return }
        isLoading = true
        
        getMoviesUC.execute(query: query, page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            },
            receiveValue: { [weak self] response in
                self?.lastQuery = query
                self?.moviesListPublish += response
                
                if !response.isEmpty {
                    self?.page += 1
                    self?.isEndOfResults = false
                } else {
                    self?.isEndOfResults = true
                }
                
                self?.isLoading = false
            })
            .store(in: &cancelables)
    }
    
    private func favoriteMovieWith(id: Int) {
        if isLoading { return }
        isLoading = true
        
        toggleFavoriteStatusUC.execute(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            },
            receiveValue: { [weak self] success in
                if success {
                    let movie = self?.moviesListPublish.first { movie in
                        movie.id == id
                    }
    
                    let currentStatus = movie!.isFavorite
                    self?.moviesListPublish = (self?.moviesListPublish.map({ movie in
                        if movie.id == id {
                            return movie.copyWith(isFavorite: !movie.isFavorite)
                        }
                        return movie
                    }))!
                }
                
                self?.isLoading = false
            })
            .store(in: &cancelables)
        
    }
    
    private func refreshMovies() {
        if isLoading { return }
        isLoading = true
        page = 1
        
        getMoviesUC.execute(query: lastQuery, page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            },
            receiveValue: { [weak self] response in
                
                self?.moviesListPublish = response
                
                if !response.isEmpty {
                    self?.page += 1
                    self?.isEndOfResults = false
                } else {
                    self?.isEndOfResults = true
                }
                
                self?.isLoading = false
            })
            .store(in: &cancelables)
    }
}
