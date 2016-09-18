//
//  DetailViewModel.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/13/16.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol {
  
  weak var viewProtocol: DetailViewModelViewProtocol?
  
  private(set) var userModel: UserInfo? {
    didSet {
      viewProtocol?.didUpdateData(viewModel: self)
    }
  }
  
  var modelProtocol: DetailModelProtocol? {
    didSet {
      modelProtocol?.detail({ user in
        guard let strongSelf = user else { return }
        self.userModel = strongSelf
      })
    }
  }

}
