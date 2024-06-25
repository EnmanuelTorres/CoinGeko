//
//  GetPriceHistoryTest.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 11/04/24.
//

import XCTest
@testable import CoinGeko

final class GetPriceHistoryTest: XCTestCase {

    func test_execute_returns_successfully_price_when_repository_returns_price() async{
        //Given
        let mockArray = [
            CryptocurrencyPriceHistory.DataPoint(price: 1, date: Date()),
            CryptocurrencyPriceHistory.DataPoint(price: 2, date: Date()),
            CryptocurrencyPriceHistory.DataPoint(price: 3, date: Date()),
        ]
       
        let priceHistoryMock  = CryptocurrencyPriceHistory(prices: mockArray)
        let result: Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>  = .success(priceHistoryMock)
        let stub = CryptocurrencyPriceHistoryRepositoryStub(result: result)
        let sut = GetPriceHistory(repository: stub)
        
        //When
        let capturedResult =  await sut.execute(id: "", days: 0)
        
        //Then
        XCTAssertEqual(capturedResult, result)
    }
    
    func test_execute_returns_error_when_repository_returns_error() async{
        //Given
        let result: Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>  = .failure(.generic)
        let stub = CryptocurrencyPriceHistoryRepositoryStub(result: result)
        let sut = GetPriceHistory(repository: stub)
        
        //When
        let capturedResult =  await sut.execute(id: "", days: 0)
        
        //Then
        XCTAssertEqual(capturedResult, result)
    }
   
}
