//
//  MovieDTO.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import Foundation

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster: String?
    let backdrop: String?
    let voteAverage: Double
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster = "poster_path"
        case backdrop = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}


extension MovieDTO {
    func mapToDomain() -> Movie {
        Movie(id: id, title: title, overview: overview, posterPath: poster, backdropPath: backdrop, releaseDate: releaseDate, voteAverage: voteAverage)
    }
}
