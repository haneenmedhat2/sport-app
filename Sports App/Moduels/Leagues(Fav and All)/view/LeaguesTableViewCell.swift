//
//  LeaguesTableViewCell.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import UIKit
import Kingfisher
import SafariServices

class LeaguesTableViewCell: UITableViewCell {

    var youTubeLink : String?
    
    @IBOutlet weak var legImageView: UIImageView!
     @IBOutlet weak var secondImageView: UIButton!
     @IBOutlet weak var labelText: UILabel!
    
  
    func setUp (name: String , imageUrl: String?)
    {
        labelText.text = name
        // to make the photo circular and edddddddddddddddddddit in image attributes
       
        guard let imageUrl = imageUrl else {return }
        if let url = URL(string: imageUrl) {
            legImageView.kf.setImage(with: url, placeholder: UIImage(named: "l"))
        }
    }

     override func layoutSubviews() {
         super.layoutSubviews()
         legImageView.layer.masksToBounds = false
         legImageView.layer.cornerRadius = legImageView.frame.height / 2
         legImageView.clipsToBounds = true
     }
    
    
    @IBAction func youTubeButton(_ sender: UIButton) {
            guard let urlString = youTubeLink,
                  let url = URL(string: urlString),
                  ["http", "https"].contains(url.scheme?.lowercased()) else {
                // Display alert for invalid URL
                showAlert()
                return
            }
            
            let safariViewController = SFSafariViewController(url: url)
            
            // Present the SFSafariViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
            }
        }

        func showAlert() {
            let alert = UIAlertController(title: "Alert", message: "Sorry, no available YouTube link", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }

}
