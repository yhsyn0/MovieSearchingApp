//
//  MovieDetailViewControllerUnitTests.swift
//  MovieSearchingAppUnitTests
//
//  Created by C on 9.11.2023.
//

import XCTest
@testable import MovieSearchingApp

final class MovieDetailViewControllerAPITests: XCTestCase {
    
    var movieDetailService: MovieDetailService = APIManager()
    var movieDetailViewController: MovieDetailViewController!
    var apiManager: APIManager!
    var movieSummary: MovieSummary!
    var movieDetail: MovieDetail!
    
    
    override func setUp() {
        super.setUp()
        
        movieSummary = MovieSummary(
            Title: "The Avengers",
            Year: "2012",
            imdbID: "tt0848228",
            Poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg"
        )
        
        movieDetail = MovieDetail (Poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
                                   Title: "The Avengers",
                                   Year: "2012",
                                   Actors: "Robert Downey Jr., Chris Evans, Scarlett Johansson",
                                   Country: "United States",
                                   Director: "Joss Whedon",
                                   imdbRating: "8.0",
                                   imdbID: "tt0848228"
        )
        
        apiManager = APIManager()
        movieDetailViewController = MovieDetailViewController(movieDetail: movieDetail)
        
        _ = movieDetailViewController.view
    }
    
    override func tearDown() {
        movieDetailViewController = nil
        apiManager = nil
        movieSummary = nil
        super.tearDown()
    }
    
    func testMovieDetailDisplayWithAPI() {
        let expectation = self.expectation(description: "Movie detail fetched successfully")
        
        movieDetailViewController.loadViewIfNeeded()

        movieDetailService.fetchMovieDetail(imdbID: movieSummary.imdbID) { movieDetail in
            if let movieDetail = movieDetail {
                
                XCTAssertEqual(self.movieDetailViewController.titleLabel.text, "Title: \(movieDetail.Title )", "Incorrect movie title")
                XCTAssertEqual(self.movieDetailViewController.yearLabel.text, "Year: \(movieDetail.Year )", "Incorrect movie year")
                XCTAssertEqual(self.movieDetailViewController.actorsLabel.text, "Actors: \(movieDetail.Actors )", "Incorrect actors")
                XCTAssertEqual(self.movieDetailViewController.countryLabel.text, "Country: \(movieDetail.Country )", "Incorrect country")
                XCTAssertEqual(self.movieDetailViewController.directorLabel.text, "Director: \(movieDetail.Director )", "Incorrect director")
                XCTAssertEqual(self.movieDetailViewController.imdbRatingLabel.text, "IMDB Rating: \(movieDetail.imdbRating )", "Incorrect IMDB rating")
                
                expectation.fulfill()
            }
        }
        
        // Wait for the expectation to be fulfilled or until a timeout
        waitForExpectations(timeout: 10, handler: nil)
    }
}
