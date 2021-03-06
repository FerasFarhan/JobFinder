
//
//  TBConnectionManager.swift
//  JobFinder
//
//  Created by Feras Farhan on 11/1/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

/*
 This manager contains handlers for all api call across the app level using Alamofire

 https://github.com/Alamofire/Alamofire
 */

import UIKit
import Alamofire

typealias TBConnectionManagerCompletionHandler = (_ error:NSError?,_ message:String,_ resultArray:NSArray) -> Void

class TBConnectionManager: NSObject {

    var url = ""
    var postParameters:[String: AnyObject]?
    var resultHandler:TBConnectionManagerCompletionHandler?
    var headers = ["content-type" : "application/x-www-form-urlencoded"]

    internal func initWithUrl(_ url:String,
                              postParameters:[String: AnyObject]?,
                              requestType:String,
                              resultHandler:@escaping TBConnectionManagerCompletionHandler){

        self.url = url
        self.resultHandler = resultHandler
        self.postParameters = postParameters

        if requestType == GET_REQUEST {
            startGET()
        }
        else {
            startPOST()
        }
    }

    /*
     GET api call across the app level
     */

    fileprivate func startGET(){

        let manager = Alamofire.SessionManager.default

        manager.request(self.url,
                        method: .get,
                        parameters: self.postParameters,
                        encoding: URLEncoding.default,
                        headers: headers).responseJSON
            { response in

                switch response.result {

                case .success(let JSON):

                    let resultArray = NSMutableArray()

                    if JSON is NSDictionary {
                        resultArray.add(JSON)
                    }
                    else{
                        resultArray.setArray([JSON])
                    }

                    TBLogManager.printResponse(resultArray, url: self.url as AnyObject, senderClass: self.self)


                    if let res = self.resultHandler {
                        res(nil,"success", resultArray)
                    }

                case .failure(let error):


                    TBLogManager.printLog("Request failed with error", object: error as AnyObject?, senderClass: self.self)

                    if let data = response.data {
                        let value = "\(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)"
                        TBLogManager.printLog("response.result.value", object: value as AnyObject?, senderClass: self.self)
                    }

                    if let res = self.resultHandler {
                        res(error as NSError?,"somthing went wrong", [])
                    }
                }
        }
    }

    /*
     POST api call
     */
    fileprivate func startPOST() {
        
        let manager = Alamofire.SessionManager.default

        manager.request(self.url,
                        method: .post,
                        parameters: self.postParameters,
                        encoding: URLEncoding.default,
                        headers: headers).responseJSON
            { response in

                switch response.result {

                case .success(let JSON):


                    let resultArray = NSMutableArray()

                    if JSON is NSDictionary {
                        resultArray.add(JSON)
                    }
                    else{
                        resultArray.setArray([JSON])
                    }

                    TBLogManager.printResponse(resultArray, url: self.url as AnyObject, senderClass: self.self)

                    if let res = self.resultHandler {
                        res(nil, "success" , resultArray)
                    }

                case .failure(let error):


                    TBLogManager.printLog("Request failed with error", object: error as AnyObject?, senderClass: self.self)

                    if let data = response.data {
                        let value = "\(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)"
                        TBLogManager.printLog("response.result.value", object: value as AnyObject?, senderClass: self.self)
                    }

                    if let res = self.resultHandler {
                        res(error as NSError?, "somthing went wrong", [])
                    }

                }
        }
    }
}
