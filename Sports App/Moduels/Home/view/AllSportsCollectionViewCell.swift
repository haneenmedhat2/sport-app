//
//  AllSportsCollectionViewCell.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import UIKit

class AllSportsCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var AllSportsImage: UIImageView!
    
    @IBOutlet weak var AllSportsText: UILabel!
    
    func setUpCell (name : String , photo : UIImage){
        AllSportsText.text = name
        AllSportsImage.image = photo

    }
    
}
