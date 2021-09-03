//
//  CastTableViewCell.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 1.09.2021.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        castImageView.roundedImage()
       /* castImageView.layer.cornerRadius = 200
        castImageView.clipsToBounds = true
        castImageView.layer.borderWidth = 3.0
        castImageView.layer.borderColor = UIColor.white.cgColor*/
        // Initialization code
    }
    override func prepareForReuse() {
        // CELLS STILL FREEZE EVEN WHEN THE FOLLOWING LINE IS COMMENTED OUT?!?!
        // print("klkllkklaklklaklklaklklaklklklaklklalk")
        
        super.prepareForReuse()
        castImageView.image = UIImage(named: "placeholder")
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}
