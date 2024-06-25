//
//  APIPriceDataSourceTests.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 13/04/24.
//

import XCTest
@testable import CoinGeko

final class APIPriceDataSourceTests: XCTestCase {
    
    func test_getPriceHistory_successes_when_httpClient_successes_and_response_is_correct() async throws {
        //Given
        let data = """
                {
                  "prices": [
                [
                  1707418834229,
                  45289.3559421022
                ],
                [
                  1707422420399,
                  45303.658354175364
                ],
                [
                  1707426868653,
                  45481.628337707705
                 ],
                [
                  1707429604855,
                  45387.05257085574
                ],
                [
                  1707433277993,
                  45333.15905379783
                  ]
                 ]
                }
                """.data(using: .utf8)
        
       let expectedPricesList = CryptocurrencyPriceHistoryDTO(prices: [
            [1707418834229, 45289.3559421022],
            [1707422420399, 45303.658354175364],
            [1707426868653, 45481.628337707705],
            [1707429604855, 45387.05257085574],
            [ 1707433277993, 45333.15905379783]
        ])
               
    
        
        
        let sut = APIPriceDataSource(httpClient:  HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getPriceHistory(id: "", days: 12)
        
        //Then
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, expectedPricesList)
        
    }
    
    func test_getPriceHistory_fails_when_httpClient_requests_fails() async throws{
        //Given
       
        
        let sut = APIPriceDataSource(httpClient: HTTPClientStub(result: .failure(HTTPClientError.generic)))
        
        //When
        let capturedResult = await sut.getPriceHistory(id: "", days: 12)
        
        //Then
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .generic)
    }
    
    func test_getPriceHistory_successes_when_httpClient_successes_and_response_is_not_correct() async throws {
        //Given
        let data = """
                {
                  "prices": [
                [
                  "1707418834229",
                  45289.3559421022
                ],
                [
                  1707422420399,
                  45303.658354175364
                ],
                [
                  1707426868653,
                  45481.628337707705
                 ],
                [
                  1707429604855,
                  45387.05257085574
                ],
                [
                  1707433277993,
                  45333.15905379783
                  ]
                 ]
                }
                """.data(using: .utf8)
        
     
            
        
        let sut = APIPriceDataSource(httpClient:  HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getPriceHistory(id: "", days: 12)
        
        //Then
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .parsingError)
        
    }


    func test_getPriceInfoForCryptos_successes_when_httpClient_successes_and_response_is_correct() async throws{
        //Given
        let data = """
                {
                   "bitcoin": {
                      "usd": 68441,
                      "usd_market_cap": 1344593071623.8994,
                      "usd_24h_vol": 27941149874.583347,
                      "usd_24h_change": -0.23503340862672684
                },
                   "ethereum": {
                      "usd": 3899.42,
                      "usd_market_cap": 468373815422.2679,
                      "usd_24h_vol": 15791089776.886791,
                      "usd_24h_change": -1.1399309959334711
                },
                   "solana": {
                      "usd": 145.66,
                      "usd_market_cap": 64474420984.568214,
                      "usd_24h_vol": 3675184810.372911,
                      "usd_24h_change": -2.4572866321700095
                    }
                }
                """.data(using: .utf8)
       let expectedCryptoList = [
        "bitcoin" : CryptocurrencyPriceInfoDTO(price: 68441,
                                               marketCap: 1344593071623.8994,
                                               volume24h: 27941149874.583347,
                                               price24h: -0.23503340862672684),
               
        "ethereum" : CryptocurrencyPriceInfoDTO(price: 3899.42,
                                                marketCap: 468373815422.2679,
                                                volume24h: 15791089776.886791,
                                                price24h: -1.1399309959334711),
               
        "solana" : CryptocurrencyPriceInfoDTO(price: 145.66,
                                              marketCap: 64474420984.568214,
                                              volume24h: 3675184810.372911,
                                              price24h: -2.4572866321700095)
               
       ]
        
        
        let sut = APIPriceDataSource(httpClient:  HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getPriceInfoForCryptos(id: [])
        
        //Then
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, expectedCryptoList)
        
    }

    func test_getPriceInfoForCryptos_fails_when_httpClient_requests_fails() async throws{
        //Given
       
        
        let sut = APIPriceDataSource(httpClient: HTTPClientStub(result: .failure(HTTPClientError.generic)))
        
        //When
        let capturedResult = await sut.getPriceInfoForCryptos(id: [])
        
        //Then
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .generic)
    }
    
    func test_getPriceInfoForCryptos_successes_when_httpClient_successes_and_response_is_not_correct() async throws{
        //Given
        let data = """
                {
                   "bitcoin": {
                      "euro": 68441,
                      "euro_market_cap": 1344593071623.8994,
                      "usd_24h_vol": 27941149874.583347,
                      "usd_24h_change": -0.23503340862672684
                },
                   "ethereum": {
                      "usd": 3899.42,
                      "usd_market_cap": 468373815422.2679,
                      "euro_24h_vol": 15791089776.886791,
                      "usd_24h_change": -1.1399309959334711
                },
                   "solana": {
                      "usd": 145.66,
                      "euro_market_cap": 64474420984.568214,
                      "usd_24h_vol": 3675184810.372911,
                      "usd_24h_change": -2.4572866321700095
                    }
                }2
                """.data(using: .utf8)
        
        
        let sut = APIPriceDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getPriceInfoForCryptos(id: [])
      
      //  Then
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .parsingError)
    }
}


