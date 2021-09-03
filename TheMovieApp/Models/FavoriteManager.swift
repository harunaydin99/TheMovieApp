//
//  FavoriteManager.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 26.08.2021.
//
// harun

import Foundation
struct FavoriteManager {
    
    var d = UserDefaults.standard
    func addMovieToFav(movie: Movie) {
        do {
            var favMovies = getFavMovies()
           // movie.isFavorite = true
            if checkIsFavorite(movie: movie) == false {
                favMovies.append(movie)
            }
            
           // print(favMovies)
            let encoder = JSONEncoder()
            let data = try encoder.encode(favMovies)
            d.set(data, forKey: "favMovies")

        } catch {
            print("Unable to Encode (\(error))")
        }
    }
    
    func checkIsFavorite(movie: Movie) -> Bool {
        for mov in FavoriteManager().getFavMovies() {
            if mov.id == movie.id {
                return true
               // movies[indexPath.row].isFavorite = true
               // break
            } else {
                continue
               // movies[indexPath.row].isFavorite = false
            }
        }
        return false
    }
    
    func getFavMovies() -> [Movie] {
        var notes = [Movie]()
        if let data = d.data(forKey: "favMovies") {
            do {

                let decoder = JSONDecoder()

                notes = try decoder.decode([Movie].self, from: data)
            } catch {
                print("Unable to Decode (\(error))")
            }
        }
        return notes
    }
    
    func deleteFavMovie(movie: Movie) {
        do {
            var favMovies = getFavMovies()
           // print(favMovies)
            if favMovies.contains(movie) {
            } else {
             //   print(movie)
            }
            
            if let index = favMovies.firstIndex(of: movie) {
                favMovies.remove(at: index)
            }
            let encoder = JSONEncoder()
            let data = try encoder.encode(favMovies)
            d.set(data, forKey: "favMovies")
           // print(getFavMovies())
        } catch {
            print("Unable to encode  (\(error))")
        }
    }
    
    func clearFavMovies() {
        do {
            var favMovies = getFavMovies()
            favMovies.removeAll()
            let encoder = JSONEncoder()
            let data = try encoder.encode(favMovies)
            d.set(data, forKey: "favMovies")
        } catch {
            print("Unable to encode  (\(error))")
        }
    }
}
