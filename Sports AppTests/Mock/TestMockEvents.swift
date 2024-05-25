//
//  TestMockEvents.swift
//  
//
//  Created by Haneen Medhat on 25/05/2024.
//

import XCTest
final class TestMockEvents: XCTestCase {

    var obj :MockEventNetworkService?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        obj = MockEventNetworkService(networkConnection: false)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
