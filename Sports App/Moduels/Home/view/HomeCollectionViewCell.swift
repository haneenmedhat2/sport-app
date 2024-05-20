//
//  HomeCollectionViewCell.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setUpCell (name : String , photo : UIImage){
        label.text = name
        image .image = photo

    }
    
}
