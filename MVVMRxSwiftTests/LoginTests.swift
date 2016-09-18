//
//  LoginTests.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/13/16.
//

import XCTest
import RxSwift
import RxTest

@testable import MVVMRxSwift

class LoginTests: XCTestCase {

  var viewModel: LoginViewModel!
  var disposeBag: DisposeBag!
  
  override func setUp() {
    super.setUp()
    
    disposeBag = DisposeBag()
  }
  
  func testButtonIsDisabled() {
    
    viewModel = LoginViewModel(
      input: (
        username: Observable.just("A"),
        password: Observable.just("B"),
        didPressSignin: UIButton().rx.tap.asObservable()
      )
    )
    
    viewModel.signInButtonEnabled
      .subscribe( onNext: { disable in
        XCTAssertFalse(disable)
      }).addDisposableTo(disposeBag)
  }
  
  
  func testButtonIsEnabled() {
    viewModel = LoginViewModel(
      input: (
        username: Observable.just("ABCDEFGH"),
        password: Observable.just("123456"),
        didPressSignin: UIButton().rx.tap.asObservable()
      )
    )
    
    viewModel.signInButtonEnabled
      .subscribe( onNext: { disable in
        XCTAssertTrue(disable)
      }).addDisposableTo(disposeBag)
  }
  
  
  func testButtonIsDisabledThenEnabled() {
    var resultArray = [Bool]()
    viewModel = LoginViewModel(
      input: (
        username: ["ABCDEFG"].toObservable(),
        password: ["123", "123456"].toObservable(),
        didPressSignin: UIButton().rx.tap.asObservable()
      )
    )
    
    viewModel.signInButtonEnabled
      .subscribe(
        onNext: {
          resultArray.append($0)
        },
        onCompleted: {
          XCTAssertEqual(resultArray, [false, true])
        }
      )
      .addDisposableTo(disposeBag)
  }
  
  
  func testButtonIsEnabledThenDisbled() {
    var resultArray = [Bool]()
    viewModel = LoginViewModel(
      input: (
        username: ["ABCDEF"].toObservable().do( onNext :{ value in print("### Firing - username: \(value)")}),
        password: ["12345", "123"].toObservable().do( onNext :{ value in print("### Firing password: \(value)")}),
        didPressSignin: UIButton().rx.tap.asObservable().do( onNext :{ value in print("### Firing password: \(value)")})
      )
    )
    
    viewModel.signInButtonEnabled
      .subscribe(
        onNext: {
          resultArray.append($0)
        },
        onCompleted: {
          XCTAssertEqual(resultArray, [true, false])
        }
      )
      .addDisposableTo(disposeBag)
  }
  
  
  func testButtonStateThreeTimes() {
    
    // 1
    let scheduler = TestScheduler(initialClock: 0)
    
    // 2
    let usernameSchedule = scheduler.createHotObservable([
      next(0, "A"),
      next(200, "ABCDEF")
      ])
    
    // 3
    let passwordSchedule = scheduler.createHotObservable([
      next(0, "1"),
      next(300, "12345")
      ])
    
    // 4
    viewModel = LoginViewModel(input:
      (
        username: usernameSchedule.asObservable().do( onNext : { value in print("## username: \(value)")}),
        password: passwordSchedule.asObservable().do( onNext : { value in print("## pass: \(value)")}),
        didPressSignin: UIButton().rx.tap.asObservable().do( onNext :{ value in print("### signin: \(value)")})
      )
    )
    
    // 5
    var results = [Bool]()
    viewModel.signInButtonEnabled.subscribe( onNext: {
      results.append($0)
    }).addDisposableTo(disposeBag)
    
    // 6
    scheduler.start()
    
    // 7
    XCTAssertEqual(results, [false, false, true])
  }
  
  override func tearDown() {
    super.tearDown()
    disposeBag = nil
  }

}
