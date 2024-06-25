//
//  CryptoCurrencyRepositoryTests.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 11/04/24.
//

import XCTest
@testable import CoinGeko

final class CryptoCurrencyRepositoryTests: XCTestCase {

    func test_getGlobalCryptoList_returns_success() async throws {
        //Given
        
        let apiDataSourceStub =  ApiDatasourceStub(globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
                                                   cryptoList: .success(CryptocurrencyBasicDTO.makeCryptoList()),
                                                   priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut =  CryptoCurrencyRepository(apiDatasourcePriceInfo: apiDataSourceStub,
                                            apiDatasourceSymbol: apiDataSourceStub,
                                            apiDatasourceCrypto: apiDataSourceStub,
                                            errorMapper: CryptocurrencyDomainErrorMapper(),
                                            domainMapper: CryptocurrencyDomainMapper())
        
       
        
        //When
        let result = await sut.getGlobalCryptoList()
        
        //Then
        let cryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(cryptoList, Cryptocurrency.makeCryptocurrency())
    }
    
    func test_getGlobalCryptoList_returns_failure_when_apiDatasourceSymbol_fails() async throws {
        //Given
        
        let apiDataSourceStub =  ApiDatasourceStub(globalCryptoSymbolList: .failure(.clientError),
                                                   cryptoList: .success(CryptocurrencyBasicDTO.makeCryptoList()),
                                                   priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut =  CryptoCurrencyRepository(apiDatasourcePriceInfo: apiDataSourceStub,
                                            apiDatasourceSymbol: apiDataSourceStub,
                                            apiDatasourceCrypto: apiDataSourceStub,
                                            errorMapper: CryptocurrencyDomainErrorMapper(),
                                            domainMapper: CryptocurrencyDomainMapper())
        
        //When
        let result = await sut.getGlobalCryptoList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }

       
        XCTAssertEqual(error, CryptocurrencyDomainError.generic)
    }
    
    func test_getGlobalCryptoList_returns_failure_when_apiDatasourceCrypto_fails() async throws {
        //Given
        
        let apiDataSourceStub =  ApiDatasourceStub(globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
                                                   cryptoList: .failure(.clientError),
                                                   priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut =  CryptoCurrencyRepository(apiDatasourcePriceInfo: apiDataSourceStub,
                                            apiDatasourceSymbol: apiDataSourceStub,
                                            apiDatasourceCrypto: apiDataSourceStub,
                                            errorMapper: CryptocurrencyDomainErrorMapper(),
                                            domainMapper: CryptocurrencyDomainMapper())
        
        //When
        let result = await sut.getGlobalCryptoList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }

       
        XCTAssertEqual(error, CryptocurrencyDomainError.generic)
    }
    
    func test_getGlobalCryptoList_returns_failure_when_apiDatasourcePriceInfo_fails() async throws {
        //Given
        
        let apiDataSourceStub =  ApiDatasourceStub(globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
                                                   cryptoList: .success(CryptocurrencyBasicDTO.makeCryptoList()),
                                                   priceInfo: .failure(.clientError))
        
        let sut =  CryptoCurrencyRepository(apiDatasourcePriceInfo: apiDataSourceStub,
                                            apiDatasourceSymbol: apiDataSourceStub,
                                            apiDatasourceCrypto: apiDataSourceStub,
                                            errorMapper: CryptocurrencyDomainErrorMapper(),
                                            domainMapper: CryptocurrencyDomainMapper())
        
        //When
        let result = await sut.getGlobalCryptoList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }

       
        XCTAssertEqual(error, CryptocurrencyDomainError.generic)
    }
    
