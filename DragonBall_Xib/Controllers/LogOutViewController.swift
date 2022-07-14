//
//  LogOutViewController.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 14/7/22.
//

import UIKit

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LogOut"
        // Do any additional setup after loading the view.
    }


    @IBAction func onLogOutTap(_ sender: Any) {
        LocalDataModel.deleteToken()
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
