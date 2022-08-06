//
//  FirstViewController.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 9/7/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLoginTap (_ sender: Any) {
        let model = NetworkModel()
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
                
                guard let token = token, !token.isEmpty else {
                    return
                }
                
                LocalDataModel.save(token: token)
                
                self?.presentVC()
            }
        }
    }
    
    func presentVC() {
        let tabBarVC = UITabBarController()
        let heroesTableVC = UINavigationController(rootViewController: HeoresTableViewController())
        let logOutVC = UINavigationController(rootViewController: LogOutViewController())
        
        logOutVC.title = "LogOut"
        
        
        tabBarVC.setViewControllers([heroesTableVC, logOutVC], animated: false)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let images = ["table", "rectangle.portrait.and.arrow.right"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true)
    }
}
