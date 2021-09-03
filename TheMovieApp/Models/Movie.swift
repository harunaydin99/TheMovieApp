//
//  Movie.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 2.08.2021.
//

import Foundation
struct Movie: Codable, Equatable {
    
    let posterPath: String?
    let releaseDate: String?
    let overview: String?
    let title: String?
    let voteAverage: Double?
    let originalTitle: String?
    var isFavorite: Bool?
    let originalLanguage: String?
    // let popularity: Double?
    let voteCount: Int?
    let genreIds: [Int]?
    let id: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case overview, title, isFavorite, voteCount, id
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case genreIds = "genre_ids"
    }
    
}
