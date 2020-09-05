//
//  MovieCell.swift
//  Flix App
//
//  Created by Melissa on 9/1/20.
//  Copyright © 2020 Melissa Ma. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
