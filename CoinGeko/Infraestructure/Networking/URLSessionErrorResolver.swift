//
//  URLSessionErrorResolver.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

class URLSessionErrorResolver {
    func resolve(statusCode: Int) -> HTTPClientError{
        guard statusCode != 429 else {
            return .tooManyRequests
        }
        guard  statusCode < 500 else {
            return .clientError
        }
        return .serverError
    }
    
    func resolver(error: Error) -> HTTPClientError {
        return .generic
    }
}
