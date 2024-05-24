//
//  AgainHomeCollectionViewCell.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import UIKit

class AgainHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func setUpCell (name : String , photo : UIImage){
        nameLabel.text = name
        image .image = photo

    }
    
}
