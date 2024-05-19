//
//  Decoding.swift
//  Sports App
//
//  Created by Mayar on 18/05/2024.
//

import Foundation

//    import Alamofire

class DataDecoder {
        static func decodeNews(from data: Data) -> Result<[News], Error> {
            do {
                let decodedData = try JSONDecoder().decode([News].self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(error)
            }
        }
    }
}
  

    // Example usage:
    let urlString = "https://api.example.com/news"
    if let url = URL(string: urlString) {
        fetchData(from: url) { result in
            switch result {
            case .success(let data):
                // Call the decoding function to decode JSON data
                let result = DataDecoder.decodeNews(from: data)
                switch result {
                case .success(let newsArray):
                    // Handle successful decoding of newsArray
                    print("Decoded news array: \(newsArray)")
                case .failure(let error):
                    // Handle error
                    print("Error decoding news: \(error)")
                }
            case .failure(let error):
                // Handle error fetching data
                print("Error fetching data: \(error)")
            }
        }
    }
   
}
