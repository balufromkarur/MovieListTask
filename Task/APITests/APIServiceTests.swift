//
//  APIServiceTests.swift
//  TaskTests
//
//  Created by Bala on 07/07/22.
//

import XCTest
@testable import Task

class APIServiceTests: XCTestCase {
        
        var sut: APIService?
        
        override func setUp() {
            super.setUp()
            sut = APIService()
        }

        override func tearDown() {
            sut = nil
            super.tearDown()
        }

        func test_getFilmList() {
            let sut = self.sut
            let expect = XCTestExpectation(description: "callback")
            sut?.getFilmList(complete: { (success, response, error) in
                expect.fulfill()
                XCTAssertEqual( response.count, 10)
            })
            wait(for: [expect], timeout: 3.1)
        }
    }
