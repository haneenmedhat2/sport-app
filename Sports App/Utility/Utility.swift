//
//  Utility.swift
//  Sports App
//
//  Created by Mayar on 22/05/2024.
//

import Foundation
import UIKit

class UtilityObject {
    
    static  let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let managedContext = appDelegate.persistentContainer.viewContext
    
}
