//
//  SearchCryptoListTests.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 10/04/24.
//

import XCTest
@testable import CoinGeko

final class SearchCryptoListTests: XCTestCase {

    func test_execute_sucessfully_returns_sorted_array_when_repository_returns_nonEmpty_array() async throws{
        
        //Given
        let mockArray = [
            CryptocurrencyBasicInfo(id: "001", name: "solana", symbol: "sol"),
            CryptocurrencyBasicInfo(id: "002", name: "bitcoin", symbol: "btc"),
            CryptocurrencyBasicInfo(id: "003", name: "cardano", symbol: "ada"),
        ]
        let result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> = .success(mockArray)
        let stub = searchCryptoListBasicInfoRepositoryTypeStub(result: result)
        let sut = SearchCryptoList(repository: stub)
        
         //When
        let capturedResult = await sut.execute(crypto: "")
        
        //Then
        let capturedCryptoList = try  XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCryptoList[0], mockArray[1])
        XCTAssertEqual(capturedCryptoList[1], mockArray[2])
        XCTAssertEqual(capturedCryptoList[2], mockArray[0])
    }
    
    func test_execute_sucessfully_returns_sorted_array_when_repository_returns_nonEmpty_sorted_array() async {
        
        //Given
        let mockArray = [
            CryptocurrencyBasicInfo(id: "002", name: "bitcoin", symbol: "btc"),
            CryptocurrencyBasicInfo(id: "003", name: "cardano", symbol: "ada"),
            CryptocurrencyBasicInfo(id: "001", name: "solana", symbol: "sol"),

        ]
        let result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> = .success(mockArray)
        let stub = searchCryptoListBasicInfoRepositoryTypeStub(result: .success(mockArray))
        let sut = SearchCryptoList(repository: stub)
        
         //When
        let capturedResult = await  sut.execute(crypto: "")
        
        //Then
        XCTAssertEqual(capturedResult, result)

    }
    
    func test_execute_sucessfully_returns_anEmpty_array_when_repository_returns_anEmpty_array() async {
        
        //Given
        
        let result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> = .success([])
        let stub = searchCryptoListBasicInfoRepositoryTypeStub(result: result)
        let sut = SearchCryptoList(repository: stub)
        
         //When
        let capturedResult = await  sut.execute(crypto: "")
        
        //Then
        XCTAssertEqual(capturedResult, result)

    }
    
    func test_execute_returns_anEmpty_error_when_repository_returns_error() async {
        
        //Given
        
        let result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> = .failure(.generic)
        let stub = searchCryptoListBasicInfoRepositoryTypeStub(result: result)
        let sut = SearchCryptoList(repository: stub)
        
         //When
        let capturedResult = await  sut.execute(crypto: "")
        
        //Then
        XCTAssertEqual(capturedResult, result)

    }
}
