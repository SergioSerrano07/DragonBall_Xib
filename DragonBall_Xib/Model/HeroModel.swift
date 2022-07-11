//
//  HeroModel.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 10/7/22.
//

import UIKit

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool
}

