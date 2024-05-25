//
//  MockNetworkServicw.swift
//  Sports AppTests
//
//  Created by Mayar on 24/05/2024.
//

import Foundation
@testable import Sports_App

class MockNetworkService {
    
    
    var result = [Leagues]()
    
    //true = error ... false = data
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let fakeJSONObj: [String: Any] = ["result": [
        ["league_key": 4, "league_name": "UEFA Europa League", "country_key": 1, "country_name": "eurocups", "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/", "country_logo": NSNull()],
        ["league_key": 1, "league_name": "UEFA European Championship", "country_key": 1, "country_name": "eurocups", "league_logo": NSNull(), "country_logo": NSNull()],
        ["league_key": 683, "league_name": "UEFA Europa Conference League", "country_key": 1, "country_name": "eurocups", "league_logo": NSNull(), "country_logo": NSNull()],
        ["league_key": 3, "league_name": "UEFA Champions League", "country_key": 1, "country_name": "eurocups", "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png", "country_logo": NSNull()]
    ]]

    }

extension MockNetworkService{
            enum responseWithError: Error{
                case responseError
            }
    
    func fetchDataFromJson(compiltionHandler: @escaping ([Leagues]?, Error?) -> Void){
                do{
                    let data = try JSONSerialization.data(withJSONObject: fakeJSONObj)
                    let  response  = try JSONDecoder().decode(LeaguesResponse.self, from: data)
                    result = response.result
                    print ("resulr after response \(result)")
                    
                }catch{
                    print(error.localizedDescription)
                }
                if shouldReturnError{
                    compiltionHandler(nil, responseWithError.responseError)
                    
                }else{
                    compiltionHandler(result, nil)
                }               
       }
}
