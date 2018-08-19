//
//  MemeMeTableViewCell.swift
//  memeMe
//
//  Created by Andres Yepes on 8/19/18.
//  Copyright © 2018 Andres Yepes. All rights reserved.
//

import UIKit

class MemeMeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var memeView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
