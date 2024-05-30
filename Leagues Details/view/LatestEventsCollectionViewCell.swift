//
//  LatestEventsCollectionViewCell.swift
//  Sports App
//
//  Created by Haneen Medhat on 18/05/2024.
//

import UIKit

class LatestEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var firstTeamImg: UIImageView!
    
    @IBOutlet weak var firstTeamLabel: UILabel!
    
    @IBOutlet weak var secondTeamImg: UIImageView!
    
    @IBOutlet weak var secondTeamLabel: UILabel!

    @IBOutlet weak var imgIndicator: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.layer.borderWidth = 1.0
          contentView.layer.borderColor = UIColor.black.cgColor // Set the border color as needed
          contentView.layer.cornerRadius = 20.0 // Adjust the corner radius as needed
          contentView.layer.masksToBounds = true

          // Set the background color of the contentView
          contentView.backgroundColor = UIColor.white // Set your desired background color
          
          // Set the cell's background color to clear
          self.backgroundColor = UIColor.clear
    }

}


