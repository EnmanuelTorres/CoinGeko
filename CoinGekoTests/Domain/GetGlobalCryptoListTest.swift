//
//  GetGlobalCryptoListTest.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 10/04/24.
//

import XCTest
@testable import CoinGeko

final class GetGlobalCryptoListTest: XCTestCase {

    func test_execute_sucessfully_returns_sorted_array_when_repository_returns_nonEmpty_array() async throws{
        
        //Given
        let mockArray = [
            Cryptocurrency(id: "002", name: "bitcoin", symbol: "btc", price: 353663.23, price24h: 0.32, volume24h: 100000, marketCap: 5848474),
            Cryptocurrency(id: "003", name: "cardano", symbol: "ada", price: 1.23, price24h: -0.45, volume24h: 32434, marketCap: 98765543123321),
            Cryptocurrency(id: "001", name: "solana", symbol: "sol", price: 353663.23, price24h: 1.23, volume24h: 3000, marketCap: 923456788),
        ]
        let result: Result<[Cryptocurrency], CryptocurrencyDomainError> = .success(mockArray)
        let stub = GlobalCryptoListRepositoryStub(result: result)
        let sut = GetGlobalCryptoList(repository: stub)
        
         //When
        let capturedResult = await sut.execute()
        
        //Then
        let capturedCryptoList = try  XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCryptoList[0], mockArray[1])
        XCTAssertEqual(capturedCryptoList[1], mockArray[2])
        XCTAssertEqual(capturedCryptoList[2], mockArray[0])
    }
    
    func test_execute_sucessfully_returns_sorted_array_when_repository_returns_nonEmpty_sorted_array() async {
        
        //Given
        let mockArray = [
            Cryptocurrency(id: "002", name: "bitcoin", symbol: "btc", price: 353663.23, price24h: 0.32, volume24h: 100000, marketCap: 98765543123321),
            Cryptocurrency(id: "003", name: "cardano", symbol: "ada", price: 1.23, price24h: -0.45, volume24h: 32434, marketCap: 923456788),
            Cryptocurrency(id: "001", name: "solana", symbol: "sol", price: 353663.23, price24h: 1.23, volume24h: 3000, marketCap: 5848474),
            
            
        ]
        let result: Result<[Cryptocurrency], CryptocurrencyDomainError> = .success(mockArray)
        let stub = GlobalCryptoListRepositoryStub(result: .success(mockArray))
        let sut = GetGlobalCryptoList(repository: stub)
        
         //When
        let capturedResult = await  sut.execute()
        
        //Then
        XCTAssertEqual(capturedResult, result)

    }
    
    func test_execute_sucessfully_returns_anEmpty_array_when_repository_returns_anEmpty_array() async {
        
        //Given
        
        let result: Result<[Cryptocurrency], CryptocurrencyDomainError> = .success([])
        let stub = GlobalCryptoListRepositoryStub(result: result)
        let sut = GetGlobalCryptoList(repository: stub)
        
         //When
        let capturedResult = await  sut.execute()
        
        //Then
        XCTAssertEqual(capturedResult, result)

    }
    
    func test_execute_returns_anEmpty_error_when_repository_returns_error() async {
        
        //Given
        
        let result: Result<[Cryptocurrency], CryptocurrencyDomainError> = .failure(.generic)
        let stub = GlobalCryptoListRepositoryStub(result: result)
        let sut = GetGlobalCryptoList(repository: stub)
        
         //When
        let capturedResult = await  sut.execute()
        
        //Then
        XCTAssertEqual(capturedResult, result)

    }
}
