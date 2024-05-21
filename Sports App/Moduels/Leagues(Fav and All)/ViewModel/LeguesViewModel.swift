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
            
            print ("in get data from api")
            
            FetchDataFromNetwork.fetchLeg(sportName: lowercaseSportName) { [weak self] legues in
                
                print ("in get data from api in response LeguesViewModel ")

                self?.allLegues = legues
            }
        }
    }

