//
//  Team.swift
//  Sports App
//
//  Created by Mayar on 21/05/2024.
//

import Foundation


struct TeamResponse: Codable {
    let result: [TeamMemberAndInformation]
}

struct TeamMemberAndInformation : Codable {
    let team_name: String?
    let team_logo : String?    
    let teamMember : [TeamPlayer]?
}

struct TeamPlayer : Codable {
    let player_name : String?
    let player_image : String?
    let player_birthdate : String?
}

