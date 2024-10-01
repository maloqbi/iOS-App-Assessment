//
//  LoginViewModelTests.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 18/03/1446 AH.
//

import XCTest
@testable import iOS_Assessment_Elm

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testLoginButtonEnabledWithValidCredentials() {
        viewModel.username = "testuser"
        viewModel.password = "Test@123"
        XCTAssertTrue(viewModel.isLoginButtonEnabled)
    }
    
}
