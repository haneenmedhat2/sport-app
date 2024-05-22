//
//  TeamViewController.swift
//  Sports App
//
//  Created by Mayar on 21/05/2024.
//

import UIKit
import Reachability
import Kingfisher

class TeamViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
   
    var sportName : String?
    var teamKey : String?
    
    
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    var teamVM : TeamViewModel!
    var teamInfo  = TeamResponse(result: [TeamMemberAndInformation(team_name: "No Aviable data", team_logo:"logo", players: [])])
    var newtworkIndicator : UIActivityIndicatorView?
    var placeholderImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamVM = TeamViewModel()
        
        newtworkIndicator = UIActivityIndicatorView (style: .large)
        newtworkIndicator!.center = view.center
        newtworkIndicator!.startAnimating()
        view.addSubview(newtworkIndicator!)
        newtworkIndicator!.startAnimating()
        
        
        placeholderImageView = UIImageView(image: UIImage(named: "noData"))
        placeholderImageView.contentMode = .scaleAspectFit
        placeholderImageView.center = view.center
        tableView.backgroundView = placeholderImageView
        
        
       let reachability = try! Reachability()
        if reachability.connection == .unavailable{
            self.showAlert(message: "Please Check your network")
        } else {
            
            // real after screen connect
            //   teamVM.getTeamDataFromAPI(sportName: sportName, teamKey: teamKey)

            //fake data
            teamVM.getTeamDataFromAPI(sportName: "football", teamKey: 7)
                                   
                teamVM?.bindResultToViewController = { [weak self] in
                 DispatchQueue.main.async {
                     self?.teamInfo = self?.teamVM!.teamDetails ?? TeamResponse(result: [TeamMemberAndInformation(team_name: "No Aviable data", team_logo:"logo", players: [])])
                       print("Fetched teamInfo in view controller: \(String(describing: self?.teamInfo.result.first?.team_name))")
                     self?.teamNameLabel.text = self?.teamInfo.result[0].team_name
                     
                     self?.teamLogo?.kf.setImage(with: URL(string: self?.teamInfo.result[0].team_logo ?? "https://chiefexecutive.net/wp-content/uploads/2016/06/GettyImages-75404984-compressor.jpg"))
                     
                     
                     self?.tableView.reloadData()
                     self?.newtworkIndicator?.stopAnimating()
                }
            }
        }
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let count = teamInfo.result.first?.players?.count ?? 0
         
         placeholderImageView.isHidden = count > 0
         return count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TeamDetailsTableViewCell
         var player = teamInfo.result.first?.players?[indexPath.row]
         cell.playerInfoInCellLabel.text =  player?.player_type
         cell.playerNameInCellLabel.text = player?.player_name
         let placeholderImage = UIImage(named: "load.jpg")
         cell.playereImageInCell?.kf.setImage(with: URL(string: player?.player_image ?? "https://adminassets.devops.arabiaweather.com/sites/default/files/field/image/Captain--9-1-2024Tsubasa.jpeg"), placeholder: placeholderImage)
         return cell
     }
     
    
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = .lightGray

           let headerLabel = UILabel()
           headerLabel.text = "Team Members:"
           headerLabel.textAlignment = .left
           headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
           headerLabel.translatesAutoresizingMaskIntoConstraints = false

           headerView.addSubview(headerLabel)
           NSLayoutConstraint.activate([
                     headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                     headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
                 ])

           return headerView
       }

       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50
       }
    
    
    func showAlert (message:String ){
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }

}
