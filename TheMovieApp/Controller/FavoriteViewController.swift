//
//  FavoriteViewController.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 11.08.2021.
//

import UIKit

class FavoriteViewController: UIViewController {

    let d = UserDefaults.standard
    var favSelectedIndex = 0
    
    @IBOutlet weak var favTableView: UITableView! {
        didSet {
            favTableView.dataSource = self
            favTableView.delegate = self
            let nib = UINib(nibName: "MovieCell", bundle: nil)
            favTableView.register(nib, forCellReuseIdentifier: "MovieCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        favTableView.reloadData()
        favTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    

}

extension FavoriteViewController: UITableViewDataSource,UITableViewDelegate, MovieCellDelegate {
    func addFav(cell: MovieCell) {
       // print("favorite delegate uleynnn")
        
    }
    
    func removeFav(cell: MovieCell) {
        if let indexpathTapped = favTableView.indexPath(for: cell) {
           // movies[indexpathTapped][1].isFavorite = true
            // let movie = movies[indexpathTapped[1]]
             
           // movies[indexpathTapped[1]].isFavorite = nil
           // deleteFavMovie(movie: getFavMovies()[indexpathTapped[1]])
            FavoriteManager().deleteFavMovie(movie: FavoriteManager().getFavMovies()[indexpathTapped[1]])
        }
        
       // print("fav remove delegate")
    }
    
    func reloadData() {
        favTableView.reloadData()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteManager().getFavMovies().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
       // cell.favLink = self  // fav delegation
        
        var m = FavoriteManager().getFavMovies()[indexPath.row]
        m.isFavorite = true
        
       // cell.updateCell(with: getFavMovies()[indexPath.row])
        cell.updateCell(movie: m)
        
        cell.delegate = self // delegation
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favSelectedIndex = indexPath.row
        performSegue(withIdentifier: "favToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favToDetail" {
            let destVC = segue.destination as! DetailPageViewController
           // destVC.favLink = self
            // destVC.titletwo = "lklkklkllklklk"
            destVC.selectedMovie = FavoriteManager().getFavMovies()[favSelectedIndex]
            destVC.selectedMovieId = FavoriteManager().getFavMovies()[favSelectedIndex].id
            destVC.modalPresentationStyle = .fullScreen  // full screen modal
        }
    }
    
   
    
    
}
