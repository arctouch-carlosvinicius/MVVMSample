//
//  LoginViewController.swift
//  MVVMsample
//
//  Created by Carlos Vinicius on 9/11/16.
//

import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var enterButton: UIButton!
  
  let disposeBag = DisposeBag()
  
  var viewModel: LoginViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = LoginViewModel(
      input:(
        username: usernameTextField.rx.text.asObservable(),
        password: passwordTextField.rx.text.asObservable(),
        didPressSignin: enterButton.rx.tap.asObservable()
       )
    )
    
    viewModel.signInButtonEnabled
      .do( onNext: { value in
        self.enterButton.isHidden = !value
      })
      .bindTo(enterButton.rx.enabled)
      .addDisposableTo(disposeBag)
    
    
    viewModel.authResponseMock
      .subscribe { response in
        if response.element?.status == StatusRequest.success {
          self.presentDetailViewController()
        } else {
          self.showAlertFailSignin()
        }
        
        print(response)
      }
      .addDisposableTo(disposeBag)
    
    enterButton.rx.tap.subscribe(
      onNext: {
        self.showActivityIndicatory(self.view)
    }).addDisposableTo(disposeBag)
  }

  
  func presentDetailViewController() {
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    
    //Note: The second flow, DetailViewController, is being created through Protocol-oriented

    let user = UserInfo(username: self.usernameTextField.text!)
    
    let viewModel = DetailViewModel()
    viewModel.modelProtocol = DetailModel(user: user)
    viewController.viewModel = viewModel
    
    self.present(viewController, animated: true, completion: nil)
  }
  
  
  func showAlertFailSignin() {
    let alert = UIAlertController(title:nil,
                                   message: "User not found! Get out bitch!",
                            preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "Ok",
                                     style: .default) {
                                   (action: UIAlertAction) -> Void in
    }
    
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  func showActivityIndicatory(_ view: UIView) {
    
    view.isUserInteractionEnabled = false
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    activityIndicator.center = view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.activityIndicatorViewStyle = .whiteLarge
    
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
  }
  
}
