//
//  GenreNetwork.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 17.08.2021.
//

import Foundation

class GenreNetwork {
    
    static let shared = GenreNetwork()
    
    func getGenres(completion: @escaping (Result<GenreResult, Error>) -> Void) {
        
        var tempUrl = NetworkConstants.genreNetworkUrl
        if String(Locale.preferredLanguages[0].prefix(2)) == "tr" {
            tempUrl = NetworkConstants.trGenreNetworkUrl
        }
       // var request = URLRequest(url: URL(string: NetworkConstants.genreNetworkUrl)!)
        var request = URLRequest(url: URL(string: tempUrl)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(GenreResult.self, from: data)
                   // print(result)
                    completion(.success(result))
                } catch (let error) {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(GenreError.customError))
                }
            }
        }
        dataTask.resume()
    }
}

enum GenreError: Error {
    case customError
}
