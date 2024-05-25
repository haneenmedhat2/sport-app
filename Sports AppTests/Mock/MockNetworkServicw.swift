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
    

}

