//
//  CastViewController.swift
//  TheMovieApp
//
//  Created by Harun AYDIN on 31.08.2021.
//

import UIKit
import Kingfisher

class CastViewController: UIViewController {

   
    @IBOutlet weak var castTableView: UITableView! {
            didSet {
                castTableView.dataSource = self
                castTableView.delegate = self
                let nib = UINib(nibName: "CastTableViewCell", bundle: nil)
                castTableView.register(nib, forCellReuseIdentifier: "CastCell")
            }
        
    }
    var castCellIndex = 0
   // var casts: [Cast] = []
    var casts: [Cast] = [] {
        didSet {
           // castTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castTableView.reloadData()
       // print("castlar")
       // print(casts)
       // self.castTableView.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        castTableView.reloadData()
        
    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CastViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as! CastTableViewCell
        
        cell.castNameLabel.text = casts[indexPath.row].name
        if let path = casts[indexPath.row].profilePath {
            let tempString = Constants.basicImageUrl + path
            // movieImageView.loadURL(urlString: tempString)
            cell.castImageView.image = UIImage(named: "placeholder")
            let url = URL(string: tempString)
            cell.castImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            cell.castImageView.image = UIImage(named: "placeholder")
        }
        castCellIndex += 1
       // castTableView.reloadData()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        castCellIndex = indexPath.row
        performSegue(withIdentifier: "castToCastDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "castToCastDetail" {
            let destVC = segue.destination as! CastDetailViewController
           // destVC.favLink = self
            // destVC.titletwo = "lklkklkllklklk"
            destVC.currentCast = casts[castCellIndex]
            destVC.modalPresentationStyle = .fullScreen  // full screen modal
        }
    }
}
