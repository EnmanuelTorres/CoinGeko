//
//  HTTPClientError.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

enum HTTPClientError: Error {
    case clientError
    case serverError
    case generic
    case parsingError
    case badURL
    case responseError
    case tooManyRequests
}
