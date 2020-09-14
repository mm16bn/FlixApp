//
//  MovieDetailedViewController.swift
//  Flix App
//
//  Created by Melissa on 9/13/20.
//  Copyright © 2020 Melissa Ma. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailedViewController: UIViewController {
    
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]! //dictionary valued by strings

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()  // after send text, grow label until it fits everything
        synopsisLabel.text = movie["overview"] as? String
        
        // Find path to image
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        // URL validates it was correctly formed
        let posterURL = URL(string:baseUrl + posterPath)!
        posterView.af_setImage(withURL: posterURL) // downloads image
        
        // Find path to image
        let backdropUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        // URL validates it was correctly formed
        let backdropURL = URL(string:backdropUrl + backdropPath)!
        backdropView.af_setImage(withURL: backdropURL) // downloads image
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
