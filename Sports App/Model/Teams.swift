//
//  Teams.swift
//  Sports App
//
//  Created by Haneen Medhat on 21/05/2024.
//

import Foundation

struct TeamsResponse:Decodable{
    let success:Int
    let result :[Teams]?
}


struct Teams:Decodable{
    let team_key : Int?
    let team_name : String?
    let team_logo : String?
}
