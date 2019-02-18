//
//  PSJobsViewController.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/17/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import DGActivityIndicatorView
import SafariServices

class PSJobsViewController: UIViewController {

    @IBOutlet weak var activityView : DGActivityIndicatorView!
    @IBOutlet weak var listTableView:UITableView!
    @IBOutlet weak var noDataLable:UILabel!

    var gitHubJobsArray = [PSGitHubJobObject]()
    var searchGovArray = [PSSearchGovObject]()

    override func viewDidLoad() {
        self.title = "Jobs Results"
        super.viewDidLoad()
        self.initView()
        self.customizeActivityIndicatorView()
        self.getGithubJobs()
    }

    func initView() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func customizeActivityIndicatorView() {
        self.activityView.type = DGActivityIndicatorAnimationType.ballScaleRippleMultiple
        self.activityView.tintColor = .black
        self.activityView.size = 40.0
        self.activityView.backgroundColor = .clear
        self.activityView.startAnimating()
    }

    func getGithubJobs() {
        self.activityView.isHidden = false
        self.listTableView.isHidden = true
        self.noDataLable.isHidden = true

        TBMainBusinessManager().getGithubJobs { (error, message, resultArray) in

            if !Reachability.isConnectedToNetwork() {
                self.noDataLable.text = "Please check your internet connection"
                self.activityView.isHidden = true
                self.listTableView.isHidden = true
                self.noDataLable.isHidden = false
            }
            else {
                if error == nil,
                    resultArray.count > 0,
                    let tempArray = resultArray[0] as? [PSGitHubJobObject] {
                    self.gitHubJobsArray = tempArray
                }

                self.getSearchGovJobs()
            }
        }
    }

    func getSearchGovJobs() {

        TBMainBusinessManager().getSearchGovJobs { (error, message, resultArray) in

            if !Reachability.isConnectedToNetwork() {
                self.noDataLable.text = "Please check your internet connection"
                self.activityView.isHidden = true
                self.listTableView.isHidden = true
                self.noDataLable.isHidden = false
            }
            else {
                if error == nil,
                    resultArray.count > 0,
                    let tempArray = resultArray[0] as? [PSSearchGovObject] {
                    self.searchGovArray = tempArray
                }

                if self.searchGovArray.count > 0 || self.gitHubJobsArray.count > 0 {
                    self.activityView.isHidden = true
                    self.listTableView.isHidden = false
                    self.noDataLable.isHidden = true
                    self.listTableView.reloadData()
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
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))

        if section == 0 {
            lable.text = "  GitHub Jobs"
        }
        else {
            lable.text = "  Search Gov Jobs"
        }

        lable.backgroundColor = .gray
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .white
        lable.textAlignment = .left

        return lable
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return self.gitHubJobsArray.count
        }

        return self.searchGovArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "PSJobsCellView") as? PSJobsCellView

        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("PSJobsCellView", owner: self, options: nil)!.last as? PSJobsCellView
        }

        if indexPath.section == 0 {
            let object = self.gitHubJobsArray[indexPath.row]
            cell!.gitHubJobObject = object

            return cell!
        }

        let object = self.searchGovArray[indexPath.row]
        cell!.searchGovObject = object

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var urlString = ""

        if indexPath.section == 0 {
            let object = self.gitHubJobsArray[indexPath.row]
            urlString = object.url
        }
        else {
            let object = self.searchGovArray[indexPath.row]
            urlString = object.url
        }

        self.openURL(urlString: urlString)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }

    func openURL(urlString: String) {

        if let url = URL(string: urlString) {
            let svc = SFSafariViewController(url: url)
            self.present(svc, animated: true, completion: nil)
        }
        else {
            TBLogManager.printLog("error urlString = ", object: urlString as AnyObject?, senderClass: self.self)
            self.showAlertView(title: "Oops!", message: "Details unavailable right now, please try again later")
        }
    }

    func showAlertView(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed Ok");
        }

        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
