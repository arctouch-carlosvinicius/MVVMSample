//
//  DetailModel.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/18/16.
//

import Foundation

class DetailModel: DetailModelProtocol {
  
  fileprivate var user: UserInfo?
  
  init(user: UserInfo?) {
    self.user = user
  }
  
  func detail(_ completionHandler: @escaping (_ detail :UserInfo?) -> Void) {
    DispatchQueue.global().async {
      completionHandler(self.user)
    }
  }
}
