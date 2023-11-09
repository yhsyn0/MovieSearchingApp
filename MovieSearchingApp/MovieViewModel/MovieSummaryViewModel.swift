//
//  MovieSummaryViewModel.swift
//  MovieSearch
//
//  Created by C on 5.11.2023.
//

import Foundation

class MovieSummaryViewModel {
    private var movies: [MovieSummary] = []
    private let movieService: MovieService
    var delegate: MovieSummaryViewModelOutput?
    
    init(movieService: MovieService = APIManager()) {
        self.movieService = movieService
        self.delegate = nil
    }
    
    func fetchMovies(searchText: String) {
        guard !searchText.isEmpty else {
            self.movies = []
            self.delegate?.updateView()
            return
        }
        
        movieService.fetchMovies(searchText: searchText) { searchResult in
            DispatchQueue.main.async {
                if let searchResult = searchResult, searchResult.Response == "True" {
                    self.movies = searchResult.Search
                } else {
                    self.movies = []
                }
                self.delegate?.updateView()
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func movieAtIndex(_ index: Int) -> MovieSummary {
        return movies[index]
    }
}
