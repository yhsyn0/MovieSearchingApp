//
//  MovieDetail.swift
//  MovieSearchingApp
//
//  Created by C on 9.11.2023.
//

import Foundation

struct MovieDetail: Decodable {
    let Poster: String
    let Title: String
    let Year: String
    let Actors: String
    let Country: String
    let Director: String
    let imdbRating: String
    let imdbID: String
}
