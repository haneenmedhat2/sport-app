//
//  Sports_AppTests.swift
//  Sports AppTests
//
//  Created by Haneen Medhat on 16/05/2024.
//

import XCTest
@testable import Sports_App

final class Sports_AppTests: XCTestCase {
    var viewModel : TeamViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         viewModel = TeamViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    
    func testgetTeamDataFromAPI(){
        let sportName: String = "football"
         let teamKey = 100
         
        viewModel?.getTeamDataFromAPI(sportName:sportName , teamKey: teamKey)

        
        viewModel?.bindResultToViewController = {
            XCTAssertNotNil(self.viewModel?.teamDetails)
        }
        
            
        
        
    }
    
    
  }
    

