//
//  MethodsOfNetwork.swift
//  Sports AppTests
//
//  Created by Mayar on 24/05/2024.
//

import XCTest

@testable import Sports_App

final class MethodsOfNetwork: XCTestCase {

    
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
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
    
    
    

}
