//
//  MethodsOfNetwork.swift
//  Sports AppTests
//
//  Created by Mayar on 24/05/2024.
//

import XCTest

@testable import Sports_App

final class MethodsOfNetwork: XCTestCase {

    var networkService : FetchDataFromNetwork?
    let sportName = "football"
    let leagueId = 205
    
    override func setUpWithError() throws {
        networkService = FetchDataFromNetwork()
    }

    override func tearDownWithError() throws {
        networkService = nil
    }

    
    func testFetchLegMetohd () {
        let expectation = expectation(description: "wait for API ...")
        FetchDataFromNetwork.fetchLeg(sportName:"football"){ data , error in
            if let error = error{
                XCTFail()
            }else{
                print(data?.count)
                XCTAssertNotNil(data?.count)
               //  XCTAssertEqual(data?.count, 865)
                expectation.fulfill()
            }

        }
        waitForExpectations(timeout: 8)
    }
    
    func testfetchTeamDataMethod () {
        let expectation = expectation(description: "wait for API ...")
        FetchDataFromNetwork.fetchTeamData(teamKey: 1, sportName: "football"){ data , error in
            if let error = error{
                XCTFail()
            }else{
                print(data?.result.first?.team_name)
                XCTAssertNotNil(data?.result.first?.team_name)
                expectation.fulfill()
            }

        }
        waitForExpectations(timeout: 8)
    }
    
    
    
    func testFetchUpcomingEvents(){

        let expectation = expectation(description: "Wait for data coming from api")
        networkService?.fetchUpcomingEvents(sport: sportName, leaguId: leagueId) { result in
            switch result{
            case .success(let result):
                XCTAssertNotNil(result, "Not empty result")
            case .failure(let error):
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    

    
    func testFetchLatestEvents(){
        let expectation = expectation(description: "Wait for data coming from api")
        networkService?.fetchLatestEvents(sport: sportName, leaguId:leagueId ){ result in
            switch result{
            case .success(let result):
                XCTAssertNotNil(result, "Not empty result")
            case .failure(let error):
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 4)
    }
    
    
    func testFetchTeams(){
        let expectation = expectation(description: "Wait for data coming from api")
        networkService?.fetchTeams(sport:sportName, leaguId: leagueId){ result in
            switch result{
            case .success(let result):
                XCTAssertNotNil(result, "Not empty result")
            case .failure(let error):
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    

    

}
