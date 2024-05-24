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
    
    let fakeJSONObj : [String: Any] = ["users" : [
        
        "id":1,
        "firstName":"Terry",
        "lastName":"Medhurst"
        
        ]
    ]
}

extension MockNetworkService{
    enum responseWithError: Error{
        case responseError
    }
    
    func fetchDataFromJson(compiltionHandler: @escaping (UsersResult?, Error?) -> Void){
            do{
                var data = try JSONSerialization.data(withJSONObject: fakeJSONObj)
                result = try JSONDecoder().decode(UsersResult.self, from: data)
                
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
