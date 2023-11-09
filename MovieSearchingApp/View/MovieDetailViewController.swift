//
//  MovieDetailViewController.swift
//  MovieSearchingApp
//
//  Created by C on 9.11.2023.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // Not private for test
    let movieDetail: MovieDetail
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let yearLabel = UILabel()
    private let actorsLabel = UILabel()
    private let countryLabel = UILabel()
    private let directorLabel = UILabel()
    private let imdbRatingLabel = UILabel()
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupImageView()
        setupLabels()
        
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.4 + 25)
        ])
        
        // Fetch and set the movie poster image
        if let url = URL(string: movieDetail.Poster) {
            imageView.kf.setImage(with: url)
        }
    }
    
    private func setupLabels() {
        let labels = [titleLabel, yearLabel, actorsLabel, countryLabel, directorLabel, imdbRatingLabel]
        var previousLabel: UILabel?

        for label in labels {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.numberOfLines = 0
            view.addSubview(label)

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
                label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
            ])

            if let previousLabel = previousLabel {
                label.topAnchor.constraint(equalTo: previousLabel.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25).isActive = true
            }

            previousLabel = label
        }

        titleLabel.text = "Title: \(movieDetail.Title)"
        yearLabel.text = "Year: \(movieDetail.Year)"
        actorsLabel.text = "Actors: \(movieDetail.Actors)"
        countryLabel.text = "Country: \(movieDetail.Country)"
        directorLabel.text = "Director: \(movieDetail.Director)"
        imdbRatingLabel.text = "IMDB Rating: \(movieDetail.imdbRating)"
    }
}
