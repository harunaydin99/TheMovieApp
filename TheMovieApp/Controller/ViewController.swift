//
//  ViewController.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 2.08.2021.
//

import UIKit

// class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
class ViewController: UIViewController {
    
    var d = UserDefaults.standard
    var selectedIndex: Int = 0
    var movieCallIndex = 1
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            let nib = UINib(nibName: "MovieCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "MovieCell")
        }
    }
    
    private var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
       /* let favMovies = [Movie]()
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(favMovies)

            // Write/Set Data
            d.set(data, forKey: "favMovies")

        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }*/
      //  clearFavMovies()
        print(FavoriteManager().getFavMovies())
        
        getMoviesToList()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func getMoviesToList() {
        PopularMovieNetwork.shared.getPopularMovies(id: movieCallIndex) { [weak self] response in
            DispatchQueue.main.async {
                switch response {
                case .success(let result):
                    if let results = result.results {
                        if (self?.movies.count)! > 0 {
                            // self?.movies = self?.movies + results
                            self?.movies = self!.movies + results
                        } else {
                            self?.movies = results
                        }
                        self?.movieCallIndex = self!.movieCallIndex + 1
                        
                        // print(self?.movies)
                        self!.tableView.reloadData()
                    }
                case .failure(let error):
                   print(error)
                }
            }
       }

    }
    
}
extension ViewController: UITableViewDataSource,UITableViewDelegate, MovieCellDelegate {
    
    func addFav(cell: MovieCell) {
        if let indexpathTapped = tableView.indexPath(for: cell) {
           // addMovieToFav(movie: movies[indexpathTapped[1]])
           // addMovieToFav(movie: movies[indexpathTapped.row])
            FavoriteManager().addMovieToFav(movie: movies[indexpathTapped.row])
            
        }
    }
   /* func addFav(movie: Movie) {
         if let indexpathTapped = tableView.indexPath(for: cell) {
            // addMovieToFav(movie: movies[indexpathTapped[1]])
            // addMovieToFav(movie: movies[indexpathTapped.row])
             FavoriteManager().addMovieToFav(movie: movies[indexpathTapped.row])
             
         }
     }*/
    
    func removeFav(cell: MovieCell) {
        if let indexpathTapped = tableView.indexPath(for: cell) {
           // deleteFavMovie(movie: movies[indexpathTapped.row])
            FavoriteManager().deleteFavMovie(movie: movies[indexpathTapped.row])
         }
       // print("home page delegate")
    }
    
    func reloadData() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print(movies.count)
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        var m = movies[indexPath.row]
       // print(movies[indexPath.row])
      /*  for movie in FavoriteManager().getFavMovies() {
            if movie.id == movies[indexPath.row].id {
                m.isFavorite = true
               // movies[indexPath.row].isFavorite = true
                break
            } else {
                m.isFavorite = false
               // movies[indexPath.row].isFavorite = false
            }
        }*/
        if FavoriteManager().checkIsFavorite(movie: movies[indexPath.row]) {
            m.isFavorite = true
        } else {
            m.isFavorite = false
        }
       /* if FavoriteManager().getFavMovies().contains(movies[indexPath.row]) {
           // movies[indexPath.row].isFavorite = true
            m.isFavorite = true
         } else {
           // movies[indexPath.row].isFavorite = false
            m.isFavorite = false
        }*/
       // movies[indexPath.row] = m
       // print(movies[indexPath.row])
           // cell.updateCell(with: movies[indexPath.row])
       // movies[indexPath.row] = m
        cell.updateCell(movie: m)
       // cell.updateCell(movie: movies[indexPath.row])
        // }
        cell.delegate = self // delegation
        return cell
    }
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            self.tableView.tableFooterView = self.createSpinnerFooter()
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) {(t) in
                self.getMoviesToList()
            }
         
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "popularToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popularToDetail" {
            let destVC = segue.destination as! DetailPageViewController
           // destVC.link = self
            destVC.modalPresentationStyle = .fullScreen  // full screen modal
            destVC.selectedMovie = movies[selectedIndex]
            destVC.selectedMovieId = movies[selectedIndex].id
        }
    }
    
}


/* func addFavFromCell(cell: MovieCell) {
     /*if let indexpathTapped = tableView.indexPath(for: cell) {
        // addMovieToFav(movie: movies[indexpathTapped[1]])
         addMovieToFav(movie: movies[indexpathTapped.row])
         
     }*/
 }
 func removeFavFromCell(cell: MovieCell) {
    /* if let indexpathTapped = tableView.indexPath(for: cell) {
         deleteFavMovie(movie: movies[indexpathTapped[1]])
     }*/
 }*/
