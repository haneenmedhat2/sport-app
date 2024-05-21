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
        fetchUpcomingEvents()

    }
    
    private func fetchUpcomingEvents() {
        viewModel.fetchUpcomingEvents(sport: "basketball", leagueId: 1098) { result in
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
        return 5
    default:
        return 15

    }
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cellIdentifier :String = ""
//    switch indexPath.section{
//    case 0:
//        cellIdentifier = "upcoming"
//    case 1:
//        cellIdentifier = "latestEvent"
//    default:
//        cellIdentifier = "teams"
//    }
    if indexPath.section == 0 {
        cellIdentifier = "upcoming"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! UpcomingCollectionViewCell
        
        let obj = viewModel.upcomingEvents[indexPath.row]
        cell.dateLabel.text = obj.event_date
               cell.timeLabel.text = obj.event_time
               cell.leagueLabel.text = obj.league_name
               cell.firstTeamLabel.text = obj.event_home_team
               cell.secondTeamLabel.text = obj.event_away_team

        if let imageURL = URL(string: obj.home_team_logo) {
            cell.firstTeamImg.kf.setImage(with: imageURL)
               } else {
                   cell.firstTeamImg.image = UIImage(named: "placeholder")
               }
        
        if let imageURL = URL(string: obj.away_team_logo) {
            cell.secondTeamImg.kf.setImage(with: imageURL)
               } else {
                   cell.firstTeamImg.image = UIImage(named: "placeholder")
               }

        
            
        return cell
    }
    
    if indexPath.section == 1 {
        cellIdentifier = "latestEvent"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LatestEventsCollectionViewCell
            
        return cell
    }
    
    if indexPath.section == 2 {
        cellIdentifier = "teams"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TeamsCollectionViewCell
            
        return cell
    }
    fatalError("Unexpected section in collectionView")

}



// MARK: UICollectionViewDelegate

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    return true
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return true
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
    return false
}

override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
    return false
}

override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

}
*/

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
