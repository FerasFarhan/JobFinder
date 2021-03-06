//
//  PSSplashViewController.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/17/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit

class PSSplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // show the splash for 2 seconds and move to jobs filter view
        self.perform(#selector(startApp), with: nil, afterDelay: 2)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @objc fileprivate func startApp() {
        self.performSegue(withIdentifier: "goToJobs", sender: nil)
    }
}

