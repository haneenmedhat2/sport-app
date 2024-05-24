//
//  TeamDetailsTableViewCell.swift
//  Sports App
//
//  Created by Mayar on 22/05/2024.
//

import UIKit

class TeamDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var playereImageInCell: UIImageView!

    @IBOutlet weak var playerNameInCellLabel: UILabel!

    @IBOutlet weak var playerInfoInCellLabel: UILabel!

    
    override func layoutSubviews() {
        super.layoutSubviews()
        playereImageInCell.layer.masksToBounds = false
        playereImageInCell.layer.cornerRadius = playereImageInCell.frame.height / 2
        playereImageInCell.clipsToBounds = true
    }
   
}
