//
//  MovieSearchingAppUnitTests.swift
//  MovieSearchingAppUnitTests
//
//  Created by C on 9.11.2023.
//

import XCTest
@testable import MovieSearchingApp

final class ViewControllerUnitTests: XCTestCase {

    var viewModel: MovieSummaryViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MovieSummaryViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        let expectation = self.expectation(description: "Movies fetched successfully")
        let searchText = "The Avengers"
        
        viewModel.fetchMovies(searchText: searchText)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            XCTAssertGreaterThan(self.viewModel.numberOfMovies(), 0, "Number of movies should be greater than 0")
            let firstMovie = self.viewModel.movieAtIndex(0)
            XCTAssertEqual(firstMovie.Title, searchText, "First movie should include searching text: \(searchText)")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
