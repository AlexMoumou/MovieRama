//
//  MovieReviewsDTO.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Foundation

struct MovieReviewsDTO: Decodable {
    let id: Int
    let results: [ReviewDTO]
    
    enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}

struct ReviewDTO: Decodable, Identifiable {
    let id: String
    let content: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case author
    }
}
