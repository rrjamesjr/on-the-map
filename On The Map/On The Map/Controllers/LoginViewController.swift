//
//  LoginViewController.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = "allisha.james@gmail.com"
        passwordTextField.text = "Silver30"
    }
    
    @IBAction func login(_ sender: Any) {
        toggleState()
        UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
    }
    
    fileprivate func handleLoginResponse(success: Bool, error: Error?) {
        self.toggleState()
        if success {
            print(UdacityClient.userInfo!.account.key)
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
        else {
            var message = error?.localizedDescription ?? "An error was encountered. Please try again later"
            if let error = error as? OnTheMapError {
                message = error.localizedDescription
                
            }
            
            let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            show(alertVC, sender: nil)
        }
    }
    
    fileprivate func toggleState() {
        emailTextField.isEnabled = !emailTextField.isEnabled
        passwordTextField.isEnabled = !passwordTextField.isEnabled
        loginButton.isEnabled = !loginButton.isEnabled
        
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
        else {
            activityIndicator.startAnimating()
        }
    }
}
