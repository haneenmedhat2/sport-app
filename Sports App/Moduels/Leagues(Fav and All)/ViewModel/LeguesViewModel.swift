//
//  LeguesViewModel.swift
//  Sports App
//
//  Created by Mayar on 19/05/2024.
//

import Foundation

class LeguesViewModel {
            
        var bindResultToViewController : (()->()) = {}

    
        var allLegues : [Leagues]? {
            didSet {
                bindResultToViewController()
            }
        }
           
        func getDataFromAPI(lowercaseSportName: String) {
            FetchDataFromNetwork.fetchLeg(sportName: lowercaseSportName) { [weak self] legues , error in
                if let error = error{
                    print("error")}
                else{
                    self?.allLegues = legues
                }
            }
        }
    
    
    func getAllFavLeagues() -> [Leagues] {
            return LocalStorageService.getAllFavLeagues()
        }
    }

