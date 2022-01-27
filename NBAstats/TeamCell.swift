//
//  TeamCell.swift
//  NBAstats
//
//  Created by Ryan Chevarria on 1/20/22.
//

import UIKit

class TeamCell: UITableViewCell {
    
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
