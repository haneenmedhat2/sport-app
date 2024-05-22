//
//  LocalStorageService.swift
//  Sports App
//
//  Created by Mayar on 21/05/2024.
//

import Foundation
import CoreData
// not correct to import her
import UIKit

class LocalStorageService {
    
    static func getAllFavLeagues () ->[Leagues]{
        var localLeagues : [Leagues]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AllNews")

        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                let league_name = result.value(forKey: "league_name") as? String ?? ""
                let league_logo = result.value(forKey: "league_logo") as? String ?? ""
                let league_key = result.value(forKey: "desription") as? Int64 ?? 0
                 print("add to news from local title\(result.value(forKey: "league_name") as? String ?? "")")
                  let league = Leagues(league_name: league_name, league_logo: league_logo, league_key: league_key)
                localLeagues.append(league)
            }
        } catch {
            print("Error fetching data from Core Data: \(error)")
            return []
        }
        
        return localLeagues
    }
    
}
