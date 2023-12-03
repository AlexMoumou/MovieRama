//
//  MovieDetailsViewModel.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Foundation
import Combine

protocol IMovieDetailsViewModel: ObservableObject {
    func send(action: MovieDetailsViewModelAction)
    
    var callback: (@MainActor (MovieDetailsViewModelResult) -> Void)? { get set }
}

enum MovieDetailsViewModelResult {
    case goBack
}

enum MovieDetailsViewModelAction {
    case load
    case goBack
}

class MovieDetailsViewModel: IMovieDetailsViewModel {
    
    @Published var isLoading: Bool = false
    @Published var movieData: MovieFull? = nil
    
    private var cancelables = [AnyCancellable]()
    var callback: (@MainActor (MovieDetailsViewModelResult) -> Void)?
    
    private let getMovieUC: IGetMovieUC
    private let movieId: Int
    
    
    init(getMovieUC: IGetMovieUC, movieId: Int) {
        self.getMovieUC = getMovieUC
        self.movieId = movieId
        
        loadFullMovie()
    }
    
    func send(action: MovieDetailsViewModelAction) {
        switch action {
        case.load:
            loadFullMovie()
        case .goBack:
            Task { await callback?(.goBack) }
        }
    }
    
    func loadFullMovie() {
        if isLoading { return }
        isLoading = true
        
        getMovieUC.execute(id: movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
                self.isLoading = false
            },
            receiveValue: { [weak self] response in
                self?.movieData = response
                self?.isLoading = false
            })
            .store(in: &cancelables)
    }
    
}
