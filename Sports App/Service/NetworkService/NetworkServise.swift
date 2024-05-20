//
//  NetworkServise.swift
//  Sports App
//
//  Created by Mayar on 20/05/2024.
//

import Foundation
import Alamofire

class FetchDataFromNetwork {
    
     
//     private func fetchLeg (sportName: String, completion: @escaping ([New]?) -> Void) {
//         let url = "https://raw.githubusercontent.com/DevTides/NewsApi/master/news.json"
//         AF.request(url).responseData { (response: DataResponse<Data, AFError>) in
//             switch response.result {
//             case .success(let data):
//                 do {
//                     let result = try JSONDecoder().decode([New].self, from: data)
//                     DispatchQueue.main.async {
//                         completion(result)
//                     }
//                 } catch {
//                     completion(nil)
//                 }
//             case .failure(let error):
//                 print("Error fetching data: \(error)")
//                 completion(nil)
//             }
//         }
//     }
    
     static func fetchLeg (sportName: String , completion: @escaping ([Leagues]?) -> Void) {
         print (" in fetching network service function")
         
     AF.request("https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df")
        .responseData { (response: DataResponse<Data, AFError>)  in
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
                     print("Decoding error: \(error)") // Print the decoding error
                     completion(nil)
                 }
             case .failure(let error):
                 print("Error fetching data: \(error)")
                 completion(nil)
             }
         }
     }
     
//
//   static  func fetchLeg (sportName : String){
//       print("Selected sport after : \(sportName)")
//
//        AF.request("https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df")
//           .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let json = value as? [String: Any] {
//                    print("in fetching ")
//
//                    print(json)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//        
//    }
//    
//    
}
