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
                let lowercaseSportName = sportName.lowercased()

                leguesViewModel?.getDataFromAPI(lowercaseSportName: lowercaseSportName)
                
                leguesViewModel?.bindResultToViewController = { [weak self] in
                    DispatchQueue.main.async {
                        self?.leaguesArray = self?.leguesViewModel?.allLegues ?? []
                        print("Fetched leagues in view controll: \(String(describing: self?.leaguesArray))")
                        let reachability = try! Reachability()
                        if reachability.connection == .unavailable{
                            self?.showAlert(message: "Please Check your network")
                        }
                        //                        if self?.leaguesArray.isEmpty ?? false {
                        //                            self?.showAlert(message: "Please Check your network")
                        //                        }
                        self?.tableView.reloadData()
                        self?.newtworkIndicator?.stopAnimating()
                    }
                }
            }
        } else  {
           // leaguesArray = leguesViewModel?.getAllFavLeagues() ?? []
            tableView.reloadData()
            newtworkIndicator?.stopAnimating()
        }
        
    }
    
    func showAlert (message:String ){
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
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
            print("\(selectedleague.league_key!)")
            print("\(selectedleague.league_name!)     the name of leagues")
            
            // not tested before
             let storyBoard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
             let legaguesDetailsScreen = storyBoard.instantiateViewController(withIdentifier: "leg")
             // legaguesDetailsScreen.sportName = sportName
           //  legaguesDetailsScreen.legKey = selectedleague.league_key
             present(legaguesDetailsScreen,animated: true)
            
        }else {
            print("Internet is off")
            showAlert (message:" Please Check your network to show the details of leagues")
        }
    }
    
}
    
    
    // for future if i want to make delete here but first check if is come from fav make it aviable and effect data base
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if sportName .is empty{
        //        if editingStyle == .delete {
        //            let removedFavorite = favorites.remove(at: indexPath.row)
        //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //            let managedContext = appDelegate.persistentContainer.viewContext
        //            managedContext.delete(removedFavorite)
        //            do {
        //                try managedContext.save()
        //            } catch let error as NSError {
        //                print("Could not save deletion. \(error), \(error.userInfo)")
        //            }
        //            tableView.deleteRows(at: [indexPath], with: .fade)
        //        }
        //    }
//    }



