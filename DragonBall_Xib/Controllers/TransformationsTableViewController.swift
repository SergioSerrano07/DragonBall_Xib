//
//  TransformationsTableViewController.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 20/7/22.
//

import UIKit

class TransformationsTableViewController: UITableViewController {
        
    let detailVC = DetailViewController()
    private var transformation: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformations"
        
        tableView?.register(
            UINib(nibName: "TableViewCell", bundle: nil),
            forCellReuseIdentifier: "reuseIdentifier")
        
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    func set(model: [Transformation]) {
        transformation = model
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transformation.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.set(model: transformation[indexPath.row])

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nextVC = DetailViewController()
//
//        nextVC.set(model: transformations[indexPath.row])
//
//        navigationController?.pushViewController(nextVC, animated: true)
//    }
    
}
