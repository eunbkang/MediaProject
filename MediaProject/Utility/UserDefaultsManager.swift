//
//  UserDefaultsManager.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/27.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    let userDefaults = UserDefaults.standard
    
    var isOnboardingCompleted: Bool {
        get {
            return userDefaults.bool(forKey: "isOnboardingCompleted")
        }
        set {
            userDefaults.set(newValue, forKey: "isOnboardingCompleted")
        }
    }
}
