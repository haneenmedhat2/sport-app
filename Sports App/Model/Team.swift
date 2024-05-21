//
//  Team.swift
//  Sports App
//
//  Created by Mayar on 21/05/2024.
//

import Foundation

struct Team: Codable {
    let league_logo: String?
    let league_key : Int?
}

struct LeaguesResponse: Codable {
    let success: Int
    let result: [Leagues]
}

