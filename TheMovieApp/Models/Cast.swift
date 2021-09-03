//
//  Cast.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 31.08.2021.
//

import Foundation
struct Cast: Codable {
    
    let name: String?
    let profilePath: String?
    let gender: Int?
    let character: String?
    let department: String?
    
    enum CodingKeys: String, CodingKey {
        case name, gender, character
        case profilePath = "profile_path"
        case department = "known_for_department"
    }
    
}
