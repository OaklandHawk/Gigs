//
//  LoginViewController.swift
//  Gigs
//
//  Created by Taylor Lyles on 9/4/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

enum LoginType {
	case signUp
	case logIn
}


class LoginViewController: UIViewController {
	
	var gigController: GigController!
	var loginType = LoginType.signUp
	
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginSegmentControl: UISegmentedControl!
	@IBOutlet weak var signUpButton: UIButton!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

	@IBAction func loginSignUpSwitch(_ sender: UISegmentedControl) {
		guard let sender = sender as? UISegmentedControl else { return }
		if sender.selectedSegmentIndex == 0{
			loginType = .signUp
			signUpButton.setTitle("Sign Up", for: .normal)
		} else {
			loginType = .logIn
			signUpButton.setTitle("Log In", for: .normal)
		}
	}
	

}
