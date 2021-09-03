//
//  SearchNetwork.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 8.08.2021.
//

import Foundation

class SearchNetwork {
    
    static let sharedSearch = SearchNetwork()

    func getSearchedMovies(movieName: String,completion: @escaping (Result<MovieResult, Error>) -> Void) {
        
        let encoded = movieName.stringByAddingPercentEncodingForRFC3986()
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=75b6396416614e1d87f4618ec6300a76&language=en-US&query=\(encoded!)&page=1&include_adult=false")!)
        if String(Locale.preferredLanguages[0].prefix(2)) == "tr" {
            request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=75b6396416614e1d87f4618ec6300a76&language=tr&query=\(encoded!)&page=1&include_adult=false")!)
        }
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
                    completion(.failure(RMErrorr.customError))
                }
            }
        }
        dataTask.resume()
    }
}



enum RMErrorr: Error {
    case customError
}

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
}
