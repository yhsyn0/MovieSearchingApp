//
//  MovieService.swift
//  MovieSearch
//
//  Created by C on 4.11.2023.
//

import Foundation

protocol MovieService {
    func fetchMovies(searchText: String, completion: @escaping (MovieSearchResult?) -> Void)
}
