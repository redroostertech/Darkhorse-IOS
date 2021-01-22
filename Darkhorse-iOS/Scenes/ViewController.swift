//
//  ViewController.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/18/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var emailAddressTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var showHideButton: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginButton.applyCornerRadius()
    emailAddressTextField.delegate = self
    passwordTextField.delegate = self
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
  
  @IBAction func showHideButtonAction(_ sender: UIButton) {
    
  }
  
  @IBAction func loginButtonAction(_ sender: UIButton) {
    
  }
  
  @IBAction func registerButtonAction(_ sender: UIButton) {
    
  }
}

