//
//  NetworkConstants.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 2.08.2021.
//

import Foundation

struct NetworkConstants {
    static let getPopularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=75b6396416614e1d87f4618ec6300a76&language=en-US&page="
    static let trGetPopularMoviesUrl = "https://api.themoviedb.org/3/movie/popular?api_key=75b6396416614e1d87f4618ec6300a76&language=tr&page="
    static let getSearchedMoviesURL = "https://api.themoviedb.org/3/search/movie?api_key=75b6396416614e1d87f4618ec6300a76&language=en-US&query=&page=1&include_adult=false"
    static let trGetSearchedMoviesURL = "https://api.themoviedb.org/3/search/movie?api_key=75b6396416614e1d87f4618ec6300a76&language=tr&query=&page=1&include_adult=false"
    static let genreNetworkUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=75b6396416614e1d87f4618ec6300a76&language=en-US"
    static let trGenreNetworkUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=75b6396416614e1d87f4618ec6300a76&language=tr"
    
}
