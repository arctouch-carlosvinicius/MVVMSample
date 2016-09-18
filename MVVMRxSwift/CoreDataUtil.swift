//
//  CoreData.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/13/16.
//

import RxSwift
import UIKit
import CoreData

class CoreDataUtil {
  
  lazy var managedContext: NSManagedObjectContext! = {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    return managedContext
  }()
 
  func createUser(_ username: String, password: String) {
    let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as! User
   
    user.username = username
    user.password = password
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print(error.userInfo)
    }
  }
  
  func fetchUser() -> User? {
    
    let fetchRequest: NSFetchRequest<User>
    
    if #available(iOS 10.0, *) {
      fetchRequest = User.fetchRequest() as! NSFetchRequest<User>
    } else {
      fetchRequest = NSFetchRequest(entityName: "User")
    }
    
    let users: [User]?
    
    do {
      users = try managedContext.fetch(fetchRequest)
      return users?.last
    } catch let error as NSError {
      print(error.userInfo)
    }

    return nil
  }
}
