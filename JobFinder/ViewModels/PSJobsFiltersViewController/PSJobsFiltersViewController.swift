//
//  PSJobsFiltersViewController.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/18/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker
import CoreLocation
import DropDown

class PSJobsFiltersViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var providerTextField: UITextField!
    @IBOutlet weak var providerButton: UIButton!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!

    // google places object, defalut is nil
    var selectedPlace:GMSPlace!

    // CLLocationManager to get location to be used in google places
    var locationManager = CLLocationManager()

    // DropDown view
    let dropDown = DropDown()

    // Provider filter flags
    var isGithubOnly = false
    var isSearchGovOnly = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // called here to hide the nav bar for each viewWillAppear
        self.initView()

        // get location to be used in google places
        self.getLocation()
    }

    // self.view customizations
    func initView() {
        self.title = "Find Jobs"
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Drop Down View customizations
        self.setupDropDownView()
    }

    // Drop Down View customizations
    func setupDropDownView() {
        // The view to which the drop down will appear on
        dropDown.anchorView = self.providerButton // Provider Button

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["All Providers", "GitHub Jobs", "Gov Jobs"]

        // Action triggered on selection
        dropDown.selectionAction = { (index: Int, item: String) in

            self.providerTextField.text = item

            if index == 0 { // All Providers selected
                self.isGithubOnly = false
                self.isSearchGovOnly = false
            }
            else if index == 1 { // GitHub Jobs selected
                self.isGithubOnly = true
                self.isSearchGovOnly = false
            } // Gov Jobs selected
            else{
                self.isGithubOnly = false
                self.isSearchGovOnly = true
            }

            self.dropDown.hide()
        }
    }

    // location manager initialization and requesting the locaiton from user
    func getLocation() {

        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied {
                // CLAuthorizationStatus.denied
            }
            else if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse {
                self.locationManager.requestWhenInUseAuthorization()
            }
            else{
                self.locationManager.startUpdatingLocation()
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToJobsView", let destination = segue.destination as? PSJobsViewController {

            // set selected place if available
            if let place = self.selectedPlace {
                destination.lat = place.coordinate.latitude
                destination.lon = place.coordinate.longitude
            }

            // set position title if available
            if let query = self.jobTitleTextField.text {
                destination.query = query
            }

            // set isGithubOnly flag default is false
            destination.isGithubOnly = self.isGithubOnly

            // set isSearchGovOnly flag default is false
            destination.isSearchGovOnly = self.isSearchGovOnly
        }
    }

    // show Google Places Picker
    @IBAction func locationButtonPressed() {
        self.view.endEditing(true)
        let config = GMSPlacePickerConfig (viewport: nil)
        let placePicker = GMSPlacePickerViewController (config: config)
        placePicker.delegate = self
        self.present (placePicker, animated: true, completion: nil)
    }

    // show drop down
    @IBAction func providerButtonPressed() {
        self.view.endEditing(true)
        self.dropDown.show()
    }

    // move to jobs view controller, all filters are optional
    @IBAction func findJobsButtonPressed() {
        self.performSegue(withIdentifier: "goToJobsView", sender: nil)
    }
}

extension PSJobsFiltersViewController: GMSPlacePickerViewControllerDelegate {

    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)

        print("Place name \(place.name)")
        print("Place address \(String(describing: place.formattedAddress))")
        self.locationTextField.text = place.name
        self.selectedPlace = place
        self.locationTextField.text = self.selectedPlace.name
    }

    // do nothing
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)

        print("No place selected")
    }

}
