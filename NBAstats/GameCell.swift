//
//  GameCell.swift
//  NBAstats
//
//  Created by Ryan Chevarria on 1/20/22.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var visitorImage: UIImageView!
    
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var visitorScore: UILabel!
    
    
    // GameCell outlets for scheduled games
    
    @IBOutlet weak var dateLabelSche: UILabel!
    @IBOutlet weak var homeImageSche: UIImageView!
    @IBOutlet weak var visitorImageSche: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var visitorTeamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
