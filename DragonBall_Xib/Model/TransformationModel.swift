//
//  TransformationModel.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 20/7/22.
//

import UIKit

struct HeroTransformation: Decodable {
    let id: String
}

struct Transformation: Decodable {
    let description: String
    let name: String
    let hero: HeroTransformation
    let id: String
    let photo: URL
}
