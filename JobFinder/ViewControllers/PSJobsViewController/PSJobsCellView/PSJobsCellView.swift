//
//  PSJobsCellView.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/17/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit

class PSJobsCellView: UITableViewCell {

    @IBOutlet weak var companyLogoImageView: UIImageView!
    @IBOutlet weak var jobTitleLbl: UILabel!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var postdateLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
