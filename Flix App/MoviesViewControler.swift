//
//  MoviesViewControler.swift
//  Flix App
//
//  Created by Melissa on 9/1/20.
//  Copyright © 2020 Melissa Ma. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewControler: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]()   // a list of dictionaries; dictionary has one []

    // gets called once at beginning
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // REQUIRED
        tableView.delegate = self;
        tableView.dataSource = self;

        // API: Network Request Snippet
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!   // API call, only change
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
//                print(dataDictionary["results"])
                
                // TODO: Get the array of movies
                self.movies = dataDictionary["results"] as! [[String:Any]]
                // TODO: Store the movies in a property to use elsewhere
                
                // TODO: Reload your table view data
                self.tableView.reloadData()
                
            }
        }
        task.resume()
        
    }
    
    // determines number of rows TableView is going to have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    // determines what info is being put in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]   // accessing each movie from API call
        let titles = movie["title"] as! String
        let synopsis = movie["overview"] as! String
    
        cell.titleLabel!.text = titles
        cell.synopsisLabel!.text = synopsis

        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        // URL validates it was correctly formed
        let posterURL = URL(string:baseUrl + posterPath)
        cell.posterView.af.setImage(withURL: posterURL!) // downloads image
        return cell
    }
    


     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    // sender is cell that is tapped on
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
        print("Loading up detail screen")
        
        // Find selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
    
        // Pass selected movie to MovieDetailsViewController
        // store movie into controller
        let detailsViewController = segue.destination as! MovieDetailedViewController   //cast it to give you the movie property
        detailsViewController.movie = movie
        tableView.deselectRow(at:indexPath, animated: true) // highlight selection briefly, then not anymore
    }

}
