//
//  UserProtocol.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/18/16.
//

import Foundation

protocol DetailModelProtocol {
  
  func detail(_ completionHandler: @escaping (_ user: UserInfo?) -> Void)
}
