//
//  DetailViewController.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 9/7/22.
//

import UIKit



class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var transformationButton: UIButton!
    
    private var hero: Hero?
    var transformation: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hero?.name
        
        guard let hero = hero else {
            return
        }
        
        self.nameLabel.text = hero.name
        self.descriptionTextView.text = hero.description
        self.imageView.setImage(url: hero.photo)
        
        showTransformations()
    }
    
    
    func showTransformations() {
        guard let token = LocalDataModel.getToken() else { return }
        
        let networkModel = NetworkModel(token: token)
        networkModel.getTransformations(id: hero?.id ?? "") { [weak self] transformation, _ in
            guard let self = self else { return }
            
            self.transformation = transformation
            DispatchQueue.main.async {
                self.disableTransformationButton()
            }
        }
        
    }
    
    func disableTransformationButton() {
        if !transformation.isEmpty {
            transformationButton.alpha = 1
        } else {
            transformationButton.alpha = 0
        }
    }
    
    func set(model: Hero) {
        hero = model
    }
    
    @IBAction func onButtonTransformationsTap(_ sender: Any) {
        let nextVC = TransformationsTableViewController()
        
        nextVC.set(model: transformation)
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
