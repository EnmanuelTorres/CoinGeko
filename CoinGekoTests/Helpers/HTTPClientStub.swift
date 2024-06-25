//
//  HTTPClientStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 14/04/24.
//

import Foundation
@testable import CoinGeko

class HTTPClientStub: HTTPClient{
    let result: Result<Data, HTTPClientError>
    
    init(result: Result<Data, HTTPClientError>) {
        self.result = result
    }
    func makeRequest(endpoint: CoinGeko.Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        return result
    }
    
    
}
