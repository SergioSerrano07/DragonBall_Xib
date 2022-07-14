//
//  LocalDataModel.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 14/7/22.
//

import Foundation

private enum Constant {
    static let tokenKey = "KCToken"
}


class LocalDataModel {
    private static let userDefaults = UserDefaults.standard

    static func getToken() -> String? {
        userDefaults.string(forKey: Constant.tokenKey)
    }

    static func save(token: String) {
        userDefaults.set(token, forKey: Constant.tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: Constant.tokenKey)
    }
}
