//
//  TBMainBusinessManager.swift
//  Techband
//
//  Created by Feras Farhan on 11/1/19.
//  Copyright © 2019 Techband. All rights reserved.
//

import UIKit

typealias TBGeneralBusinessManagerCompletionHandler = (NSError?, String?, NSArray) -> Void

class TBMainBusinessManager {

    // MARK: /jobs.github.com/positions.json API
    func getGithubJobs (completionHandler:@escaping TBGeneralBusinessManagerCompletionHandler) {

        let url = API_URL_GITHUB

        TBLogManager.printURL(url as AnyObject?, senderClass: self.self)

        TBConnectionManager().initWithUrl(url, postParameters: nil, requestType: GET_REQUEST) { (error,message, resultArray) in

            if error == nil ,
                resultArray.count > 0,
                let tempo = resultArray[0] as? [NSDictionary] {
                //completionHandler(nil, message, [object])
            }
            else{
                completionHandler(NSError(domain: "api error", code: GENERAL_ERROR_CODE, userInfo: nil), "somthing went wrong", [])
            }
        }
    }

}



