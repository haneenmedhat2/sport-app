//
//  MockEventNetworkService.swift
//  Sports AppTests
//
//  Created by Haneen Medhat on 25/05/2024.
//

import Foundation
@testable import Sports_App

class MockEventNetworkService{
    
    var networkConnection : Bool
    init(networkConnection: Bool) {
        self.networkConnection = networkConnection
    }
    
    let fakeJson :[String:Any] = [
        "success": 1,
        "result": [
            [
                "event_key": 1387971,
                "event_date": "2024-05-15",
                "event_time": "21:00",
                "event_home_team": "Atalanta",
                "home_team_key": 85,
                "event_away_team": "Juventus",
                "away_team_key": 96,
                "league_name": "Coppa Italia - Final",
                "league_key": 205,
                "home_team_logo": "https://apiv2.allsportsapi.com/logo/85_atalanta.jpg",
                "away_team_logo": "https://apiv2.allsportsapi.com/logo/96_juventus.jpg",
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/205_coppa-italia.png"

            ]
        ]
    ]
    
    
    let fakeJson2 : [String:Any] = [
    "success" : 1,
    "result" : [
    [
    "team_key" : 79,
    "team_name" : "Inter Milan",
    "team_logo" : "https://apiv2.allsportsapi.com/logo/79_inter-milan.jpg",
    "players" :[
    [
    "player_key" : 2665071992,
    "player_image" : "https://apiv2.allsportsapi.com/logo/players/390_s-de-vrij.jpg",
    "player_name" : "S. de Vrij",
    "player_number" : "6",
    "player_type" : "Defenders"
         ]
       ]
     ]
    ]
   ]
    
}


extension MockEventNetworkService {
    
    enum ErrorResponse : Error{
       case errorResponse
    }
    
    func fetchUpcomingEvents(sport:String,leaguId: Int, completion: @escaping (Result<UpcomingResponse, Error>) -> Void) {
        do{
            
            let data = try JSONSerialization.data(withJSONObject: fakeJson, options: [])
            let result = try JSONDecoder().decode(UpcomingResponse.self, from: data)
            if networkConnection {
                completion(.failure(ErrorResponse.errorResponse))
            }else{
                completion(.success(result))
            }
        }catch{
            completion(.failure(ErrorResponse.errorResponse))
        }
        
    }
    
    
    func fetchTeams(sport:String,leaguId: Int, completion: @escaping (Result<TeamResponse, Error>) -> Void) {
        do{
            
            let data = try JSONSerialization.data(withJSONObject: fakeJson, options: [])
            let result = try JSONDecoder().decode(TeamResponse.self, from: data)
            if networkConnection {
                completion(.failure(ErrorResponse.errorResponse))
            }else{
                completion(.success(result))
            }
        }catch{
            completion(.failure(ErrorResponse.errorResponse))
        }
        
    }
}
