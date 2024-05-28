//
//  LocalStorageServiceTest.swift
//  Sports AppTests
//
//  Created by Mayar on 25/05/2024.
//

import XCTest
@testable import Sports_App
import CoreData

final class LocalStorageTest: XCTestCase {

    override func setUpWithError() throws {
        try LocalStorageService.clearAllFavLeagues()
    }

    override func tearDownWithError() throws {
        try LocalStorageService.clearAllFavLeagues()
    }

     func testGetAllFavLeaguesEmpty() throws {
           let all = LocalStorageService.getAllFavLeagues()
           XCTAssertNotNil(all)
           XCTAssertTrue(all.isEmpty, "The list of favorite leagues should be empty")
       }
    
    
       func testInsert() throws {
           LocalStorageService.insertLeague(Leagues(league_name: "testLeagueName", league_logo: "testLogo", league_key: 1, sportName: "testSportName"))
           let all = LocalStorageService.getAllFavLeagues()
           XCTAssertNotNil(all)
           XCTAssertEqual(all.count, 1)
           XCTAssertEqual(all.first?.league_name, "testLeagueName")
           XCTAssertEqual(all.first?.league_logo, "testLogo")
           XCTAssertEqual(all.first?.league_key, 1)
           XCTAssertEqual(all.first?.sportName, "testSportName")
       }
    
    
    func testDelete() throws {
        
        LocalStorageService.insertLeague(Leagues(league_name: "testLeagueName", league_logo: "testLogo", league_key: 1, sportName: "testSportName"))
        
        LocalStorageService.deleteLeague(leagueKey: 1)
        
        let all = LocalStorageService.getAllFavLeagues()
        
        XCTAssertTrue(all.isEmpty, "no favorite leagues ")
    }
 
 
   
}
