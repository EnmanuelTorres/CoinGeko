//
//  getPriceInfoTest.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 10/04/24.
//

import XCTest
@testable import CoinGeko


final class getPriceInfoTest: XCTestCase {

    func test_execute_returns_successfully_price_when_repository_returns_price() async{
        //Given
        let mockPrice = CryptocurrencyPriceInfo(price: 1, price24h: 3, volume24h: 2, marketCap: 4)
        let result: Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError>  = .success(mockPrice)
        let stub = CryptocurrencyPriceInfoRepositoryStub(result: result)
        let sut = getPriceInfo(repository: stub)
        
        //When
        let capturedResult =  await sut.execute(id: "")
        
        //Then
        XCTAssertEqual(capturedResult, result)
    }
    
    func test_execute_returns_error_when_repository_returns_error() async{
        //Given
        let result: Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError>  = .failure(.generic)
        let stub = CryptocurrencyPriceInfoRepositoryStub(result: result)
        let sut = getPriceInfo(repository: stub)
        
        //When
        let capturedResult =  await sut.execute(id: "")
        
        //Then
        XCTAssertEqual(capturedResult, result)
    }
}
