//
//  CryptocurrencyBasicInfoRepositoryTests.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 12/04/24.
//

import XCTest
@testable import CoinGeko

final class CryptocurrencyBasicInfoRepositoryTests: XCTestCase {

    func test_getCryptoList_returns_success_when_there_is_nonEmpty_cache() async throws {
        //Given
        let expectedCryptocurrencyBasicList = CryptocurrencyBasicInfo.makeCryptoList()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success([]), cachedValue: expectedCryptocurrencyBasicList)
        
        
        //When
        let result = await sut.getCryptoList()
        
        //Then
        let capturedCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCryptoList, expectedCryptocurrencyBasicList)
    }
    
    func test_getCryptoList_returns_success_when_there_is_empty_cache() async throws {
        //Given
        let expectedCryptocurrencyBasicList = CryptocurrencyBasicInfo.makeCryptoList()
        let cryptocurrencyBasicDTO = CryptocurrencyBasicDTO.makeCryptoList()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success(cryptocurrencyBasicDTO), cachedValue: [])
        
        //When
        let result = await sut.getCryptoList()
        
        //Then
        let capturedCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCryptoList, expectedCryptocurrencyBasicList)
    }
    
    func test_getCryptoList_saves_in_cache_when_cache_is_empty_and_gets_dat_from_apiDataSource() async throws {
        //Given
        let cryptocurrencyBasicDTO = CryptocurrencyBasicDTO.makeCryptoList()
        let (sut, cacheDatasource) = makeSUT(apiDataSourceResult: .success(cryptocurrencyBasicDTO), cachedValue: [])
        
        let expectedCryptocurrencyBasicList = CryptocurrencyBasicInfo.makeCryptoList()
        
        //When
        _ = await sut.getCryptoList()
        
        //Then
        XCTAssertEqual(cacheDatasource.cachedCryptoList, expectedCryptocurrencyBasicList)
    }
    
    func test_getCryptoList_returns_failure_when_there_is_empty_cache_and_apiDataSource_returns_failure() async  {
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.clientError), cachedValue: [])
        
        //When
        let result = await sut.getCryptoList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success,")
            return
        }

        XCTAssertEqual(error, .generic)
    }
    
    func test_search_returns_all_cryptoList_when_search_is_empty() async throws{
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .success(CryptocurrencyBasicDTO.makeCryptoList()), cachedValue: [])
        
        let expectedCryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        
        //When
        let result = await sut.search(crypto: "")
        
        //Then
        let capturesCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(expectedCryptoList, capturesCryptoList)

    }
    
    func test_search_returns_filtered_cryptoList_with_one_item_based_on_search() async throws{
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .success(CryptocurrencyBasicDTO.makeCryptoList()), cachedValue: [])
        
        let expectedCryptoList = [CryptocurrencyBasicInfo(id: "bitcoin", name: "Bitcoin", symbol: "btc")]
        
        //When
        let result = await sut.search(crypto: "bit")
        
        //Then
        let capturesCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(expectedCryptoList, capturesCryptoList)

    }
    
    func test_search_returns_filtered_cryptoList_with_three_item_based_on_search() async throws{
        //Given
        let cryptoList = [
            CryptocurrencyBasicDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin"),
            CryptocurrencyBasicDTO(id: "ethereum", symbol: "eth", name: "Ethereum"),
            CryptocurrencyBasicDTO(id: "ripple", symbol: "xrp", name: "Ripple"),
            CryptocurrencyBasicDTO(id: "ethereumjdjdj", symbol: "ethdjsns", name: "Ethereumkjdlfak"),
            CryptocurrencyBasicDTO(id: "ethereumsndlf", symbol: "ethknsdla", name: "Ethereumnkdsal"),

        ]
        let (sut, _) = makeSUT(apiDataSourceResult: .success(cryptoList), cachedValue: [])
        
        let expectedCryptoList = [
            CryptocurrencyBasicInfo(id: "ethereum", name: "Ethereum", symbol: "eth"),
            CryptocurrencyBasicInfo(id: "ethereumjdjdj", name: "Ethereumkjdlfak", symbol: "ethdjsns"),
            CryptocurrencyBasicInfo(id: "ethereumsndlf", name: "Ethereumnkdsal", symbol: "ethknsdla"),
        ]
        
        //When
        let result = await sut.search(crypto: "eth")
        
        //Then
        let capturesCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(expectedCryptoList, capturesCryptoList)

    }
    
    func test_search_returns_failure_when_getCrypto_returns_failure() async {
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.clientError), cachedValue: [])
        
        
        //When
        let result = await sut.search(crypto: "bit")
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success,")
            return
        }

        XCTAssertEqual(error, .generic)
    }
    
    private func makeSUT(apiDataSourceResult: Result<[CryptocurrencyBasicDTO],HTTPClientError>,
                         cachedValue: [CryptocurrencyBasicInfo])
                         -> (sut: CryptocurrencyBasicInfoRepository, cache: CacheCryptocurrencyBasicInfoDataSourceStub ) {
        let apiDataSource = APICryptocurrencyBasicInfoDataSourceStub(result: apiDataSourceResult)
        
        let cacheDatasource = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: cachedValue)
        let sut = CryptocurrencyBasicInfoRepository(apiDatasource: apiDataSource,
                                                    errorMapper: CryptocurrencyDomainErrorMapper(),
                                                    cacheDatasource: cacheDatasource)
        
        return (sut, cacheDatasource)
    }
    
    
    
}

private extension CryptocurrencyBasicDTO {
    static func makeCryptoList() -> [CryptocurrencyBasicDTO]{
        return [
            CryptocurrencyBasicDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin"),
            CryptocurrencyBasicDTO(id: "ethereum", symbol: "eth", name: "Ethereum"),
            CryptocurrencyBasicDTO(id: "ripple", symbol: "xrp", name: "Ripple"),
        ]
    }
}

private extension CryptocurrencyBasicInfo {
    static func makeCryptoList() -> [CryptocurrencyBasicInfo]{
        return [
            CryptocurrencyBasicInfo(id: "bitcoin", name: "Bitcoin", symbol: "btc"),
            CryptocurrencyBasicInfo(id: "ethereum", name: "Ethereum", symbol: "eth"),
            CryptocurrencyBasicInfo(id: "ripple", name: "Ripple", symbol: "xrp"),
        ]
    }
}
