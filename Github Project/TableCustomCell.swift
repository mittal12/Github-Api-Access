//
//  TableCustomCell.swift
//  Github Project
//
//  Created by Ashish Mittal  on 28/04/17.
//  Copyright © 2017 Ashish Mittal . All rights reserved.
//

import UIKit

class TableCustomCell: UITableViewCell {

    
    @IBOutlet weak var PersonImage: UIImageView!
    
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var secondName: UILabel!
    
    
    @IBOutlet weak var thirdName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.PersonImage.layer.cornerRadius = self.PersonImage.frame.size.width/2
        self.PersonImage.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
