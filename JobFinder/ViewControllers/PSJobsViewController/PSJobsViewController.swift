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

    var gitHubJobsArray = [PSGitHubJobObject]()
    var searchGovArray = [PSSearchGovObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeActivityIndicatorView()
    }

    func customizeActivityIndicatorView() {
        self.activityView.type = DGActivityIndicatorAnimationType.ballScaleRippleMultiple
        self.activityView.tintColor = .red
        self.activityView.size = 40.0
        self.activityView.isHidden = false
        self.activityView.startAnimating()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PSJobsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))

        if section == 0 {
            lable.text = "GitHub Jobs"
        }
        else {
            lable.text = "Search Gov Jobs"
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

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
}
