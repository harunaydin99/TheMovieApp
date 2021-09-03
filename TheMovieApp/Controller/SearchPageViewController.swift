//
//  SearchPageViewController.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 8.08.2021.
//

import UIKit

class SearchPageViewController: UIViewController {

    var searchSelectedIndex = 0
    var searchMovieCallIndex = 1
    let d = UserDefaults.standard
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.dataSource = self
            searchTableView.delegate = self
            let nib = UINib(nibName: "MovieCell", bundle: nil)
            searchTableView.register(nib, forCellReuseIdentifier: "MovieCell")
        }
    }
    
    private var searchedMovies: [Movie] = [] {
        didSet {
            searchTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // print(vc.getMovies())
        searchBar.autocapitalizationType = .none
        
        self.searchBar.delegate = self
        // getSearchedMoviesToList(movieName: "recep")
    }
    override func viewWillAppear(_ animated: Bool) {
        searchTableView.reloadData()
        searchTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }

    
    func getSearchedMoviesToList(movieName: String) {

        SearchNetwork.sharedSearch.getSearchedMovies(movieName: movieName) { [weak self] response in
            DispatchQueue.main.async {
                switch response {
                case .success(let result):
                    if let results = result.results {
                        self?.searchedMovies = results
                        self?.searchTableView.reloadData()
                        // print(self?.searchedMovies)
                    }
                case .failure(let error):
                   print(error)
                }
            }
       }

    }
    

}

extension SearchPageViewController: UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate, MovieCellDelegate {
    func addFav(cell: MovieCell) {
        if let indexpathTapped = searchTableView.indexPath(for: cell) {
           // movies[indexpathTapped][1].isFavorite = true
            // movies[indexpathTapped[1]].isFavorite = true
           // addMovieToFav(movie: searchedMovies[indexpathTapped[1]])
            FavoriteManager().addMovieToFav(movie: searchedMovies[indexpathTapped[1]])
            
        }
    }
    
    func removeFav(cell: MovieCell) {
        if let indexpathTapped = searchTableView.indexPath(for: cell) {
           // movies[indexpathTapped][1].isFavorite = true
            // let movie = movies[indexpathTapped[1]]
             
           // movies[indexpathTapped[1]].isFavorite = nil
           // deleteFavMovie(movie: searchedMovies[indexpathTapped[1]])
            FavoriteManager().deleteFavMovie(movie: searchedMovies[indexpathTapped[1]])
        }
    }
    
    func reloadData() {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        var m = searchedMovies[indexPath.row]
        if FavoriteManager().getFavMovies().contains(searchedMovies[indexPath.row]) {
            // print("bakburadavar")
           // movies[indexPath.row].isFavorite = true
            m.isFavorite = true
         } else {
            // print("bakburadadayok")
           // movies[indexPath.row].isFavorite = false
            m.isFavorite = false
        }
        // print(movies.count)
        cell.delegate = self
        // if movies.count > 0 {
        cell.updateCell(movie: m)
        // }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchSelectedIndex = indexPath.row
        performSegue(withIdentifier: "searchToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToDetail" {
            let destVC = segue.destination as! DetailPageViewController
           // destVC.searchLink = self
            // destVC.titletwo = "lklkklkllklklk"
            destVC.selectedMovie = searchedMovies[searchSelectedIndex]
            destVC.selectedMovieId = searchedMovies[searchSelectedIndex].id
            destVC.modalPresentationStyle = .fullScreen  // full screen modal
        }
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // print(searchText)
        if searchText.count != 0 {
            getSearchedMoviesToList(movieName: searchText)
        } else {
            searchedMovies = []
        }
        searchTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    
}

/*  func addFavFromCell(cell: MovieCell) {
      // print(cell.movieNameLabel.text)
     // print("kllkklklkkl")
     /* if let indexpathTapped = searchTableView.indexPath(for: cell) {
         // movies[indexpathTapped][1].isFavorite = true
          // movies[indexpathTapped[1]].isFavorite = true
          addMovieToFav(movie: searchedMovies[indexpathTapped[1]])
          
      }*/
      
  }
  func removeFavFromCell(cell: MovieCell) {
      // print(cell.movieNameLabel.text)
     // print("kllkklklkkl")
      /*if let indexpathTapped = searchTableView.indexPath(for: cell) {
         // movies[indexpathTapped][1].isFavorite = true
          // let movie = movies[indexpathTapped[1]]
           
         // movies[indexpathTapped[1]].isFavorite = nil
          deleteFavMovie(movie: searchedMovies[indexpathTapped[1]])
          // movies[indexpathTapped[1]].isFavorite = false
          
          // addMovieToFav(movie: movies[indexpathTapped[1]])
      }*/
      
  }*/
