//
//  Movie.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import Foundation

public struct Movie: Equatable, Identifiable {
    
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let voteAverage: Double?
    public let isFavorite: Bool
    
    // MARK: - Initializers
    
    public init(id: Int, title: String, overview: String, posterPath: String?, backdropPath: String?,
                releaseDate: String?, voteAverage: Double?, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.overview = overview
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
                     overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
                     posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
                     backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg",
                     releaseDate: "1999-10-15",
                     voteAverage: 8.44)
    }
    
    func copyWith(
        id: Int? = nil,
        title: String? = nil,
        overview: String? = nil,
        posterPath: String? = nil,
        backdropPath: String? = nil,
        releaseDate: String? = nil,
        voteAverage: Double? = nil,
        isFavorite: Bool? = nil
    ) -> Movie {
        return Movie(id: id ?? self.id,
                     title: title ?? self.title,
                     overview: overview ?? self.overview,
                     posterPath: posterPath ?? self.posterPath,
                     backdropPath: backdropPath ?? self.backdropPath,
                     releaseDate: releaseDate ?? self.releaseDate,
                     voteAverage: voteAverage ?? self.voteAverage,
                     isFavorite: isFavorite ?? self.isFavorite
        )
    }
}
