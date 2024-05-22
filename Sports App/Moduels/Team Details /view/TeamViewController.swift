//
//  TeamViewController.swift
//  Sports App
//
//  Created by Mayar on 21/05/2024.
//

import UIKit
import Reachability

class TeamViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TeamDetailsTableViewCell
        cell.playerInfoInCellLabel.text = "15"
        cell.playerNameInCellLabel.text = "Mayar"
        cell.playereImageInCell.image = UIImage(named: "t.jpg")
        
//
//        let placeholderImage = UIImage(named: "load.jpg")
//        cell.imageView?.kf.setImage(with: URL(string: movie.image), placeholder: placeholderImage)
//        
        return cell
    }
    
    
    var teamVM : TeamViewModel!
    var teamInfo  = TeamResponse(result: [TeamMemberAndInformation(team_name: "No Aviable data", team_logo:"logo", teamMember:[])])
    var newtworkIndicator : UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        teamVM = TeamViewModel()
        
        newtworkIndicator = UIActivityIndicatorView (style: .large)
        newtworkIndicator!.center = view.center
        newtworkIndicator!.startAnimating()
        view.addSubview(newtworkIndicator!)
       
        
        // newtworkIndicator!.startAnimating()
        
        
       let reachability = try! Reachability()
        if reachability.connection == .unavailable{
            self.showAlert(message: "Please Check your network")
        } else {
                teamVM?.bindResultToViewController = { [weak self] in
                 DispatchQueue.main.async {
                     self?.teamInfo = self?.teamVM!.teamDetails ?? TeamResponse(result: [TeamMemberAndInformation(team_name: "No Aviable data", team_logo:"logo", teamMember:[])])
                       print("Fetched teamInfo in view controller: \(String(describing: self?.teamInfo.result.first?.team_name))")
                                                         
                     // self?.tableView.reloadData()
                                  // self?.newtworkIndicator?.stopAnimating()
                }
            }
        }
    }
    
    func showAlert (message:String ){
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }

}
