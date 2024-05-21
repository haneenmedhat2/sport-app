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
    
    let viewModel = UpComingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "EmptyStateCell", bundle: nil), forCellWithReuseIdentifier: "emptyStateCell")

        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)

        let layout = UICollectionViewCompositionalLayout
        {sectionIndex,environment in
            switch sectionIndex{
            case 0:
                return self.drawUpComingEvents()
            case 1:
                return self.drawLatestComingEvents()
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
        
        viewModel.latestEventsDidChange = { [weak self] events in
            DispatchQueue.main.async {
                        self?.collectionView.reloadData()
              }
        }
        fetchUpcomingEvents()

    }
    
    private func fetchUpcomingEvents() {
        //sport: "cricket", leagueId: 733
        viewModel.fetchUpcomingEvents(sport: "football", leagueId: 205) { result in
               switch result {
               case .success(let events):
                   print("Fetched events: ")
               case .failure(let error):
                   print("Error fetching events: ")
               }
           }
        
        viewModel.fetchLatestEvents(sport: "football", leagueId: 205) { result in
               switch result {
               case .success(let events):
                   print("Fetched events: )")
               case .failure(let error):
                   print("Error fetching events: ")
               }
           }
        
        viewModel.fetchTeams(sport: "football", leagueId: 205) { result in
               switch result {
               case .success(let events):
                   print("Fetched events: \(events)")
               case .failure(let error):
                   print("Error fetching events: \(error)")
               }
           }
       }

    
    func drawUpComingEvents() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(225))
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


/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: UICollectionViewDataSource

override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 3
}


override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    switch section{
    case 0:
        return  viewModel.upcomingEvents.count
    case 1:
        return viewModel.latestEvents.count
    default:
        return viewModel.teams.count

    }
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cellIdentifier :String = ""

    if indexPath.section == 0 {
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
    
    
    if indexPath.section == 1 {
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
    
    if indexPath.section == 2 {
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


}

extension LeaguesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as! HeaderView
        
        // Configure header view
        switch indexPath.section {
        case 0:
            headerView.configure(with: "Upcoming Events")
        case 1:
            headerView.configure(with: "Latest Events")
        default:
            headerView.configure(with: "Teams")
        }
        
        return headerView
    }
}
