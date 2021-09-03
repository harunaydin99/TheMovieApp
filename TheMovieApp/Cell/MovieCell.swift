//
//  MovieCell.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 2.08.2021.
//

import UIKit
import Kingfisher
protocol MovieCellDelegate: AnyObject {
    func addFav(cell: MovieCell)
   // func addFav(movie: Movie)
    func removeFav(cell: MovieCell)
    func reloadData()
}

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieVoteLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    weak var delegate: MovieCellDelegate?
    var selectedCellMovie: Movie?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImageView.layer.cornerRadius = 10
        self.selectionStyle = .none
       // print("cell movieleri")
       // print(cellMovies)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
           // print("superview is not a UITableView - getIndexPath")
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }
    
    @IBAction func fovoritePressed(_ sender: UIButton) {

        if let movie = self.selectedCellMovie {
            if FavoriteManager().checkIsFavorite(movie: movie) {
                sender.setImage(UIImage(named: "heart"), for: .normal)
                delegate?.removeFav(cell: self)
                delegate?.reloadData()
            } else {
                sender.setImage(UIImage(named: "heart.fill"), for: .normal)
                delegate?.addFav(cell: self)
            }
        }
       // print(self.selectedCellMovie)
        
        
        
        
      /*  if (((sender.currentImage?.isEqual((UIImage(named: "heart"))))) == true) {
            sender.setImage(UIImage(named: "heart.fill"), for: .normal)
            delegate?.addFav(cell: self)
        } else {
            sender.setImage(UIImage(named: "heart"), for: .normal)
            delegate?.removeFav(cell: self)
            delegate?.reloadData()
        }*/
        
    }
    
    
    
    override func prepareForReuse() {
        // CELLS STILL FREEZE EVEN WHEN THE FOLLOWING LINE IS COMMENTED OUT?!?!
        // print("klkllkklaklklaklklaklklaklklklaklklalk")
        
        super.prepareForReuse()
        movieImageView.image = UIImage(named: "placeholder")
         
    }
    
    
   // func updateCell(with movie: Movie) {
    func updateCell(movie: Movie) {
        // let tempUrl = "https://image.tmdb.org/t/p/original"
        
       // print(movie)
        selectedCellMovie = movie
       // print("cell movielieri")
       // print(selectedCellMovie)
       // movie.isFavorite = true
        if movie.isFavorite == true {
           // favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favButton.setImage(UIImage(named: "heart.fill"), for: .normal)
            favButton.tintColor = .red
        } else {
            favButton.setImage(UIImage(named: "heart"), for: .normal)
            favButton.tintColor = .red
        }
        
        
       // movieNameLabel.text = movie.originalTitle
        movieNameLabel.text = movie.title
        if let path = movie.posterPath {
            let tempString = Constants.basicImageUrl + path
            // movieImageView.loadURL(urlString: tempString)
            movieImageView.image = UIImage(named: "placeholder")
            let url = URL(string: tempString)
            movieImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            movieImageView.image = UIImage(named: "placeholder")
        }
        if let vote = movie.voteAverage {
            movieVoteLabel.text = "Vote : " + String(format: "%.1f", vote)
        } else {
            movieVoteLabel.text = "Vote : -"
        }
    }
    
    
    
}
