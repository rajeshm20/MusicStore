//
//  TrackTableViewCell.swift
//  MusicStore
//
//  Created by RNSS on 10/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    @IBOutlet weak var unitPriceLabel: UILabel!
    
    @IBOutlet weak var bytesLabel: UILabel!
//    @IBOutlet weak var millisecondsLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var mediaType: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var composerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
