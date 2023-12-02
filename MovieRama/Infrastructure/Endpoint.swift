//
//  Endpoint.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import Foundation

protocol Endpoint {
    var url: URL { get }
}

private let baseURL = Environment.baseUrl
private let apiKey = Environment.apikey

/// API Endpoints
enum TMDBApiEndpoint: Endpoint {
    
    case popularMovies(Int)
    case searchMovies(Int, String)
    case movieReviews(Int, Int)
    case similarMovies(Int, Int)
    case movie(Int)

    var url: URL {
        switch self {
            case .popularMovies(let page): return URL(string: "/3/movie/popular?api_key=\(apiKey)&page=\(page)", relativeTo: baseURL)!
            case .searchMovies(let page, let query): return URL(string: "/3/search/movie?api_key=\(apiKey)&page=\(page)&query=\(query)", relativeTo: baseURL)!
            case .movieReviews(let page, let movieID): return URL(string: "/3/movie/\(movieID)/reviews?api_key=\(apiKey)&page=\(page)", relativeTo: baseURL)!
            case .similarMovies(let page, let movieID): return URL(string: "/3/movie/\(movieID)/similar?api_key=\(apiKey)&page=\(page)", relativeTo: baseURL)!
            case .movie(let movieID): return URL(string: "/3/movie/\(movieID)?api_key=\(apiKey)&append_to_response=credits", relativeTo: baseURL)!
        }
    }
}
