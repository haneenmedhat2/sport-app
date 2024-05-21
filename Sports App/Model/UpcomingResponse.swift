//
//  UpcomingResponse.swift
//  Sports App
//
//  Created by Haneen Medhat on 21/05/2024.
//

import Foundation


struct UpcomingResponse:Decodable{
    let success : Int
    let result : [Event]?
}

struct Event:Codable{
    let event_key: Int?
     let event_date: String?
     let event_time: String?
     let event_home_team: String?
     let home_team_key: Int?
     let event_away_team: String?
     let away_team_key: Int?
     let league_name: String?
     let league_key: Int?
     let home_team_logo: String?
     let away_team_logo: String?
     let league_logo: String?
     let event_final_result : String?

}
