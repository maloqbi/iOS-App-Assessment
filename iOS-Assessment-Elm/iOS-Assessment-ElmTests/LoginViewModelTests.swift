//
//  LoginViewModelTests.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 18/03/1446 AH.
//

import XCTest
@testable import iOS_Assessment_Elm
import Combine

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockAPIService: MockAPIService!
    var mockKeychainService: MockKeychainService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        mockKeychainService = MockKeychainService()
        viewModel = LoginViewModel(apiService: mockAPIService, keychainService: mockKeychainService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        mockKeychainService = nil
        super.tearDown()
    }
    
    func testLoginButtonEnabledWithValidCredentials() {
        viewModel.username = "testuser"
        viewModel.password = "Test@123"
        XCTAssertTrue(viewModel.isLoginButtonEnabled)
    }
    
    func testLoginButtonDisabledWithInvalidCredentials() {
        viewModel.username = "te"
        viewModel.password = "Test"
        XCTAssertFalse(viewModel.isLoginButtonEnabled)
    }
    
    func testSuccessfulLoginSavesTokenToKeychain() {
        // Arrange
        mockAPIService.shouldReturnSuccess = true
        viewModel.username = "testuser"
        viewModel.password = "Test@123"
        
        // Act
        viewModel.login()
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockKeychainService.didSaveToken, "Token was not saved in Keychain")
            XCTAssertEqual(self.mockKeychainService.savedToken, "abc123", "Saved token is not correct")
        }
    }
    
    func testLoginFailure() {
        // Arrange
        mockAPIService.shouldReturnSuccess = false
        viewModel.username = "testuser"
        viewModel.password = "Test@123"
        
        let expectation = self.expectation(description: "Wait for login result")
        
        // Act
        viewModel.login()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            print("Login result: \(String(describing: self.viewModel.loginResult))")
            XCTAssertFalse(self.viewModel.isLoggedIn, "isLoggedIn should be false after failed login")
            XCTAssertEqual(self.viewModel.loginResult, "Login failed: The operation couldn’t be completed. (NSURLErrorDomain error -1011.)", "Error message is incorrect")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.5)  
    }
}
    // MARK: - Mock Services
    
    class MockAPIService: APIService {
        var shouldReturnSuccess = true
        
        override func login(username: String, password: String) -> AnyPublisher<LoginResponse, Error> {
            if shouldReturnSuccess {
                let response = LoginResponse(token: "abc123")
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: URLError(.badServerResponse))  // Simulating failure with a network error
                    .eraseToAnyPublisher()
            }
        }
    }
    
    class MockKeychainService: KeychainService {
        var didSaveToken = false
        var savedToken: String?
        
        override func saveToken(_ token: String) {
            didSaveToken = true
            savedToken = token
        }
    }

