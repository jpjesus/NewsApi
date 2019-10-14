//
//  TheNewsTests.swift
//  TheNewsTests
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import XCTest
import RxSwift
import Moya
@testable import TheNews

class TheNewsTests: XCTestCase {

    private var provider: MoyaProvider<NewsAPI>!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        provider =  MoyaProvider<NewsAPI>.init(stubClosure: MoyaProvider<NewsAPI>.immediatelyStub)
    }
    
    func test_NewsAPI_getNews_ShouldBeEqualTo() {
        var news = News()
        let expectedCount: Int = 20
        let expecteFirstTitle: String = "Defense Sec Esper defends Trump's removal of troops from Northern Syria - Fox News"
        let expectSource: String = "Youtube.com"
        let expectation =  self.expectation(description: "start fetching manufacturers")
        provider.rx.request(.getTopHeadlines(page: 0, pageSize: 10))
            .map(News.self)
            .asObservable()
            .subscribe(onNext: { list in
                news = list
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5) { error in
            if (error != nil) {
                XCTFail("sample data fail")
            }
        }
        XCTAssertEqual(news.articles.count, expectedCount)
        XCTAssertEqual(news.articles.first?.title, expecteFirstTitle)
        XCTAssertEqual(news.articles.first?.source.name, expectSource)
    }
}
