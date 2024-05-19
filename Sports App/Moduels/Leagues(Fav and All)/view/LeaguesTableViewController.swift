//
//  LeaguesTableViewController.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import UIKit

class LeaguesTableViewController: UITableViewController {

    var leaguesArray = [Leagues]()
    var comeFromHome :Bool?
    var comeFromFav : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
        
        if comeFromHome ?? false {
            //
//            leaguesArray = call   api function from LeguesViewModel
        }else if comeFromFav ?? false {
//         leaguesArray = call local function   from LeguesViewModel
            
        }
        
        // the following for testing only
        leaguesArray.append(Leagues(name: "Football", image: "url1", youTube: "https://www.youtube.com/watch?v=5I7UApFUyc8"))
        leaguesArray.append(Leagues(name: "Football", image: "url2", youTube: "https://www.facebook.com/gazaishereofficial/"))
        leaguesArray.append(Leagues(name: "Football", image: "url3", youTube: "link1"))
        leaguesArray.append(Leagues(name: "Football", image: "url4", youTube: "link1"))
        leaguesArray.append(Leagues(name: "Football", image: "url5", youTube: "link1"))
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
        cell.setUp(name: leagues.name, imageUrl: leagues.image, youTubeUrl: leagues.youTube)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard = UIStoryboard(name: "", bundle: nil)
//        let legaguesDetails = storyBoard.instantiateViewController(withIdentifier: "details")
//        present(legaguesDetails,animated: true)
//    
    }
}

struct Leagues{
    let name : String
    let image : String // as it will be URL
    let youTube : String
}