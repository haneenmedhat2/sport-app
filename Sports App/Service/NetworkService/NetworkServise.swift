//
//  NetworkServise.swift
//  Sports App
//
//  Created by Mayar on 20/05/2024.
//

import Foundation
import Alamofire

class FetchDataFromNetwork {
    /**
     
     private func fetchLatestNewsFromAPI(completion: @escaping ([New]?) -> Void) {
         let url = "https://raw.githubusercontent.com/DevTides/NewsApi/master/news.json"
         AF.request(url).responseData { (response: DataResponse<Data, AFError>) in
             switch response.result {
             case .success(let data):
                 do {
                     let result = try JSONDecoder().decode([New].self, from: data)
                     DispatchQueue.main.async {
                         completion(result)
                     }
                 } catch {
                     completion(nil)
                 }
             case .failure(let error):
                 print("Error fetching data: \(error)")
                 completion(nil)
             }
         }
     }
     
     */
    func fetchLeg (sportName : String){
        
        AF.request("https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=c301f6eeebdbba75a16a845f135b9979996f7aaad6241449105d7eef268771df").responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    print("view did load")

                    print(json)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
