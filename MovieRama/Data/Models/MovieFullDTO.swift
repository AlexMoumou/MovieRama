//
//  MovieFullDTO.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Foundation

struct MovieFullDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster: String?
    let backdrop: String?
    let voteAverage: Double
    let releaseDate: String?
    let genres: [GenreDTO]
    let credits: CreditsDTO
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case overview
        case poster = "poster_path"
        case backdrop = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case genres
        case credits
    }
}

extension MovieFullDTO {
    func mapToDomain() -> MovieFull {
        
        let director = credits.crew.first { member in
            member.job == "Director"
        }!.name
        
        let mainCast = credits.cast.map { $0.name }
        
        return MovieFull(id: id, title: title, overview: overview, posterPath: poster, backdropPath: backdrop, releaseDate: releaseDate, voteAverage: voteAverage, genreNames: genres.map{ $0.name }, mainCastNames: mainCast, director: director)
    }
}

struct GenreDTO: Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

struct CreditsDTO: Decodable {
    let cast: [CastDTO]
    let crew: [CrewDTO]
    
    enum CodingKeys: String, CodingKey {
        case cast
        case crew
    }
}

struct CastDTO: Decodable {
    let id: Int
    let name: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case order
    }
}

struct CrewDTO: Decodable {
    let id: Int
    let name: String
    let job: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case job
    }
}
