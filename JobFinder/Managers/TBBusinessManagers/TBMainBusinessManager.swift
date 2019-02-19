//
//  TBMainBusinessManager.swift
//  Techband
//
//  Created by Feras Farhan on 11/1/19.
//  Copyright © 2019 Techband. All rights reserved.
//

/*
 this class
 */

import UIKit

typealias TBGeneralBusinessManagerCompletionHandler = (NSError?, String?, NSArray) -> Void

class TBMainBusinessManager {

    // MARK: /jobs.github.com/positions.json API
    func getGithubJobs (query:String,
                        lat:Double,
                        lon:Double,
                        completionHandler:@escaping TBGeneralBusinessManagerCompletionHandler) {

        let url = API_URL_GITHUB(query: query,
                                 lat: lat,
                                 lon: lon)

        TBLogManager.printURL(url as AnyObject?, senderClass: self.self)

        TBConnectionManager().initWithUrl(url, postParameters: nil, requestType: GET_REQUEST) { (error,message, resultArray) in

            if error == nil ,
                resultArray.count > 0,
                let tempArray = resultArray[0] as? [NSDictionary] {
                var parsedArray = [PSGitHubJobObject]()

                for dictionary in tempArray {
                    let object = PSGitHubJobObject(dictionary: dictionary)
                    parsedArray.append(object)
                }

                completionHandler(nil, "success", [parsedArray])
            }
            else{
                completionHandler(NSError(domain: "api error", code: GENERAL_ERROR_CODE, userInfo: nil), "somthing went wrong", [])
            }
        }
    }

    // MARK: /jobs.search.gov/jobs/search.json API
    func getSearchGovJobs (query:String,
                           lat:Double,
                           lon:Double,
                           completionHandler:@escaping TBGeneralBusinessManagerCompletionHandler) {

        let url = API_URL_SEARCH_GOV(query: query,
                                     lat: lat,
                                     lon: lon)

        TBLogManager.printURL(url as AnyObject?, senderClass: self.self)

        TBConnectionManager().initWithUrl(url, postParameters: nil, requestType: GET_REQUEST) { (error,message, resultArray) in

            if error == nil ,
                resultArray.count > 0,
                let tempArray = resultArray[0] as? [NSDictionary] {
                var parsedArray = [PSSearchGovObject]()

                for dictionary in tempArray {
                    let object = PSSearchGovObject(dictionary: dictionary)
                    parsedArray.append(object)
                }

                completionHandler(nil, "success", [parsedArray])
            }
            else{
                completionHandler(NSError(domain: "api error", code: GENERAL_ERROR_CODE, userInfo: nil), "somthing went wrong", [])
            }
        }
    }

}



