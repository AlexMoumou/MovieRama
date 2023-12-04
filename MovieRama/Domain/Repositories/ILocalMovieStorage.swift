//
//  ILocalMovieStorage.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import Foundation

protocol ILocalMovieStorage {
    func saveToFavorites(movieID: Int)
    func deleteFromFavorites(movieID: Int)
    func getFavoriteMovieIDs() -> [Int]
}
