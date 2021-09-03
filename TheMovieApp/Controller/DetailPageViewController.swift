//
//  DetailPageViewController.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 5.08.2021.
//

import UIKit
import Kingfisher

class DetailPageViewController: UIViewController {

    let d = UserDefaults.standard
    var selectedMovie: Movie?
    var selectedMovieId: Int?
    var titletwo: String?
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
   /* var link: ViewController?
    var favLink: FavoriteViewController?
    var searchLink: SearchPageViewController?*/
    private var genres: [Genre] = []
    private var casts: [Cast] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.layer.cornerRadius = 50
       // getGenres()
        if let id = selectedMovieId {
            getCasts(id: id)
            getMovieDetails(id: id)
        }
    }
    @IBAction func castButton(_ sender: Any) {
        performSegue(withIdentifier: "detailToCast", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToCast" {
            let destVC = segue.destination as! CastViewController
           // destVC.link = self
            destVC.modalPresentationStyle = .fullScreen  // full screen modal
           // print(self.casts)
            destVC.casts = self.casts
        }
    }
    
    func getCasts(id: Int) {
        if let id = selectedMovieId {
            CastNetwork.shared.getCasts(id: id) {  response in
                DispatchQueue.main.async {
                    switch response {
                    case .success(let result):
                        if let results = result.cast {
                           // print(results)
                            self.casts = results
                           // print(results.count)
                         }
                    case .failure(let error):
                       print(error)
                    }
                }
           }
        }

    }
    
    func getMovieDetails(id: Int) {
        if let id = selectedMovieId {
            DetailNetwork.shared.getDetails(id: id) {  response in
                DispatchQueue.main.async {
                    switch response {
                    case .success(let result):
                       /* if let results = result {
                            print(results.genres)
                         }*/
                        if result != nil {
                           // print(result)
                            self.showDetails(result: result)
                        }
                    case .failure(let error):
                       print(error)
                    }
                }
           }
        }

    }
    func showDetails(result: Detail) {
       // print(casts)
        titleLabel.text = result.title
        releaseDateLabel.text = result.releaseDate
        overViewLabel.text = result.overView
        if let vote = result.voteAverage {
            voteAverageLabel.text = String(format: "%.1f", vote) + "/10"
        }
        if let tempString = result.posterPath {
             let urlString = Constants.basicImageUrl + tempString
             // movieImageView.loadURL(urlString: tempString)
             let url = URL(string: urlString)
             detailImageView.kf.setImage(with: url)
        }
        if let genres = result.genres {
            showGenres(fGenres: genres)
        }
        
    }
    
    func showGenres(fGenres: [Genre]) {
        for genre in fGenres {
            if let name = genre.name {
                genreLabel.text = genreLabel.text?.appending("-" + name + "\n")
            }
        }
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func favButtonPressed(_ sender: Any) {
        if let movie = selectedMovie {
            if FavoriteManager().getFavMovies().contains(movie) {
                favButton.setImage(UIImage(named: "heart"), for: .normal)
                FavoriteManager().deleteFavMovie(movie: movie)
            } else {
                favButton.setImage(UIImage(named: "heart.fill"), for: .normal)
                FavoriteManager().addMovieToFav(movie: movie)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if let movie = selectedMovie {
            if FavoriteManager().getFavMovies().contains(movie) {
                favButton.setImage(UIImage(named: "heart.fill"), for: .normal)
                favButton.tintColor = .red
            } else {
                favButton.setImage(UIImage(named: "heart"), for: .normal)
                favButton.tintColor = .red
            }
        }
    }
    
}

/* func getGenres() {
     GenreNetwork.shared.getGenres { [weak self] response in
         DispatchQueue.main.async {
             switch response {
             case .success(let result):
                 if let results = result.genres {
                    // print(results)
                     self?.genres = results
                    // print(self?.genres[0])
                   //  self!.takeGenres(fGenres: self!.genres)
                 }
             case .failure(let error):
                print(error)
             }
         }
    }
 }*/
