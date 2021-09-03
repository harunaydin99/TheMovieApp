//
//  CastDetailViewController.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 2.09.2021.
//

import UIKit
import Kingfisher

class CastDetailViewController: UIViewController {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    var currentCast: Cast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        castImageView.roundedImage()
        if let path = currentCast?.profilePath {
            let tempString = Constants.basicImageUrl + path
            // movieImageView.loadURL(urlString: tempString)
            castImageView.image = UIImage(named: "placeholder")
            let url = URL(string: tempString)
            castImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            castImageView.image = UIImage(named: "placeholder")
        }
        
        if let name = currentCast?.name {
            castNameLabel.text = "Name: " + name
        }
        
        if let gender = currentCast?.gender {
            if gender == 1 {
                genderLabel.text = "Gender: Woman"
            } else {
                genderLabel.text = "Gender: Man"
            }
        }
        
        if let character = currentCast?.character {
            characterLabel.text = "Character: " + character
        }
        if let dep = currentCast?.department {
            departmentLabel.text = "Department: " + dep
        }
       
        
        
        
    }
    
    
    

}
