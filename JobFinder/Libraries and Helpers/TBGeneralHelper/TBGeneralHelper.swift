//
//  TBGeneralHelper.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/18/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import SafariServices

class TBGeneralHelper: NSObject {

    // singleton to access this class with minimum memory usage
    static let shared = TBGeneralHelper()

    // open url general helper function that can be accesed from all classes
    func openURL(urlString: String, sender:UIViewController) {

        if let url = URL(string: urlString) {
            let svc = SFSafariViewController(url: url)
            sender.present(svc, animated: true, completion: nil)
        }
        else {
            TBLogManager.printLog("error urlString = ", object: urlString as AnyObject?, senderClass: self.self)
            self.showAlertView(title: "Oops!", message: "Details unavailable right now, please try again later", sender: sender)
        }
    }

    // open url general helper function that can be accesed from all classes
    func showAlertView(title:String, message:String, sender:UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed Ok");
        }

        alertController.addAction(okAction)
        sender.present(alertController, animated: true, completion: nil)
    }
}


