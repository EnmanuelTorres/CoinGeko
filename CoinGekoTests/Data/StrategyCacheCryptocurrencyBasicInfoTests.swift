//
//  StrategyCacheCryptocurrencyBasicInfoTests.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 14/04/24.
//

import XCTest
@testable import CoinGeko

final class StrategyCacheCryptocurrencyBasicInfoTests: XCTestCase {

    func test_getCryptoList_returns_non_empty_array_when_there_is_temporal_cache() async{
        //Given
        let cryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: cryptoList)
        let persistenceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])

        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistenceCache: persistenceCache)
        
        //When
        let capturedResult = await sut.getCryptoLis()
        
        //Then
        XCTAssertEqual(capturedResult, cryptoList)
    }
    
    func test_getCryptoList_returns_non_empty_array_when_temporal_cache_is_empty_and_there_is_persisted_cache() async{
        //Given
        let cryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        let persistenceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: cryptoList)

        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistenceCache: persistenceCache)
        
        //When
        let capturedResult = await sut.getCryptoLis()
        
        //Then
        XCTAssertEqual(capturedResult, cryptoList)
    }
    
    func test_getCryptoList_returns_empty_array_when_temporal_is_empty_and_persisted_is_empty() async{
        //Given
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        let persistenceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])

        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistenceCache: persistenceCache)
        
        //When
        let capturedResult = await sut.getCryptoLis()
        
        //Then
        XCTAssertEqual(capturedResult, [])
    }
    
    func test_getCryptoList_saves_in_temporal_cache_when_temporal_cache_is_empty_and_there_is_persisted_cache() async{
        //Given
        let cryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        let persistenceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: cryptoList)

        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistenceCache: persistenceCache)
        
        //When
        _ = await sut.getCryptoLis()
        
        //Then
        XCTAssertEqual(temporalCache.cachedCryptoList, cryptoList)
    }
    
    func test_saveCryptoList_saves_in_temporal_cache_and_persisted_cache() async{
        //Given
        let cryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        let persistenceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])

        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistenceCache: persistenceCache)
        
        //When
        _ = await sut.saveCryptoList(cryptoList )
        
        //Then
        XCTAssertEqual(temporalCache.cachedCryptoList, cryptoList)
        XCTAssertEqual(persistenceCache.cachedCryptoList, cryptoList)
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
