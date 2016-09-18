//
//  LoginViewModel.swift
//  MVVMsample
//
//  Created by Carlos Vinicius on 9/11/16.
//

import RxSwift

class LoginViewModel {
  
  let validatedUsername: Observable<Bool>
  let validatedPassword: Observable<Bool>
  let signInButtonEnabled: Observable<Bool>
  
  let authResponseMock: Observable<Auth>
  let disposeBag = DisposeBag()
  
  init(input: (username: Observable<String>, password: Observable<String>, didPressSignin: Observable<Void>)) {
    
    validatedUsername = input.username.map { newValue in
      print("validatedUsername : \(newValue)")
      return newValue.characters.count > 4
    }
    
    validatedPassword = input.password.map { newValue in
      return newValue.characters.count > 4
    }
    
    signInButtonEnabled = Observable.combineLatest(validatedUsername, validatedPassword) { (validUsername, validPass) in
      return (validUsername && validPass)
    } .shareReplay(1)
    
    let userInput = Observable.combineLatest(input.username, input.password) { (username, password) -> (String, String) in
      return (username, password)
    }
    
    let mockAuthService = APIService()
    authResponseMock = input.didPressSignin
      .throttle(5, scheduler: MainScheduler.asyncInstance)
      .withLatestFrom(userInput)
      .flatMap { (username, password) in
        return mockAuthService.getAuthToken(username, password: password)
      }.map { authResponse in
        return Auth(status: authResponse.status)
      }
  }
  
  func saveUser(_ username: String, password: String) {
    let coreData = CoreDataUtil()
    coreData.createUser(username, password: password)
  }
  
  
}
