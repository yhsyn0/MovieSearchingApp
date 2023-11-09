//
//  Movie.swift
//  MovieSearch
//
//  Created by C on 4.11.2023.
//

import Foundation

struct MovieSummary: Decodable {
    let Title: String
    let Year: String
    let imdbID: String
    let Poster: String
}

struct MovieSearchResult: Decodable {
    let Search: [MovieSummary]
    let totalResults: String
    let Response: String
}
