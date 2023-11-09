//
//  ViewController.swift
//  MovieSearchingApp
//
//  Created by C on 8.11.2023.
//

import UIKit
import Kingfisher

class ViewController: UITableViewController, UISearchBarDelegate, MovieSummaryViewModelOutput {
    private let viewModel = MovieSummaryViewModel()
    private let movieDetailService: MovieDetailService
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.black
        tableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 10, right: 0)
    }
    
    init(movieDetailService: MovieDetailService = APIManager()) {
        self.movieDetailService = movieDetailService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Please enter a movie"
        searchBar.backgroundColor = .white
        searchBar.barTintColor = .lightGray
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        
        navigationItem.titleView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        viewModel.fetchMovies(searchText: searchText)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfMovies = viewModel.numberOfMovies()
        if numberOfMovies == 0 {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "No movie found"
            messageLabel.textColor = UIColor.red
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel
        } else {
            tableView.backgroundView = nil
        }
        return numberOfMovies
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movie = viewModel.movieAtIndex(indexPath.row)
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = "\(movie.Title) (\(movie.Year))"
        cell.textLabel?.numberOfLines = 0
        
        if let url = URL(string: movie.Poster) {
            cell.imageView?.kf.indicatorType = .activity
            cell.imageView?.kf.setImage(with: url)
            cell.imageView?.contentMode = .scaleAspectFit
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieSummary = viewModel.movieAtIndex(indexPath.row)
        movieDetailService.fetchMovieDetail(imdbID: movieSummary.imdbID) { movieDetail in
            if let movieDetail = movieDetail {
                DispatchQueue.main.async {
                    let detailViewController = MovieDetailViewController(movieDetail: movieDetail)
                    
                    let backItem = UIBarButtonItem()
                    backItem.title = ""
                    backItem.tintColor = .white
                    self.navigationItem.backBarButtonItem = backItem
                    
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                }
            }
        }
    }
    
    
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.viewModel.numberOfMovies() == 0 {
                let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                messageLabel.text = "No movie found"
                messageLabel.textColor = UIColor.red
                messageLabel.numberOfLines = 0
                messageLabel.textAlignment = .center
                messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
                messageLabel.sizeToFit()
                self.tableView.backgroundView = messageLabel
            } else {
                self.tableView.backgroundView = nil
            }
        }
    }
}
