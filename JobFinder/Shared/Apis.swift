//
//  TBApi.swift
//  JobFinder
//
//  Created by Feras Farhan on 11/1/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//
/*
 This file contains all api urls and api configrations
 */

import Foundation

// MARK: Request types
let GET_REQUEST  = "GET"
let POST_REQUEST = "POST"

// MARK: Custom error codes
let GENERAL_ERROR_CODE = 30001

// MARK: jobs.github.com/positions.json Github jobs api url with its params configration
public func API_URL_GITHUB(query:String, lat:Double, lon:Double) -> String {

    // this line to replace the space to + as it is mentioned in the api documentation
    let query = query.replacingOccurrences(of: " ", with: "+")

    // this will be activated when the user pick a location from the filter screen
    if lat > 0 && lon > 0 {
        return "https://jobs.github.com/positions.json?search=\(query)&lat=\(lat)&long=\(lon)"
    }

    // default return
    return "https://jobs.github.com/positions.json?search=\(query)"
}

// MARK: jobs.search.gov/jobs/search.json gov jobs api url with its params configration
public func API_URL_SEARCH_GOV(query:String, lat:Double, lon:Double) -> String {

    // this line to replace the space to + as it is mentioned in the api documentation
    let query = query.replacingOccurrences(of: " ", with: "+")

    // this will be activated when the user pick a location from the filter screen
    if lat > 0 && lon > 0 {
        let lat_lon = "\(lat),\(lon)"
        return "https://jobs.search.gov/jobs/search.json?query=\(query)&lat_lon=\(lat_lon)"
    }

    // default return
    return "https://jobs.search.gov/jobs/search.json?query=\(query)"
}




