//
//  LeaguesCollectionViewController.swift
//  Sports App
//
//  Created by Haneen Medhat on 21/05/2024.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class LeaguesCollectionViewController: UICollectionViewController {
    var sportName :String = ""
    var legKey : Int = 0
    
    let viewModel = UpComingViewModel()


    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        
        //        let storyBoard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
        //        let legaguesScreen = storyBoard.instantiateViewController(withIdentifier: "leg") as! LeaguesTableViewController
        //        present(legaguesScreen,animated: true)
        
    }
    @IBAction func addToFav(_ sender: UIBarButtonItem) {
        let leagues = Leagues(league_name: viewModel.upcomingEvents.first?.league_name, league_logo: viewModel.upcomingEvents.first?.league_logo, league_key: legKey, sportName:sportName)
         let leaguesList = viewModel.getLocalData()
      
        let foundObjects = leaguesList.filter { $0.league_name == viewModel.upcomingEvents.first?.league_name }
        print(foundObjects)
        if foundObjects.isEmpty{
            print(viewModel.upcomingEvents.first?.league_name, viewModel.upcomingEvents.first?.league_logo, legKey,sportName)
            LocalStorageService.insertLeague(leagues)
            showAlert(title: "Add To Favorite", message:"League Added To Favorite Successfully")
            sender.image = UIImage(systemName: "heart.fill")
        } else{
            LocalStorageService.deleteLeague(leagueKey: legKey)
            showAlert(title: "Delete From Favorite", message: "League Deleted Successfully")
            sender.image = UIImage(systemName: "heart")
            
        }
       
      
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateFavoriteButton()
        

        print ("values of seportname \(sportName) and key \(legKey) in LeaguesCollectionViewController")

        collectionView.register(UINib(nibName: "EmptyStateCell", bundle: nil), forCellWithReuseIdentifier: "emptyStateCell")

        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)

        let layout = UICollectionViewCompositionalLayout
        {sectionIndex,environment in
            switch sectionIndex{
            case 0:
                return self.drawNavigationCell()
            case 1:
                return self.drawUpComingEvents()
            case 2:
                return self.drawLatestComingEvents()
            case 3:
                return self.drawTeams()
            default:
                return self.drawTeams()
                
            }
            
    
        }

        collectionView.setCollectionViewLayout(layout, animated:true)
        
        viewModel.eventsDidChange = { [weak self] events in
            DispatchQueue.main.async {
                        self?.collectionView.reloadData()
              }
        }
        
        viewModel.latestEventsDidChange = { [weak self] events in
            DispatchQueue.main.async {
                        self?.collectionView.reloadData()
              }
        }
        
        viewModel.teamsDidChange = { [weak self] events in
            DispatchQueue.main.async {
                        self?.collectionView.reloadData()
              }
        }
        fetchUpcomingEvents()

        
        
    }
    

    private func updateFavoriteButton() {
        let leaguesList = viewModel.getLocalData()
         let foundObjects = leaguesList.filter { $0.league_name == viewModel.upcomingEvents.first?.league_name }
         
         if let favButton = navigationItem.rightBarButtonItem {
             if !foundObjects.isEmpty {
                 favButton.image = UIImage(systemName: "heart.fill")
             } else {
                 favButton.image = UIImage(systemName: "heart")
             }
         }
    }
    
    private func fetchUpcomingEvents() {
        //sport: "cricket", leagueId: 733
        viewModel.fetchUpcomingEvents(sport: sportName, leagueId: legKey) { result in
               switch result {
               case .success(let events):
                   print("Fetched events: ")
               case .failure(let error):
                   print("Error fetching  fetchUpcomingEvents events:\(error) ")
               }
           }
        
        viewModel.fetchLatestEvents(sport: sportName, leagueId: legKey) { result in
               switch result {
               case .success(let events):
                   print("Fetched events: )")
               case .failure(let error):
                   print("Error fetching fetchLatestEvents events: \(error)")
               }
           }
        
        viewModel.fetchTeams(sport: sportName, leagueId: legKey) { result in
               switch result {
               case .success(let events):
                   print("Fetched events: \(events)")
               case .failure(let error):
                   print("Error fetching  fetchTeams events: \(error)")
               }
           }
       }

    
    func drawNavigationCell() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }

    
    func drawUpComingEvents() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(225))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }


func drawLatestComingEvents() -> NSCollectionLayoutSection{
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    let section = NSCollectionLayoutSection(group: group)
    
    
    //create padding between groups
    section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    
    section.boundarySupplementaryItems = [sectionHeader]
    return section
}


func drawTeams() -> NSCollectionLayoutSection{
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .absolute(170))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8 )
    let section = NSCollectionLayoutSection(group: group)
    
    section.orthogonalScrollingBehavior = .continuous
    
    //create padding between groups
    section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 10, trailing: 0)
   
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    
    section.boundarySupplementaryItems = [sectionHeader]
    return section
}


