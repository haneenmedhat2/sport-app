//
//  LeguesModel.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import Foundation


struct Leagues: Codable {
    let league_name: String?
    let league_logo: String?
    let league_key : Int?
}

struct LeaguesResponse: Codable {
    let success: Int
    let result: [Leagues]
}

