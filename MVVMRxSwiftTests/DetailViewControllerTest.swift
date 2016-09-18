//
//  DetailViewControllerTest.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/18/16.
//

import XCTest
@testable import MVVMRxSwift

class DetailViewControllerTest: XCTestCase {
  
  var currentExpectaion: XCTestExpectation?
  var expectedUserInfo: UserInfo?
  
  func testDefaultInit() {
    let viewModel = DetailViewModel()
    XCTAssertNil(viewModel.userModel)
    XCTAssertNil(viewModel.viewProtocol)
    XCTAssertNil(viewModel.modelProtocol)
  }
  
  func testDetail() {
    let viewModel = DetailViewModel()
    let userInfo = UserInfo(name: "Steve Jobs")
    let model = DetailModel(user: userInfo)
    viewModel.modelProtocol = model
    
    XCTAssertNotNil(viewModel.userModel)
    
    guard let user = viewModel.userModel else { return }
    
    XCTAssertEqual("Steve Jobs", user.username)
  }
  
}
