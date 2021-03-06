//
//  GithubTestTests.swift
//  GithubTestTests
//
//  Created by Thushara Wijekoon on 2021-03-06.
//

import XCTest
@testable import GithubTest

class GithubTestTests: XCTestCase {

    var sut: ProfilePresenter?
    var mockView: MockView?
    
    override func setUp() {
        sut = ProfilePresenter()
        mockView = MockView()
        sut?.attachView(view: mockView!)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStartLoading() throws {
        sut?.getProfile()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class MockView: ProfileView {
    func showToast(message: String) {
        print("showToast")
    }
    
    func startLoading() {
        print("test loading started")
    }
    
    func finishLoading() {
        print("test loading finished")
    }
    
    func profileLoadSuccess(fullname: String, name: String, email: String, followers: Int, followings: Int, avatarUrl: String) {
        print("test profileLoadSuccess")
    }
    
    func profileLoadFailed() {
        print("test profileLoadFailed")
    }
}
