//
//  CryptocurrencyPriceRepositoryTests.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 12/04/24.
//

import XCTest
@testable import CoinGeko

final class CryptocurrencyPriceRepositoryTests: XCTestCase {

    func test_getPriceHistory_returns_success() async throws {
        
        //Given
        let expectedPriceHistory = CryptocurrencyPriceHistoryDTO(prices: [
            [createTimeStamp(day: 12, month: 4, year: 2024), 20000],
            [createTimeStamp(day: 11, month: 4, year: 2024), 19000],
            [createTimeStamp(day: 10, month: 4, year: 2024), 18000],
        ])
        let apiDataSource = ApiPriceDataSourceStub()
        apiDataSource.getPriceHistory = .success(expectedPriceHistory)
        let sut = CryptocurrencyPriceRepository(apiDataSource: apiDataSource,
                                                domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                                errorMapper: CryptocurrencyDomainErrorMapper())
        
        //When
        let result = await sut.getPriceHistory(id: "", days: 1)
        
        //Then
        let capturedPriceHistory = try XCTUnwrap(result.get())
        XCTAssertEqual( capturedPriceHistory.prices.count, expectedPriceHistory.prices.count)
        
        for i in 0..<capturedPriceHistory.prices.count {
            XCTAssertEqual( capturedPriceHistory.prices[i].date.timeIntervalSince1970, expectedPriceHistory.prices[i][0])
            XCTAssertEqual( capturedPriceHistory.prices[i].price, expectedPriceHistory.prices[i][1])

        }
       
    }
    
    func test_getPriceHistory_returns_failure() async {
        let apiDataSource = ApiPriceDataSourceStub()
        apiDataSource.getPriceHistory = .failure(.clientError)
        let sut = CryptocurrencyPriceRepository(apiDataSource: apiDataSource,
                                                domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                                errorMapper: CryptocurrencyDomainErrorMapper())
        
        //When
        let result = await sut.getPriceHistory(id: "", days: 1)
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        XCTAssertEqual(error, .generic)

    }
    
    func test_getPriceInfo_returns_success() async throws {
        //Given
      let expectedPriceInfo = CryptocurrencyPriceInfoDTO(price: 100,
                                                         marketCap: 1000,
                                                         volume24h: 12342,
                                                         price24h: 2.3)
        let apiDataSource = ApiPriceDataSourceStub()
        apiDataSource.getPriceInfoForCryptos = .success(["bitcoin":expectedPriceInfo])
        let sut = CryptocurrencyPriceRepository(apiDataSource: apiDataSource,
                                                domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                                errorMapper: CryptocurrencyDomainErrorMapper())
        
        //When
        let result = await sut.getPriceInfo(Id: "")
        
        //Then
        let capturedPriceInfo = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedPriceInfo.price, 100)
        XCTAssertEqual(capturedPriceInfo.marketCap, 1000)
        XCTAssertEqual(capturedPriceInfo.volume24h, 12342)
        XCTAssertEqual(capturedPriceInfo.price24h, 2.3)
    }
    
    func test_getPriceInfo_returns_failure_when_there_is_no_priceInfo() async throws {
        //Given
       
        let apiDataSource = ApiPriceDataSourceStub()
        apiDataSource.getPriceInfoForCryptos = .success([:])
        let sut = CryptocurrencyPriceRepository(apiDataSource: apiDataSource,
                                                domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                                errorMapper: CryptocurrencyDomainErrorMapper())
        
        //When
        let result = await sut.getPriceInfo(Id: "")
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        XCTAssertEqual(error, .generic)
    }
    
    func test_getPriceInfo_returns_failure_when_dataSource_returns_failure() async throws {
        //Given
       
        let apiDataSource = ApiPriceDataSourceStub()
        apiDataSource.getPriceInfoForCryptos = .failure(.tooManyRequests)
        let sut = CryptocurrencyPriceRepository(apiDataSource: apiDataSource,
                                                domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                                errorMapper: CryptocurrencyDomainErrorMapper())
        
        //When
        let result = await sut.getPriceInfo(Id: "")
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        XCTAssertEqual(error, .tooManyRequests)
    }
    
    private func createTimeStamp(day: Int, month: Int, year: Int) -> TimeInterval {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!.timeIntervalSince1970
    }
}
