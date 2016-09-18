//
//  User+CoreDataProperties.swift
//  
//
//  Created by Carlos Vinicius on 9/13/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var username: String?
    @NSManaged var password: String?

}
