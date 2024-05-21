//
//  UpComingViewModel.swift
//  Sports App
//
//  Created by Haneen Medhat on 21/05/2024.
//

import Foundation

class UpComingViewModel{
    
    private let fetchDataFromNetwork: FetchDataFromNetwork
    
    var upcomingEvents: [Event] = [] {
        didSet {
            eventsDidChange?(upcomingEvents)
        }
    }
    
    var eventsDidChange: (([Event]) -> Void)?
    
    init(fetchDataFromNetwork: FetchDataFromNetwork = FetchDataFromNetwork()) {
        self.fetchDataFromNetwork = fetchDataFromNetwork
    }
    
    func fetchUpcomingEvents(leagueId: Int, completion: @escaping (Result<[Event], Error>) -> Void) {
        fetchDataFromNetwork.fetchUpcomingEvents(leaguId: leagueId) { result in
            switch result {
            case .success(let response):
                self.upcomingEvents = response.result
                completion(.success(response.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
    
    
    
