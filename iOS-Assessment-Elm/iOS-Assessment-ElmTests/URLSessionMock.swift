//
//  URLSessionMock.swift
//  iOS-Assessment-ElmTests
//
//  Created by Mohammed on 18/03/1446 AH.
//

import Combine
import Foundation
@testable import iOS_Assessment_Elm

class URLSessionMock: URLSessionProtocol {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let error: URLError?
    
    init(data: Data?, response: URLResponse?, error: URLError?) {
        self.data = data
        self.urlResponse = response
        self.error = error
    }
    
    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let error = error {
            print("Simulating error: \(error.localizedDescription)") 
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            let response = urlResponse ?? URLResponse()
            let data = data ?? Data()
            print("Simulating data response")
            return Just((data: data, response: response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
    }
}
