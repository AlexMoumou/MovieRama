//
//  MoviesDTO.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import Foundation

struct MoviesDTO: Decodable {
    let items: [MovieDTO]
    
    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
