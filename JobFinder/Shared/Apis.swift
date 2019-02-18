//
//  TBApi.swift
//  Techband
//
//  Created by Feras Farhan on 11/1/19.
//  Copyright © 2019 Techband. All rights reserved.
//

import Foundation

// MARK: Request types
let GET_REQUEST  = "GET"
let POST_REQUEST = "POST"

let GENERAL_ERROR_CODE = 30001

// MARK: API CONFIGURATION
public func API_URL_GITHUB(query:String, lat:Double, lon:Double) -> String {

    let query = query.replacingOccurrences(of: " ", with: "+")

    if lat > 0 && lon > 0 {
        return "https://jobs.github.com/positions.json?search=\(query)&lat=\(lat)&long=\(lon)"
    }

    return "https://jobs.github.com/positions.json?search=\(query)"
}

public func API_URL_SEARCH_GOV(query:String, lat:Double, lon:Double) -> String {

    let query = query.replacingOccurrences(of: " ", with: "+")

    if lat > 0 && lon > 0 {
        let lat_lon = "\(lat),\(lon)"
        return "https://jobs.search.gov/jobs/search.json?query=\(query)&lat_lon=\(lat_lon)"
    }

    return "https://jobs.search.gov/jobs/search.json?query=\(query)"
}




