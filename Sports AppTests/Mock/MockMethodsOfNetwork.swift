//
//  MockMethodsOfNetwork.swift
//  Sports AppTests
//
//  Created by Mayar on 24/05/2024.
//

import XCTest
@testable import Sports_App

final class MockMethodsOfNetwork: XCTestCase {
    
    let mockService = MockNetworkService(shouldReturnError: false)

    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
   
    
    func testFetchDataFailure() {
        mockService.fetchDataFromJson {result , error in
            if let error = error{
                XCTFail()
            }else{
                print(result)
                XCTAssertNotNil(result)
//                XCTAssertEqual(result?.count, 4)
//                XCTAssertEqual(result?.first?.league_name, "UEFA Europa League")
                
            }
            
        }
    }
}
