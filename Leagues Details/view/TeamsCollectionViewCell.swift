//
//  TeamsCollectionViewCell.swift
//  Sports App
//
//  Created by Haneen Medhat on 18/05/2024.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImg: UIImageView!
    
    @IBOutlet weak var teamLabel: UILabel!
    
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
          contentView.layer.borderColor = UIColor.black.cgColor
          contentView.layer.cornerRadius = 20.0
          contentView.layer.masksToBounds = true

          contentView.backgroundColor = UIColor.white
         self.backgroundColor = UIColor.clear
    }

}



