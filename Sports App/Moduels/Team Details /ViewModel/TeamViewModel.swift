//
//  TeamViewModel.swift
//  Sports App
//
//  Created by Mayar on 21/05/2024.
//

import Foundation

class TeamViewModel {
    
    var bindResultToViewController : (()->()) = {}

    var teamDetails : TeamResponse? {
        didSet {
            bindResultToViewController()
        }
    }
       
    func getTeamDataFromAPI(sportName:String ,teamKey: Int) {
         FetchDataFromNetwork.fetchTeamData(teamKey: teamKey, sportName: sportName){ [weak self] teamDetails in
                self?.teamDetails  = teamDetails
        }
    }
}

