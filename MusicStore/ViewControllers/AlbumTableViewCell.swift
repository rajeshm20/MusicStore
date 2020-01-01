//
//  AlbumTableViewCell.swift
//  MusicStore
//
//  Created by RNSS on 28/12/19.
//  Copyright © 2019 RNSS. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet var albumTitleLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        albumTitleLabel.text = ""
        artistNameLabel.text = "By: "
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
