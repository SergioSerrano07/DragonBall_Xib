//
//  NetworkModelTests.swift
//  DragonBall_XibTests
//
//  Created by sergio serrano on 14/7/22.
//

import XCTest
@testable import DragonBall_Xib

class NetworkModelTests: XCTestCase {
    
    private var sut: NetworkModel!

    override func setUpWithError() throws {
        sut = NetworkModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginSuccess() throws {
        let expectation = expectation(description: "Login Success")
        var retrievedToken: String?
        var error: NetworkError?
        
        sut.login(user: "sergioserrano14.ssn@gmail.com", password: "") { token, networkError in
            retrievedToken = token
            error = networkError
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(retrievedToken, "should have received a token")
        XCTAssertNil(error, "should be no error")

    }
    
    func testLoginFail() throws {
        let expectation = expectation(description: "Login Success")
        var retrievedToken: String?
        var error: NetworkError?
        
        sut.login(user: "sergioserrano14.ssn", password: "Crypto-07") { token, networkError in
            retrievedToken = token
            error = networkError
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNil(retrievedToken, "should have received a token")
        XCTAssertNotNil(error, "should have received a token")

    }
}