    func test_getGlobalCryptoList_returns_success_with_one_item_when_there_is_one_cryptocurrency_with_all_required_data() async throws {
        //Given
        let cryptoListStub = [
            CryptocurrencyBasicDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin"),
            CryptocurrencyBasicDTO(id: "klsfs", symbol: "ekdsklfsdth", name: "Etherkldsfeum"),
            CryptocurrencyBasicDTO(id: "rkdsflmfipple", symbol: "xkdlsfrp", name: "Rmdslipple"),
        ]
        let apiDataSourceStub =  ApiDatasourceStub(globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
                                                   cryptoList: .success(cryptoListStub),
                                                   priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut =  CryptoCurrencyRepository(apiDatasourcePriceInfo: apiDataSourceStub,
                                            apiDatasourceSymbol: apiDataSourceStub,
                                            apiDatasourceCrypto: apiDataSourceStub,
                                            errorMapper: CryptocurrencyDomainErrorMapper(),
                                            domainMapper: CryptocurrencyDomainMapper())
        
        let expectedResult  = [Cryptocurrency(id: "bitcoin",
                                          name: "Bitcoin",
                                          symbol: "btc",
                                          price: 123,
                                          price24h: 123,
                                          volume24h: 123,
                                          marketCap: 123)]
        
        //When
        let result = await sut.getGlobalCryptoList()
        
        //Then
        let cryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(cryptoList, expectedResult)
    }
    
    func test_getGlobalCryptoList_returns_success_with_one_item_when_there_are_two_cryptocurrencies_with_all_required_data() async throws {
        //Given
        let cryptoListStub = [
            CryptocurrencyBasicDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin"),
            CryptocurrencyBasicDTO(id: "ethereum", symbol: "eth", name: "Ethereum"),
            CryptocurrencyBasicDTO(id: "rkdsflmfipple", symbol: "xkdlsfrp", name: "Rmdslipple"),
        ]
        let apiDataSourceStub =  ApiDatasourceStub(globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
                                                   cryptoList: .success(cryptoListStub),
                                                   priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut =  CryptoCurrencyRepository(apiDatasourcePriceInfo: apiDataSourceStub,
                                            apiDatasourceSymbol: apiDataSourceStub,
                                            apiDatasourceCrypto: apiDataSourceStub,
                                            errorMapper: CryptocurrencyDomainErrorMapper(),
                                            domainMapper: CryptocurrencyDomainMapper())
        
        let expectedResult  = [Cryptocurrency(id: "bitcoin",
                                          name: "Bitcoin",
                                          symbol: "btc",
                                          price: 123,
                                          price24h: 123,
                                          volume24h: 123,
                                          marketCap: 123),
                               
                               Cryptocurrency(id: "ethereum",
                                              name: "Ethereum",
                                              symbol: "eth",
                                              price: 456,
                                              price24h: 456,
                                              volume24h: 456,
                                              marketCap: 456),
        ]
        
        //When
        let result = await sut.getGlobalCryptoList()
        
        //Then
        let cryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(cryptoList, expectedResult)
    }
    
}

private extension String {
     static func makeGlobalCryptoListSymbol() -> [String]{
        return ["btc", "eth", "xrp"]
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

private extension CryptocurrencyPriceInfoDTO {
    static func makePriceInfo() -> [String: CryptocurrencyPriceInfoDTO]{
        return [
            "bitcoin" : CryptocurrencyPriceInfoDTO(price: 123, marketCap: 123, volume24h: 123, price24h: 123),
            "ethereum" : CryptocurrencyPriceInfoDTO(price: 456, marketCap: 456, volume24h: 456, price24h: 456),
            "ripple" : CryptocurrencyPriceInfoDTO(price: 789, marketCap: 789, volume24h: 789, price24h: 789),
        ]
    }
}

private extension Cryptocurrency {
    
    static func makeCryptocurrency() ->  [Cryptocurrency] {
        return [ Cryptocurrency(id: "bitcoin",
                               name: "Bitcoin",
                               symbol: "btc",
                               price: 123,
                               price24h: 123,
                               volume24h: 123,
                               marketCap: 123),
                 
                 Cryptocurrency(id: "ethereum",
                                name: "Ethereum",
                                symbol: "eth",
                                price: 456,
                                price24h: 456,
                                volume24h: 456,
                                marketCap: 456),
                 
                 Cryptocurrency(id: "ripple",
                                name: "Ripple",
                                symbol: "xrp",
                                price: 789,
                                price24h: 789,
                                volume24h: 789,
                                marketCap: 789),
                 ]
    }
}