// MARK: UICollectionViewDataSource

override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 4
}


override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    switch section{
    case 0:
        return  1
    case 1:
        return  viewModel.upcomingEvents.count
    case 2:
        return viewModel.latestEvents.count
    case 3:
        return  viewModel.teams.count
    default:
        return viewModel.teams.count

    }
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cellIdentifier :String = ""

    if indexPath.section == 0 {
        cellIdentifier = "cell"
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! NavigationCollectionViewCell
        let leaguesList = viewModel.getLocalData()
         let foundObjects = leaguesList.filter { $0.league_name == viewModel.upcomingEvents.first?.league_name }
         
        if !foundObjects.isEmpty {
                 cell.favBtn.image = UIImage(systemName: "heart.fill")
             } else {
                 cell.favBtn.image = UIImage(systemName: "heart")
             }
         
        return cell
    }
    
    if indexPath.section == 1 {
        if viewModel.upcomingEvents.isEmpty {
            cellIdentifier = "emptyStateCell"
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
                      if let emptyImage = UIImage(named: "nothing.jpeg") {
                          let imageView = UIImageView(image: emptyImage)
                          imageView.contentMode = .scaleAspectFill
                          imageView.frame = cell.contentView.bounds
                          cell.contentView.addSubview(imageView)
                      }
                      return cell
            
        }else{
            cellIdentifier = "upcoming"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! UpcomingCollectionViewCell
            
            let obj = viewModel.upcomingEvents[indexPath.row]
            cell.dateLabel.text = obj.event_date
            cell.timeLabel.text = obj.event_time
            cell.leagueLabel.text = obj.league_name
            cell.firstTeamLabel.text = obj.event_home_team
            cell.secondTeamLabel.text = obj.event_away_team
            
            if let homeTeamLogoURLString = obj.home_team_logo, let homeTeamLogoURL = URL(string: homeTeamLogoURLString) {
                cell.firstTeamImg.kf.setImage(with: homeTeamLogoURL)
            } else {
                cell.firstTeamImg.image = UIImage(named: "teams.png") // Placeholder image
            }
            
            if let awayTeamLogoURLString = obj.away_team_logo, let awayTeamLogoURL = URL(string: awayTeamLogoURLString) {
                cell.secondTeamImg.kf.setImage(with: awayTeamLogoURL)
            } else {
                cell.secondTeamImg.image = UIImage(named: "teams.png") // Placeholder image
            }
            
            
            return cell
        }
    }
    
    
    if indexPath.section == 2 {
        cellIdentifier = "latestEvent"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LatestEventsCollectionViewCell
            
        let obj = viewModel.latestEvents[indexPath.row]
      
        cell.firstTeamLabel.text = obj.event_home_team
        cell.secondTeamLabel.text = obj.event_away_team
        cell.scoreLabel.text = obj.event_final_result
        
        if let homeTeamLogoURLString = obj.home_team_logo, let homeTeamLogoURL = URL(string: homeTeamLogoURLString) {
            cell.firstTeamImg.kf.setImage(with: homeTeamLogoURL)
        } else {
            cell.firstTeamImg.image = UIImage(named: "teams.png")
        }
        
        if let awayTeamLogoURLString = obj.away_team_logo, let awayTeamLogoURL = URL(string: awayTeamLogoURLString) {
            cell.secondTeamImg.kf.setImage(with: awayTeamLogoURL)
        } else {
            cell.secondTeamImg.image = UIImage(named: "teams.png")
        }
        
        
        return cell
    }
    
    if indexPath.section == 3 {
        cellIdentifier = "teams"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TeamsCollectionViewCell
            
        let obj = viewModel.teams[indexPath.row]
      
        cell.teamLabel.text = obj.team_name
        if let logo = obj.team_logo, let logoURL = URL(string: logo) {
            cell.teamImg.kf.setImage(with: logoURL)
        } else {
            cell.teamImg.image = UIImage(named: "teams.png")
        }
        return cell
    }
    fatalError("Unexpected section in collectionView")

}


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            goBack(UIBarButtonItem())
            addToFav( UIBarButtonItem())
        }
        
        if indexPath.section == 3 {
            var teamSrlected = viewModel.teams[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let teamVC = storyboard.instantiateViewController(withIdentifier: "Team") as? TeamViewController else { return }
            
            teamVC.sportName = sportName
            teamVC.teamKey = teamSrlected.team_key
            
            self.present(teamVC, animated: true, completion: nil)
        }
  }
    
    
    func showAlert(title:String,message:String) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension LeaguesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as! HeaderView
        
        // Configure header view
        switch indexPath.section {
        case 1:
            headerView.configure(with: "Upcoming Events")
        case 2:
            headerView.configure(with: "Latest Events")
        case 3:
            headerView.configure(with: "Teams")
        default:
            headerView.configure(with: "Teams")
        }
        
        return headerView
    }
}
