//
//  PersonDetailTableViewCell.swift
//  JsonDownloadDemo
//
//  Created by Kaha on 05/12/18.
//  Copyright © 2018 Hari Krushna. All rights reserved.
//

import UIKit

class PersonDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var imageviewProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellData(personDetail: Person)  {
        labelName.text = "\(personDetail.firstName ?? "" + personDetail.lastName! )"
       labelEmail.text = personDetail.email
        imageviewProfile.loadImageUsingCacheWithURLString(personDetail.profileUrl ?? "", placeHolder: UIImage(named: "defaultProfile")) { (_) in
        }
    }
}
