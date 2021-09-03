//
//  PopularMovieNetwork.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 2.08.2021.
//

import Foundation

class PopularMovieNetwork {
    
    static let shared = PopularMovieNetwork()
    
    func getPopularMovies(id: Int,completion: @escaping (Result<MovieResult, Error>) -> Void) {
        var tempUrl = NetworkConstants.getPopularMoviesURL
        if String(Locale.preferredLanguages[0].prefix(2)) == "tr" {
            tempUrl = NetworkConstants.trGetPopularMoviesUrl
        }
       // var request = URLRequest(url: URL(string: NetworkConstants.getPopularMoviesURL+"\(id)")!)
        var request = URLRequest(url: URL(string: tempUrl+"\(id)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MovieResult.self, from: data)
                    completion(.success(result))
                    // print(result)
                } catch (let error) {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(RMError.customError))
                }
            }
        }
        dataTask.resume()
        
    }
}

enum RMError: Error {
    case customError
}
