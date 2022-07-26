//
//  TableViewCell.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 9/7/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    
    func set(model: Hero) {
        self.heroName.text = model.name
        self.heroDescription.text = model.description
        self.heroImage.setImage(url: model.photo)
    }

    func set(model: Transformation) {
        self.heroName.text = model.name
        self.heroDescription.text = model.description
        self.heroImage.setImage(url: model.photo)
    }
    
    
}
