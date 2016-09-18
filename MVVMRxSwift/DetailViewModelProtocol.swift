//
//  DetailModel.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/18/16.
//

import Foundation

protocol DetailViewModelViewProtocol: class {
  func didUpdateData(viewModel: DetailViewModelProtocol)
}

protocol DetailViewModelProtocol {
  var userModel: UserInfo? { get }
  var modelProtocol: DetailModelProtocol? { get set }
  var viewProtocol: DetailViewModelViewProtocol? { get set }
}
