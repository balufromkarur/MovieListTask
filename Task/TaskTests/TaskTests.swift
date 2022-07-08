//
//  TaskTests.swift
//  TaskTests
//
//  Created by Bala on 01/07/22.
//

import XCTest
@testable import Task

class TaskTests: XCTestCase {

    var filmVc : FlimViewController!
    var sut: FilmViewModel!
    var mockAPIService: MockApiService!
    
    override func setUpWithError() throws {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        filmVc = storyBoard.instantiateViewController(identifier: "FlimViewController") as? FlimViewController
        _ = UINavigationController(rootViewController: filmVc)
        filmVc.loadViewIfNeeded()
    }
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = FilmViewModel(apiService: mockAPIService!)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_Movie_success() {
        mockAPIService.completeMovies = StubGenerator().stubMovies()
        sut.initFetch()
        mockAPIService.fetchSuccess()
    }
    
    func test_fetch_Movie_fail() {
        let error = APIError.noPermission
        sut.initFetch()
        mockAPIService.fetchFail(error: error )
        XCTAssertEqual( sut.alertMessage, error.rawValue )
        
    }
    
    override func tearDownWithError() throws {
        filmVc = nil
    }
}

class MockApiService: APIServiceProtocol {
    
    var isFetchMovieCalled = false
    
    var completeMovies: [Search] = [Search]()
    var completeClosure: ((Bool, [Search], APIError?) -> ())!
    
    func getFilmList(complete: @escaping (Bool, [Search], APIError?) -> ()) {
        isFetchMovieCalled = true
        completeClosure = complete
    }
    
    func fetchSuccess() {
        completeClosure( true, completeMovies, nil )
    }
    
    func fetchFail(error: APIError?) {
        completeClosure( false, completeMovies, error )
    }
    
}

class StubGenerator {
    func stubMovies() -> [Search] {
        let mockMovie = Search(title: "Captain Marvel", year: "2019", imdb: "tt4154664", type: "movie", poster: "https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg")
        return [mockMovie]
    }
}
