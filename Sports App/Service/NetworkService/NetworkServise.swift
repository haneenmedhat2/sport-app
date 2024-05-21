//
//  NetworkServise.swift
//  Sports App
//
//  Created by Mayar on 20/05/2024.
//

import Foundation
import Alamofire

class FetchDataFromNetwork {
       
     static func fetchLeg (sportName: String , completion: @escaping ([Leagues]?) -> Void) {
            var url =  "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"

         AF.request(url).responseData { (response: DataResponse<Data, AFError>)  in
          switch response.result {
             case .success(let value):
                 do {
                     let result = try JSONDecoder().decode(LeaguesResponse.self, from: value)
                    print ("the result is\(result)")
                     completion(result.result)
                 } catch {
                     completion(nil)
                 }
             case .failure(let error):
                 completion(nil)
             }
         }
     }
    
    
    
    static func fetchTeamData (teamKey: Int ,sportName: String, completion: @escaping (TeamResponse?) -> Void) {
        var url = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&teamId=\(teamKey)&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"
        
        AF.request(url).responseData { (response: DataResponse<Data, AFError>)  in
         switch response.result {
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(TeamResponse.self, from: value)
                   print ("the result is\(result)")
                    completion(result)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
                completion(nil)
            }
        }
    }
  
}
