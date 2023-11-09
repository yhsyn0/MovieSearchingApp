//
//  MovieDetailService.swift
//  MovieSearchingApp
//
//  Created by C on 9.11.2023.
//

import Foundation

protocol MovieDetailService {
    func fetchMovieDetail(imdbID: String, completion: @escaping (MovieDetail?) -> Void)
}
