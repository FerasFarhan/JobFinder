//
//  PSJobsCellView.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/17/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import SDWebImage

class PSJobsCellView: UITableViewCell {

    @IBOutlet weak var companyLogoImageView: UIImageView!
    @IBOutlet weak var jobTitleLbl: UILabel!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var postdateLbl: UILabel!

    var gitHubJobObject:PSGitHubJobObject! {
        didSet {
            if let stURL = URL(string: gitHubJobObject.company_logo) {
                self.companyLogoImageView.sd_setImage(with: stURL) { (image, error, SDIm, url) in
                    if error != nil || image == nil {
                        self.companyLogoImageView.image = UIImage(named: "default_image")
                    }
                }
            }

            self.jobTitleLbl.text = self.gitHubJobObject.title
            self.companyNameLbl.text = self.gitHubJobObject.company
            self.locationLbl.text = self.gitHubJobObject.location
            self.postdateLbl.text = self.gitHubJobObject.created_at
        }
    }

    var searchGovObject:PSSearchGovObject! {
        didSet {

            self.companyLogoImageView.image = UIImage(named: "default_image")
            
            self.jobTitleLbl.text = self.searchGovObject.position_title
            self.companyNameLbl.text = self.searchGovObject.organization_name

            if self.searchGovObject.locations.count > 0 {
                self.locationLbl.text = self.searchGovObject.locations[0]
            }

            self.postdateLbl.text = self.searchGovObject.start_date
        }
    }
}
