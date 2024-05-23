//
//  UpComingEventViewModel.swift
//  Sports App
//
//  Created by Mayar on 23/05/2024.
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
    
    var teams: [Teams] = [] {
        didSet {
            teamsDidChange?(upcomingEvents)
        }
    }
    
    var eventsDidChange: (([Event]) -> Void)?
    var latestEventsDidChange: (([Event]) -> Void)?
    var teamsDidChange: (([Event]) -> Void)?
    
    init(fetchDataFromNetwork: FetchDataFromNetwork = FetchDataFromNetwork()) {
        self.fetchDataFromNetwork = fetchDataFromNetwork
    }
    
    func fetchUpcomingEvents(sport: String, leagueId: Int, completion: @escaping (Result<[Event], Error>) -> Void) {
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
    
    func fetchLatestEvents(sport: String, leagueId: Int, completion: @escaping (Result<[Event], Error>) -> Void) {
        fetchDataFromNetwork.fetchLatestEvents(sport: sport, leaguId: leagueId) { result in
            switch result {
            case .success(let response):
                if let latestEvents = response.result {
                    self.latestEvents = latestEvents
                    completion(.success(latestEvents))
                } else {
                
                    self.latestEvents = []
                    completion(.success([]))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTeams(sport: String, leagueId: Int, completion: @escaping (Result<[Teams], Error>) -> Void) {
        fetchDataFromNetwork.fetchTeams(sport: sport, leaguId: leagueId) { result in
            switch result {
            case .success(let response):
                if let team = response.result {
                    self.teams = team
                    completion(.success(team))
                } else {
                
                    self.teams = []
                    completion(.success([]))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
    
    
    
