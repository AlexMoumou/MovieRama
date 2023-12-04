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

struct ReviewDTO: Decodable, Identifiable, Equatable {
    let id: String
    let content: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case author
    }
}

extension ReviewDTO {
    static func example() -> ReviewDTO {
        return ReviewDTO(id: "123", content: "In my top 5 of all time favourite movies. Great story line and a movie you can watch over and over again.", author: "Brett Pascoe")
    }
    
    func copyWith(
        id: String? = nil,
        content: String? = nil,
        author: String? = nil
    ) -> ReviewDTO {
        return ReviewDTO(id: id ?? self.id,
                     content: content ?? self.content,
                     author: author ?? self.author
        )
    }
}
