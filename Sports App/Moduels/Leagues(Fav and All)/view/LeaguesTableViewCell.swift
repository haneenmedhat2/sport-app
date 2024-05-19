//
//  LeaguesTableViewCell.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import UIKit
// import Kingfisher
import SafariServices


class LeaguesTableViewCell: UITableViewCell {

    var youTubeLink : String?
    
    @IBOutlet weak var legImageView: UIImageView!
     @IBOutlet weak var secondImageView: UIButton!
     @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUp (name: String , imageUrl: String,youTubeUrl: String)
    {
        labelText.text = name
        youTubeLink = youTubeUrl
       // setimage by url alamofire
//        if let url = URL(string: url) {
//            image.kf.setImage(with: url, placeholder: UIImage(named: "noImage"))
//        }
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
