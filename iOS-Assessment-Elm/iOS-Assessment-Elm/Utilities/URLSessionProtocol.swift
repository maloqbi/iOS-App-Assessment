//
//  URLSessionProtocol.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 28/03/1446 AH.
//

import Combine
import Foundation

protocol URLSessionProtocol {
    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}


