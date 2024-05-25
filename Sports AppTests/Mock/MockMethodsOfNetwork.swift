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
    
    // leagues
    func testFetchAllLeagus() {
        
               mockService.fetchDataFromJsonAllLeagues { leagues, error in
                   XCTAssertNil(error, "Error should be nil")
                   XCTAssertNotNil(leagues, "Leagues should not be nil")
                   XCTAssertEqual(leagues?.count, 4, "There should be 4 leagues")
                   XCTAssertEqual(leagues?.first?.league_name, "UEFA Europa League", "First league name should be 'UEFA Europa League'")
               }
           }
    func testFetchTeamDetails() {
        
               mockService.fetchDataFromJsonTeams { team, error in
                   XCTAssertNil(error, "Error should be nil")
                   XCTAssertNotNil(team, "not nil")
                   XCTAssertEqual(team?.result.first?.team_name , "Türkiye")
               }
           }
    
    }

