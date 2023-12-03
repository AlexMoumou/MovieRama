//
//  AppDIContainer.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import Foundation

// Simple Dependency Injection, this can obviously be done better
// with a package like Resolver or Swinject
final class AppDIContainer {
    
    public static let shared = AppDIContainer()
    
    // MARK: - HTTP Client
    
    // I use URLSession so i can minimize dependencies for this assignment but someone could write an extension to
    // APIProvider protocol for AFNetwork, Alamofire or any other network package and apply it here.
    lazy var client: RestClient = RestClient(session: URLSession(configuration: URLSessionConfiguration.default))
    
    lazy var moviesRepo: IMoviesRepository = MoviesRepository(restClient: client)
    
    // MARK: - Use Cases
    
    func makeGetMoviesUseCase() -> IGetMoviesUC {
        return GetMoviesUC(moviesRepo: moviesRepo)
    }
    
    func makeGetMovieUseCase() -> IGetMovieUC {
        return GetMovieUC(moviesRepo: moviesRepo)
    }
    
    // MARK: - Repositories
    
    // MARK: - ViewModels
    
    func makeMoviesViewModel() -> any IMoviesViewModel {
        return MoviesViewModel(getMoviesUC: makeGetMoviesUseCase())
    }
    
    func makeMovieDetailsViewModel(movieId: Int) -> any IMovieDetailsViewModel {
        return MovieDetailsViewModel(getMovieUC: makeGetMovieUseCase(), movieId: movieId)
    }
    
    // MARK: - SwiftUIViews
    func makeMovieDetailsView(vm: any IMovieDetailsViewModel) -> MovieDetailsView {
        return MovieDetailsView(vm: vm as! MovieDetailsViewModel)
    }
    
}
