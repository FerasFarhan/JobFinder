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

class PSJobsFiltersViewController: UIViewController {

    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!

    var selectedPlace:GMSPlace!

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initView()
        self.getLocation()
    }
    
    func initView() {
        self.title = "Find Jobs"
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

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
            if let place = self.selectedPlace {
                destination.lat = place.coordinate.latitude
                destination.lon = place.coordinate.longitude
            }

            var query = ""

            if let company = self.companyNameTextField.text {
                query = company
            }

            if let jobTitle = self.jobTitleTextField.text {
                if query.count > 0 {
                    query = query + "+" + jobTitle
                }
                else {
                    query = jobTitle
                }
            }

            destination.query = query
        }
    }


    @IBAction func locationButtonPressed() {
        self.view.endEditing(true)
        let config = GMSPlacePickerConfig (viewport: nil)
        let placePicker = GMSPlacePickerViewController (config: config)
        placePicker.delegate = self
        self.present (placePicker, animated: true, completion: nil)
    }

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

    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)

        print("No place selected")
    }

}
