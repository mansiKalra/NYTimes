//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by KiwiTech on 13/11/18.
//  Copyright © 2018 KiwiTech. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {
    var vc: ArticleListViewController?


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "ArticleListViewController") as? ArticleListViewController

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testParentViewHasTableViewSubview() {

        let subviews = vc?.view.subviews
        XCTAssertTrue((subviews!.contains((vc?.tblArticle)!)), "View does not have a table subview")
    }


    // MARK: - UITableView tests
    func testForAPI() {
       let urlStr = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=869d4e276804463b8b139a47809a8e4f"
        AFWrapper.getRequest(urlString: urlStr, requestMethod: .get, headers: nil, params: nil, success: { (JSON) in
            XCTAssert(true)
        }) { (error) in
            XCTAssert(false)
        }

    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
