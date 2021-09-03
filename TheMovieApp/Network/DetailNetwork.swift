//
//  DetailNetwork.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 25.08.2021.
//

import Foundation
class DetailNetwork {
    
    static let shared = DetailNetwork()
    
    func getDetails(id: Int,completion: @escaping (Result<Detail, Error>) -> Void) {
        var tempUrl = "https://api.themoviedb.org/3/movie/\(id)?api_key=75b6396416614e1d87f4618ec6300a76&language=en-US"
        if String(Locale.preferredLanguages[0].prefix(2)) == "tr" {
            tempUrl = "https://api.themoviedb.org/3/movie/\(id)?api_key=75b6396416614e1d87f4618ec6300a76&language=tr"
        }
       // var request = URLRequest(url: URL(string: NetworkConstants.getPopularMoviesURL+"\(id)")!)
        var request = URLRequest(url: URL(string: tempUrl)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Detail.self, from: data)
                    completion(.success(result))
                   // print(result)
                } catch (let error) {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(DetailError.customError))
                }
            }
        }
        dataTask.resume()
        
    }
}

enum DetailError: Error {
    case customError
}
