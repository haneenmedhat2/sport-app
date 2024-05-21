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
            FetchDataFromNetwork.fetchLeg(sportName: lowercaseSportName) { [weak self] legues in
                self?.allLegues = legues
            }
        }
    }

