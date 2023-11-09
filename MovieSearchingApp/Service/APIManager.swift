//
//  APIManager.swift
//  MovieSearch
//
//  Created by C on 4.11.2023.
//

import Foundation

class APIManager: MovieService, MovieDetailService {
    private let apiKey = "e899c150"
    
    func fetchMovies(searchText: String, completion: @escaping (MovieSearchResult?) -> Void) {
        guard let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(encodedText)") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(MovieSearchResult.self, from: data)
                completion(searchResult)
            } catch let error {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
    func fetchMovieDetail(imdbID: String, completion: @escaping (MovieDetail?) -> Void) {
        let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(imdbID)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion(movieDetail)
            } catch let error {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}	
