//
//  FirstViewController.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 9/7/22.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func onButtonTap(_ sender: Any) {
        let nextVC = SecondViewController()
        navigationController?.setViewControllers([nextVC], animated: true)
    }
}
