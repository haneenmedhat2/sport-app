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
         print (" in fetching network service function")
                  print ("sport name is \(sportName)")
         var url =  "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"

         AF.request(url).responseData { (response: DataResponse<Data, AFError>)  in
          switch response.result {
             case .success(let value):
                 do {
                     print (" in fetching network service function succe ")

                     let result = try JSONDecoder().decode(LeaguesResponse.self, from: value)
                     print("in fetching ")
                    print ("the result is\(result)")
                     completion(result.result)
                 } catch {
                     print("in catch ")
                     print("Decoding error: \(error)")
                     completion(nil)
                 }
             case .failure(let error):
                 print("Error fetching data: \(error)")
                 completion(nil)
             }
         }
     }
    
    static func fetchTeamData (teamKey: Int ,sportName: String, completion: @escaping (TeamResponse?) -> Void) {
       //
        print (" in fetching network service function here only test but i make alwasy football")
                 print ("sport name is \(teamKey)")
        //
        
        var url = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=4&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df"
        
        AF.request(url).responseData { (response: DataResponse<Data, AFError>)  in
         switch response.result {
            case .success(let value):
                do {
                    print (" in fetching network service function succe ")
// self as he it self is codeable
                    let result = try JSONDecoder().decode(TeamResponse.self, from: value)
                    print("in fetching ")
                   print ("the result is\(result)")
                    completion(result)
                } catch {
                    print("in catch ")
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
