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
let TIMEOUT_ERROR_CODE = 30002
let API_ERROR_CODE     = 30003
let CUSTOM_ERROR_CODE  = 30004

// MARK: API CONFIGURATION
let API_URL_GITHUB = "https://jobs.github.com/positions.json"
let API_URL_SEARCH_GOV = "https://www.anthiss.com/api/v2"
