//
//  PSJobsViewController.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/17/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import DGActivityIndicatorView

class PSJobsViewController: UIViewController {

    @IBOutlet weak var activityView : DGActivityIndicatorView!
    @IBOutlet weak var listTableView:UITableView!
    @IBOutlet weak var noDataLable:UILabel!

    var gitHubJobsArray = [PSGitHubJobObject]()
    var searchGovArray = [PSSearchGovObject]()

    var isGithubOnly = false
    var isSearchGovOnly = false

    var query = ""
    var lat:Double = 0
    var lon:Double = 0

    override func viewDidLoad() {
        self.title = "Jobs Search Results"
        super.viewDidLoad()
        self.customizeActivityIndicatorView()

        // if gov only filter available search gov jobs only and you can find the check of github only filter in this function getGithubJobs
        if self.isSearchGovOnly {
            self.getSearchGovJobs()
        }
        else {
            self.getGithubJobs()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // called here to show the nav bar for each viewWillAppear
        self.initView()
    }

    // self.view customizations
    func initView() {
        self.navigationItem.hidesBackButton = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // setup loading indicator view
    func customizeActivityIndicatorView() {
        self.activityView.type = DGActivityIndicatorAnimationType.ballScaleRippleMultiple
        self.activityView.tintColor = .black
        self.activityView.size = 40.0
        self.activityView.backgroundColor = .clear
        self.activityView.startAnimating()
    }

    // Get Github Jobs as the first api call
    func getGithubJobs() {

        // show loading and hide the rest components
        self.activityView.isHidden = false
        self.listTableView.isHidden = true
        self.noDataLable.isHidden = true

        TBMainBusinessManager().getGithubJobs(query: self.query, lat: self.lat, lon: self.lon) { (error, message, resultArray) in

            // Internet reachability faild check, if true show internet message
            if !Reachability.isConnectedToNetwork() {
                self.noDataLable.text = "Please check your internet connection"
                self.activityView.isHidden = true
                self.listTableView.isHidden = true
                self.noDataLable.isHidden = false
            }
            else {
                // fill gitHubJobsArray if there is no error and there is data :)
                if error == nil,
                    resultArray.count > 0,
                    let tempArray = resultArray[0] as? [PSGitHubJobObject] {
                    self.gitHubJobsArray = tempArray
                }

                // show table view if there are data returned from Github Jobs
                if self.gitHubJobsArray.count > 0 {
                    self.activityView.isHidden = true
                    self.listTableView.isHidden = false
                    self.noDataLable.isHidden = true
                    self.listTableView.reloadData()
                }

                if !self.isGithubOnly {
                    // call search gov jobs after finishing the first call if there is no filter on github only
                    self.getSearchGovJobs()
                }

            }
        }
    }

    // Get Search Gov as a second call api call
    func getSearchGovJobs() {

        TBMainBusinessManager().getSearchGovJobs(query: self.query, lat: self.lat, lon: self.lon) { (error, message, resultArray) in

            // Internet reachability faild check, if true show internet message
            if !Reachability.isConnectedToNetwork() {
                self.noDataLable.text = "Please check your internet connection"
                self.activityView.isHidden = true
                self.listTableView.isHidden = true
                self.noDataLable.isHidden = false
            }
            else {

                // fill searchGovArray if there is no error and there is data :)
                if error == nil,
                    resultArray.count > 0,
                    let tempArray = resultArray[0] as? [PSSearchGovObject] {
                    self.searchGovArray = tempArray
                }

                // show table view if there are data returned from one of data providers
                if self.searchGovArray.count > 0 || self.gitHubJobsArray.count > 0 {
                    self.activityView.isHidden = true
                    self.listTableView.isHidden = false
                    self.noDataLable.isHidden = true
                    self.listTableView.reloadData()

                    let jobCount = self.gitHubJobsArray.count + self.searchGovArray.count

                    if jobCount > 1 {
                        self.title = "\(jobCount) Jobs Found"
                    }
                    else {
                        self.title = "\(jobCount) Job Found"
                    }
                }
                else {
                    self.noDataLable.text = "No Available Data"
                    self.activityView.isHidden = true
                    self.listTableView.isHidden = true
                    self.noDataLable.isHidden = false
                }
            }
        }
    }
}

extension PSJobsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // section header customization to show the data provider
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))

        if section == 0 {
            lable.text = " GitHub Jobs"
        }
        else {
            lable.text = " Search Gov Jobs"
        }

        lable.backgroundColor = .gray
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .white
        lable.textAlignment = .left

        return lable
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        // this to hide github section is there are no data
        if section == 0 && self.gitHubJobsArray.count == 0 {
            return 0
        }

        // this to hide search gov section is there are no data
        if section == 1 && self.searchGovArray.count == 0 {
            return 0
        }

        // default value
        return 30
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // 0 is github jobs section and 1 is search gov section
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // github jobs section
        if section == 0 {
            return self.gitHubJobsArray.count
        }

        // search gov section
        return self.searchGovArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "PSJobsCellView") as? PSJobsCellView

        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("PSJobsCellView", owner: self, options: nil)!.last as? PSJobsCellView
        }

        // github jobs section
        if indexPath.section == 0 {
            let object = self.gitHubJobsArray[indexPath.row]
            cell!.gitHubJobObject = object

            return cell!
        }

        // search gov section
        let object = self.searchGovArray[indexPath.row]
        cell!.searchGovObject = object

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // this will redirect the user to the detail URL
        var urlString = ""

        if indexPath.section == 0 {
            let object = self.gitHubJobsArray[indexPath.row]
            urlString = object.url
        }
        else {
            let object = self.searchGovArray[indexPath.row]
            urlString = object.url
        }

        // using general helper open url
        TBGeneralHelper.shared.openURL(urlString: urlString, sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }

    
}
