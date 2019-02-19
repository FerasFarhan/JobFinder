//
//  PSUnitTestSearchGovJobsApi.swift
//  JobFinderTests
//
//  Created by Feras Farhan on 2/19/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit

class PSUnitTestSearchGovJobsApi: NSObject {

    static let sharedInstance = PSUnitTestSearchGovJobsApi()

    var jobsArray = [NSDictionary]()

    private override init() {
        if let path = Bundle.main.path(forResource: "SearchGovJobs", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [NSDictionary] {
                    self.jobsArray = jsonResult
                }
            } catch {
                print("Unable to parse JSON file")
            }
        }
    }
}
