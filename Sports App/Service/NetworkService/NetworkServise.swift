//
//  NetworkServise.swift
//  Sports App
//
//  Created by Mayar on 20/05/2024.
//

import Foundation
import Alamofire

class FetchDataFromNetwork {
       
     static func fetchLeg (sportName: String , completion: @escaping ([Leagues]?,Error?) -> Void) {
            var url =  "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"

      //   print("url of fetch leagues \(url)")
         
         AF.request(url).responseData { (response: DataResponse<Data, AFError>)  in
          switch response.result {
             case .success(let value):
                 do {
                     let result = try JSONDecoder().decode(LeaguesResponse.self, from: value)
                 //   print ("the result is\(result)")
                     completion(result.result,nil)
                 } catch {
                     completion(nil,error)
                 }
             case .failure(let error):
                 completion(nil,error)
             }
         }
     }
    
    
    
    static func fetchTeamData (teamKey: Int ,sportName: String, completion: @escaping (TeamResponse?,Error?) -> Void) {
        print ("in fetch team")
        var url = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&teamId=\(teamKey)&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"
        
        AF.request(url).responseData { (response: DataResponse<Data, AFError>)  in
         switch response.result {
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(TeamResponse.self, from: value)
               //    print ("the result is\(result)")
                    completion(result,nil)
                } catch {
                    completion(nil,error)
                }
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    

    
    func fetchUpcomingEvents(sport:String,leaguId: Int, completion: @escaping (Result<UpcomingResponse, Error>) -> Void) {
        let url =
           "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leaguId)&from=2024-05-18&to=2024-8-18&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"
                
        print("https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leaguId)&from=2024-05-18&to=2024-8-18&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df")
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(UpcomingResponse.self, from: data)
                    completion(.success(apiResponse))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    func fetchLatestEvents(sport:String,leaguId: Int, completion: @escaping (Result<UpcomingResponse, Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leaguId))&from=2024-02-21&to=2024-05-21&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"
        
        
//        print("latest\(url)")
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(UpcomingResponse.self, from: data)
                    completion(.success(apiResponse))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    func fetchTeams(sport:String,leaguId: Int, completion: @escaping (Result<TeamsResponse, Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&leagueId=\(leaguId)&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(TeamsResponse.self, from: data)
                    completion(.success(apiResponse))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
    
