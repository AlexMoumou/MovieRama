//
//  Movie.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import Foundation

public struct Movie: Equatable {
    
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let voteAverage: Double?
    public let isFavorite: Bool
    
    // MARK: - Initializers
    
    public init(id: Int, title: String, posterPath: String?, backdropPath: String?,
                releaseDate: String?, voteAverage: Double?, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.isFavorite = isFavorite
    }
    
}

extension Movie {
    static func example() -> Movie {
        return Movie(id: 550, 
                     title: "Fight Club",
                     posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
                     backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg",
                     releaseDate: "1999-10-15",
                     voteAverage: 8.44)
    }
    
    func copyWith(
        id: Int? = nil,
        title: String? = nil,
        posterPath: String? = nil,
        backdropPath: String? = nil,
        releaseDate: String? = nil,
        voteAverage: Double? = nil,
        isFavorite: Bool? = nil
    ) -> Movie {
        return Movie(id: id ?? self.id,
                     title: title ?? self.title,
                     posterPath: posterPath ?? self.posterPath,
                     backdropPath: backdropPath ?? self.backdropPath,
                     releaseDate: releaseDate ?? self.releaseDate,
                     voteAverage: voteAverage ?? self.voteAverage,
                     isFavorite: isFavorite ?? self.isFavorite
        )
    }
}
