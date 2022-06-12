//
//  BoubyanTaskTests.swift
//  BoubyanTaskTests
//
//  Created by Ahmed Samir on 11/06/2022.
//

import XCTest
@testable import BoubyanTask
import Moya
import Combine

class BoubyanTaskTests: XCTestCase {
    
    
    var articleRepository: ArticleRepository!
    var cancelable = Set<AnyCancellable>()
    
    
    override func setUp() {
        super.setUp()
        
        let endpointClosure = { (target: ArticleService) -> Endpoint in
            let url = URL(target: target).absoluteString
            
            return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        }
        articleRepository = ArticleRepository(provider: MoyaProvider<ArticleService>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub))
    }
    
    
    override func tearDown() {
        articleRepository = nil
    }
    
    
    func testArticles() {
        //Arrange
        let expectation = XCTestExpectation(description: "NetworkHandler Failure...")
        
        var articles: [ArticleModel]?
        //Act
        self.articleRepository.getArticles(period: .one).sink { completion in
            
        } receiveValue: { response in
            articles = response?.results
            expectation.fulfill()
        }.store(in: &cancelable)
        
        wait(for: [expectation], timeout: 10)
        
        // Assert
        XCTAssertNotNil(articles)
        XCTAssertEqual(articles?.count, 20)
        XCTAssertEqual(articles?.first?.id, 100000008379412)
    }
}
