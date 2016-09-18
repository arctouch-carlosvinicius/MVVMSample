//
//  DetailViewController.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/13/16.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var username: UILabel!
  var loadingView = true
  
  var viewModel: DetailViewModel? {
    didSet {
      viewModel?.viewProtocol = self
      updateDisplay()
    }
    
    willSet {
      viewModel?.viewProtocol = nil
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    loadingView = false
    updateDisplay()
  }
  
  fileprivate func updateDisplay() {
    if loadingView {
      return
    }

    if let viewModel = viewModel {
      username.text = viewModel.userModel?.username
    } else {
      username.text = ""
    }
  }
}

extension DetailViewController: DetailViewModelViewProtocol {
  
  func didUpdateData(viewModel: DetailViewModelProtocol) {
    updateDisplay()
  }
}
