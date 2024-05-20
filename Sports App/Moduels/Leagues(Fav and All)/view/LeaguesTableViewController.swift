//
//  LeaguesTableViewController.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import UIKit

class LeaguesTableViewController: UITableViewController {

    var leaguesArray = [Leagues]()
    var comeFromFav : Bool?
    var sportName: String?

    var leguesViewModel : LeguesViewModel?

    
    var newtworkIndicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leguesViewModel = LeguesViewModel()

        newtworkIndicator = UIActivityIndicatorView (style: .large)
        newtworkIndicator!.center = view.center
        newtworkIndicator!.startAnimating()
        view.addSubview(newtworkIndicator!)
        newtworkIndicator!.startAnimating()
        
        if let sportName = sportName {
                print("Selected sport: \(sportName)")
                let lowercaseSportName = sportName.lowercased()
                print("Selected sport after: \(lowercaseSportName)")
                
                leguesViewModel?.getDataFromAPI(lowercaseSportName: sportName)
                leguesViewModel?.bindResultToViewController = { [weak self] in
                    DispatchQueue.main.async {
                        self?.leaguesArray = self?.leguesViewModel?.allLegues ?? []
                        print("Fetched leagues in view controll: \(String(describing: self?.leaguesArray))")
                        
                        self?.tableView.reloadData()
                        self?.newtworkIndicator?.stopAnimating()
                    }
                }

        }else if comeFromFav ?? false {
//         leaguesArray = call local function   from LeguesViewModel
            tableView.reloadData()
            newtworkIndicator?.stopAnimating()
        }
            
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
            
        // the following for testing only
//        leaguesArray = [
//            Leagues(name: "Football", image: "url1", youTube: "https://www.youtube.com/watch?v=5I7UApFUyc8"),
//            Leagues(name: "Football", image: "url2", youTube: "https://www.facebook.com/gazaishereofficial/"),
//            Leagues(name: "Football", image: "url3", youTube: "link1"),
//            Leagues(name: "Football", image: "url4", youTube: "link1"),
//            Leagues(name: "Football", image: "url5", youTube: "link1")]
  }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for:indexPath) as! LeaguesTableViewCell
        let leagues = leaguesArray[indexPath.row]
        cell.setUp(name: leagues.league_name!, imageUrl: leagues.league_logo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard = UIStoryboard(name: "", bundle: nil)
//        let legaguesDetails = storyBoard.instantiateViewController(withIdentifier: "details")
//        present(legaguesDetails,animated: true)
//    
    }
}


