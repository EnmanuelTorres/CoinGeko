//
//  APICryptoDataSourceTest.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 13/04/24.
//

import XCTest
@testable import CoinGeko

final class APICryptoDataSourceTest: XCTestCase {

    func test_getGlobalCryptoSymbolList_successes_when_httpClient_requests_successes_and_response_is_correct() async throws{
        //Given
        let data = """
                {
                 "data": {
                    "market_cap_percentage": {
                    "bc": 49.29373158653061,
                    "eth": 17.178905883396105,
                    "usdt": 3.740032768594513,
                    "bnb": 2.7359665929363444,
                    "sol": 2.358464916396076,
                    "steth": 1.406711443022506,
                    "хгр": 1.2505503548550383,
                    "usdc": 1.1017204473379987,
                    "doge": 0.9643953985744281,
                    "ada": 0.9565784397009568
                  }
                 }
                }
                """.data(using: .utf8)
       
        let expectedResult = ["ada", "bc", "bnb", "doge", "eth", "sol", "steth", "usdc", "usdt", "хгр"]
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getGlobalCryptoSymbolList()
        
        //Then
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, expectedResult)
        
    }
    
    func test_getGlobalCryptoSymbolList_fails_when_httpClient_requests_fails() async {
        //Given
       
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .failure(HTTPClientError.generic)))
        
        //When
        let capturedResult = await sut.getGlobalCryptoSymbolList()
        
        //Then
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .generic)
    }
    
    func test_getGlobalCryptoSymbolList_fails_when_httpClient_successes_and_response_is_not_correct() async throws{
        //Given
        let data = """
                {
                 "data": {
                    "marketeee": {
                    "bc": 49.29373158653061,
                    "eth": 17.178905883396105,
                    "usdt": 3.740032768594513,
                    "bnb": 2.7359665929363444,
                    "sol": 2.358464916396076,
                    "steth": 1.406711443022506,
                    "хгр": 1.2505503548550383,
                    "usdc": 1.1017204473379987,
                    "doge": 0.9643953985744281,
                    "ada": 0.9565784397009568
                  }
                 }
                }
                """.data(using: .utf8)
       
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getGlobalCryptoSymbolList()
        
        //Then
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")

            return
        }

        XCTAssertEqual(error, .parsingError)
        
    }
    
    
    func test_getCryptoList_successes_when_httpClient_successes_and_response_is_correct() async throws{
        //Given
        let data = """
                   [
                     {
                        "id": "01coin",
                        "symbol": "zoc",
                        "name": "01coin"
                      },
                      {
                        "id": "Ochain",
                        "symbol": "zcn",
                        "name": "Zus"
                      },
                      {
                        "id": "0-mee",
                        "symbol": "ome",
                        "name": "0-MEE"
                      },
                   ]
                """.data(using: .utf8)
       let expectedCryptoList = [
        CryptocurrencyBasicDTO(id: "01coin", symbol: "zoc", name: "01coin"),
        CryptocurrencyBasicDTO(id: "Ochain", symbol: "zcn", name: "Zus"),
        CryptocurrencyBasicDTO(id: "0-mee", symbol: "ome", name: "0-MEE")
       ]
        
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getCryptoLis()
        
        //Then
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, expectedCryptoList)
        
    }
    
    func test_getCryptoList_fails_when_httpClient_requests_fails() async throws{
        //Given
       
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .failure(HTTPClientError.generic)))
        
        //When
        let capturedResult = await sut.getCryptoLis()
        
        //Then
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .generic)
    }
    
    func test_getCryptoList_successes_when_httpClient_successes_and_response_is_not_correct() async throws{
        //Given
        let data = """
                   [
                     {
                        "iddddd": "01coin",
                        "symbol": "zoc",
                        "name": "01coin"
                      },
                      {
                        "id": "Ochain",
                        "symbol": "zcn",
                        "name": "Zus"
                      },
                      {
                        "id": "0-mee",
                        "symbol": "ome",
                        "name": "0-MEE"
                      },
                   ]
                """.data(using: .utf8)
        
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getCryptoLis()
        
        //Then
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .parsingError)
        
    }


    // getPriceInfoForCryptos
    
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
        
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getPriceInfoForCryptos(id: [])
        
        //Then
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, expectedCryptoList)
        
    }

    func test_getPriceInfoForCryptos_fails_when_httpClient_requests_fails() async throws{
        //Given
       
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .failure(HTTPClientError.generic)))
        
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
        
        
        let sut = APICryptoDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
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


