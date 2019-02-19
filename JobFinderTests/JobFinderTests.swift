//
//  JobFinderTests.swift
//  JobFinderTests
//
//  Created by Feras Farhan on 2/19/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import XCTest
@testable import JobFinder

class JobFinderTests: XCTestCase {

    override func setUp() {
        super.setUp()
       continueAfterFailure = true
    }

    func testGithubJobsParseResults() {
        let tempArray = PSUnitTestGithubJobsApi.sharedInstance.jobsArray
        XCTAssert(tempArray.count > 0, "faild")
        XCTAssertTrue(tempArray.count > 0, "faild")

        let object = tempArray.first
        XCTAssertNotNil(object, "passed")

        if let obj = object {
            XCTAssertNotNil(obj["company"], "passed")
            XCTAssertFalse(obj["company"] == nil, "faild")
        }
    }

    func testSearchGovJobsParseResults() {
        let tempArray = PSUnitTestSearchGovJobsApi.sharedInstance.jobsArray
        XCTAssert(tempArray.count > 0, "faild")
        XCTAssertTrue(tempArray.count > 0, "faild")

        let object = tempArray.first
        XCTAssertNotNil(object, "faild")

        if let obj = object {
            let locations = obj["locations"] as? [String]
            XCTAssertNotNil(locations, "faild")

            if let locations = locations {
                XCTAssertTrue(locations.count > 0, "faild")
                XCTAssertFalse(locations.count == 0, "passed")
            }
        }
    }
}
