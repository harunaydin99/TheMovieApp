//
//  Detail.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 25.08.2021.
//

import Foundation
struct Detail: Codable {
    
    let budget: Int?
    let overView: String?
    let releaseDate: String?
    let title: String?
    let genres: [Genre]?
    let voteAverage: Double?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case budget, title, genres
        case releaseDate = "release_date"
        case overView = "overview"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
