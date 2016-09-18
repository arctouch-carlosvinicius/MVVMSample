//
//  MockService.swift
//  MVVMRxSwift
//
//  Created by Carlos Vinicius on 9/13/16.
//

import RxSwift

enum StatusRequest: Int {
  case success = 1
  case fail = 0
}

struct Auth {
  let status: StatusRequest
}

struct AuthResponse {
  let token: String
  let status: StatusRequest
}

class APIService {
  
  func getAuthToken(_ login: String, password: String) -> Observable<AuthResponse> {
    let dummyAuthResponse: AuthResponse
    
    // fake response fail
    if login == "ABCDE" {
      dummyAuthResponse = AuthResponse(token: "404", status: .fail)
    } else {
      
      dummyAuthResponse = AuthResponse(token: "token->login:\(login), password:\(password)", status: .success)
    }
    
    return Observable.just(dummyAuthResponse)
  }
}
