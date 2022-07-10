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

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func onLoginTap (_ sender: Any) {
        let nextVC = HeoresTableViewController()
        navigationController?.setViewControllers([nextVC], animated: true)
    }
}
