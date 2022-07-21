//
//  NetworkModelTests.swift
//  DragonBall_XibTests
//
//  Created by sergio serrano on 14/7/22.
//

import XCTest
@testable import DragonBall_Xib

enum ErrorMock: Error {
    case mockCase
}

class NetworkModelTests: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    
    private var sut: NetworkModel!

    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        
        sut = NetworkModel(urlSession: urlSessionMock)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoginFailWithNoData() {
        var error: NetworkError?
        
        urlSessionMock.data = nil
        
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        XCTAssertEqual(error, .noData)
    }
    
    func testLoginFailWithError() {
        var error: NetworkError?
        
        urlSessionMock.data = nil
        urlSessionMock.error = ErrorMock.mockCase
        
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        XCTAssertEqual(error, .other)
    }
    
    
    func testLoginFailWithErrorCodeNil() {
        var error: NetworkError?
        
        urlSessionMock.data = "TokenString".data(using: .utf8)!
        urlSessionMock.response = nil
        
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        XCTAssertEqual(error, .errorCode(nil))
    }
    
    func testLoginFailWithErrorCode() {
        var error: NetworkError?
        
        urlSessionMock.data = "TokenString".data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        XCTAssertEqual(error, .errorCode(404))
    }
    
    func testLoginSuccessWithMockToken() {
        var error: NetworkError?
        var retrievedToken: String?
        
        urlSessionMock.data = "TokenString".data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sut.login(user: "", password: "") { token, networkError in
            retrievedToken = token
            error = networkError
        }
        XCTAssertEqual(retrievedToken, "TokenString", "should have received a token")
        XCTAssertNil(error, "There should be not error")
    }
    
    
}
