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
    
    private var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let hero = hero else {
            return
        }
        
        self.title = hero.name
        
        self.nameLabel.text = hero.name
        self.descriptionTextView.text = hero.description
        self.imageView.setImage(url: hero.photo)
    }
    
    
    func set(model: Hero) {
        hero = model
    }
}
