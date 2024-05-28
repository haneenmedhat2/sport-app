//
//  MockLeaguesDetailsAndTeam.swift
//  Sports AppTests
//
//  Created by Mayar on 29/05/2024.
//

import XCTest
@testable import Sports_App

final class MockLeaguesDetailsAndTeam: XCTestCase {

    
    var obj :MockEventNetworkService?
    override func setUpWithError() throws {
        obj = MockEventNetworkService(networkConnection: false)
    }
 
    override func tearDownWithError() throws {
        obj = nil
    }
    
    func testfetchUpcomingEvent(){
        obj?.fetchUpcomingEvents(sport: "football", leaguId: 205){ result in
            switch result{
            case .success(let result):
                XCTAssertNotNil(result, "Not empty response")
            case .failure(let error):
                XCTFail()
            }
        }
    }
        
    func testfetchTeams(){
        obj?.fetchTeams(sport: "football", leaguId: 205){ result in
            switch result{
            case .success(let result):
                XCTAssertNotNil(result, "Not empty response")
            case .failure(let error):
                XCTFail()
            }
        }
    }
 
}


