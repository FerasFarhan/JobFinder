//
//  AppDelegate.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/17/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // init Keyboard Manager
        self.setupKeyboardManager()

        // init google places
        self.setupGooglePlaces()

        return true
    }

    // init Keyboard Manager
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }

    // init google places
    func setupGooglePlaces() {
        GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
        GMSServices.provideAPIKey(GOOGLE_API_KEY)
    }

}

