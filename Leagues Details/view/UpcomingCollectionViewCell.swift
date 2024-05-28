//
//  UpcomingCollectionViewCell.swift
//  Sports App
//
//  Created by Haneen Medhat on 18/05/2024.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var firstTeamImg: UIImageView!
    
    @IBOutlet weak var firstTeamLabel: UILabel!
    
    @IBOutlet weak var secondTeamImg: UIImageView!
    
    @IBOutlet weak var secondTeamLabel: UILabel!
    
    @IBOutlet weak var imageIndicator: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        // Customize the cell here
        contentView.layer.borderWidth = 2.0

        contentView.layer.cornerRadius = 20.0 // Adjust the corner radius as needed
        contentView.layer.masksToBounds = true
    }

}

