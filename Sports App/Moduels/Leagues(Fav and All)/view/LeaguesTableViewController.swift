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
       
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
 }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newtworkIndicator!.startAnimating()

        if let sportName = sportName {
            let lowercaseSportName = sportName.lowercased()
            
            if sportName == "Hockey" || sportName == "Baseball" || sportName == "American" || sportName == "American Football" {
                print (" is name of not data")
                newtworkIndicator?.stopAnimating()
                showAlert(message: "Sorry No Available Data For This Sport")
                
            }else {
                leguesViewModel?.getDataFromAPI(lowercaseSportName: lowercaseSportName)
                leguesViewModel?.bindResultToViewController = { [weak self] in
                    DispatchQueue.main.async {
                        self?.leaguesArray = self?.leguesViewModel?.allLegues ?? []
                        print("Fetched leagues in view controll: \(String(describing: self?.leaguesArray))")
                        if ((self?.leaguesArray.isEmpty) != nil) {
                            self?.showAlert (message:" Please Check your network")
                        }
                        self?.tableView.reloadData()
                        self?.newtworkIndicator?.stopAnimating()
                    }
                }
            }
        }else if comeFromFav ?? false {
  //         leaguesArray = call local function   from LeguesViewModel
            
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
//        let storyBoard = UIStoryboard(name: "", bundle: nil)
//        let legaguesDetails = storyBoard.instantiateViewController(withIdentifier: "details")
//        present(legaguesDetails,animated: true)
//    
    }
}


