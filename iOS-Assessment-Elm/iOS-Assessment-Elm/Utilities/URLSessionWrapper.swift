//
//  URLSessionWrapper.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 28/03/1446 AH.
//

import Foundation
import Combine
class URLSessionWrapper: URLSessionProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        let subject = PassthroughSubject<(data: Data, response: URLResponse), URLError>()
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                subject.send(completion: .failure(error))
            } else if let data = data, let response = response {
                subject.send((data: data, response: response))
                subject.send(completion: .finished)
            } else {
                subject.send(completion: .failure(URLError(.badServerResponse)))
            }
        }
        
        task.resume()
        return subject.eraseToAnyPublisher()
    }
}
