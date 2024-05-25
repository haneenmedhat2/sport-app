//
//  LocalStorageService.swift
//  Sports App
//
//  Created by Mayar on 21/05/2024.
//

import Foundation
import CoreData
// not correct to import her

class LocalStorageService {
    
   
    static func getAllFavLeagues () ->[Leagues]{
        var localLeagues: [Leagues] = []

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeagues")

        do {
            print ("inside bring the data")
            let results = try UtilityObject.managedContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                let league_name = result.value(forKey: "league_name") as? String ?? ""
                let league_logo = result.value(forKey: "league_logo") as? String ?? ""
                let league_key = result.value(forKey: "league_key") as? Int64 ?? 0
                let sportName = result.value(forKey: "sportName") as? String ?? ""
                 print("retrive  from local title\(result.value(forKey: "league_name") as? String ?? "")")
                let league = Leagues(league_name: league_name, league_logo: league_logo, league_key: Int(league_key), sportName: sportName)
               
                localLeagues.append(league)
            }
        } catch {
            
            print("Error fetching data from Core Data: \(error)")
            return []
        }
        
        return localLeagues
    }
    
    static func insertLeague(_ league: Leagues) {
        print (" isert key \(league.league_key)")

          let context = UtilityObject.managedContext
          let entity = NSEntityDescription.entity(forEntityName: "FavLeagues", in: context)!
          let newLeague = NSManagedObject(entity: entity, insertInto: context)

          newLeague.setValue(league.league_name, forKey: "league_name")
          newLeague.setValue(league.league_logo, forKey: "league_logo")
          newLeague.setValue(Int8(league.league_key!), forKey: "league_key")
          newLeague.setValue(league.sportName, forKey: "sportName")

          do {
              try context.save()
              print("Successfully saved new league")
          } catch {
              print("Failed to save league: \(error)")
          }
      }
    
    
    static func clearAllFavLeagues() throws {
           let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavLeagues")
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

           do {
               try UtilityObject.managedContext.execute(deleteRequest)
           } catch {
               print("Failed to clear existing data: \(error)")
               throw error
           }
       }
    
    
}
