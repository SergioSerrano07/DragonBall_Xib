//
//  FirstViewController.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 9/7/22.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func onLoginTap (_ sender: Any) {
        let model = NetworkModel.shared
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
       
        guard !user.isEmpty, !password.isEmpty else {
            return
        }
        
        loginButton.isEnabled = false
        activityIndicator.startAnimating()
        
        model.login(user: user, password: password) { [weak self] token, _ in
            
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                
                let nextVC = HeoresTableViewController()
                self?.navigationController?.setViewControllers([nextVC], animated: true)
            }
        }
    }
}
