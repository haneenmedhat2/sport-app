//
//  LeaguesTableViewController.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import UIKit
import Reachability

class LeaguesTableViewController: UITableViewController {
    
    var leaguesArray = [Leagues]()
    var sportName: String?
    
    var leguesViewModel : LeguesViewModel?
    
    var newtworkIndicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leguesViewModel = LeguesViewModel()
        self.title = "ALL Leagues"

        newtworkIndicator = UIActivityIndicatorView (style: .large)
        newtworkIndicator!.center = view.center
        newtworkIndicator!.startAnimating()
        view.addSubview(newtworkIndicator!)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newtworkIndicator!.startAnimating()
        
        if let sportName = sportName {
            
            if sportName == "Hockey" || sportName == "Baseball" || sportName == "American" || sportName == "American Football" {
                print (" is name of not data")
                newtworkIndicator?.stopAnimating()
                showAlert(message: "Sorry No Available Data For This Sport")
                
            }else {
                print (" from home ")

                let lowercaseSportName = sportName.lowercased()
                let reachability = try! Reachability()
                if reachability.connection == .unavailable{
                    showAlert(message: "Open your network to see the leagues")
                }
                leguesViewModel?.getDataFromAPI(lowercaseSportName: lowercaseSportName)
                
                leguesViewModel?.bindResultToViewController = { [weak self] in
                    DispatchQueue.main.async {
                        self?.leaguesArray = self?.leguesViewModel?.allLegues ?? []
                        print("Fetched leagues in view controll: \(String(describing: self?.leaguesArray))")
                        
                      
                        self?.tableView.reloadData()
                        self?.newtworkIndicator?.stopAnimating()
                    }
                }
            }
        } else  {
//            do{
//                try  LocalStorageService.clearAllFavLeagues()
//                print ("delete all")
//            }
//            catch{
//                print (" error in delet all")
//            }
            
            print (" show fav")
            
            leaguesArray = leguesViewModel?.getAllFavLeagues() ?? []
            print (" fetch from data from data \(leaguesArray)")

            tableView.reloadData()
            newtworkIndicator?.stopAnimating()
        }
        
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
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
            
            let selectedleague = leaguesArray[indexPath.row]
            let storyBoard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
            let legaguesDetailsScreen = storyBoard.instantiateViewController(withIdentifier: "leg") as! LeaguesCollectionViewController
            
            if let sportName = sportName {
                legaguesDetailsScreen.sportName = sportName.lowercased()
                legaguesDetailsScreen.legKey = selectedleague.league_key!
                
            }else {
                legaguesDetailsScreen.sportName = selectedleague.sportName!
                legaguesDetailsScreen.legKey = selectedleague.league_key!
                legaguesDetailsScreen.comeFromFav = true
            }
            
            legaguesDetailsScreen.modalPresentationStyle = .fullScreen
            present(legaguesDetailsScreen,animated: true)
        }else {
            print("Internet is off")
            showAlert (message:" Open your network to show the details of leagues")
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return sportName == nil
       }
    
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let selectedleague = leaguesArray[indexPath.row]
        if editingStyle == .delete {
            
            leguesViewModel?.deleteLeague(leagueKey: selectedleague.league_key!)
            
            leaguesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    
    func showAlert (message:String ){
        newtworkIndicator?.stopAnimating()

        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
//            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}



