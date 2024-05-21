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
    
    var latestEvents: [Event] = [] {
        didSet {
            latestEventsDidChange?(upcomingEvents)
        }
    }
    
    var eventsDidChange: (([Event]) -> Void)?
    var latestEventsDidChange: (([Event]) -> Void)?
    
    init(fetchDataFromNetwork: FetchDataFromNetwork = FetchDataFromNetwork()) {
        self.fetchDataFromNetwork = fetchDataFromNetwork
    }
    
    func fetchUpcomingEvents(sport: String, leagueId: Int, completion: @escaping (Result<[Event], Error>) -> Void) {
        fetchDataFromNetwork.fetchUpcomingEvents(sport: sport, leaguId: leagueId) { result in
            switch result {
            case .success(let response):
                if let upcomingEvents = response.result {
                    self.latestEvents = upcomingEvents
                    completion(.success(upcomingEvents))
                } else {
                
                    self.latestEvents = []
                    completion(.success([]))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLatestEvents(sport: String, leagueId: Int, completion: @escaping (Result<[Event], Error>) -> Void) {
        fetchDataFromNetwork.fetchUpcomingEvents(sport: sport, leaguId: leagueId) { result in
            switch result {
            case .success(let response):
                if let upcomingEvents = response.result {
                    self.upcomingEvents = upcomingEvents
                    completion(.success(upcomingEvents))
                } else {
                
                    self.upcomingEvents = []
                    completion(.success([]))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
    
    
    
