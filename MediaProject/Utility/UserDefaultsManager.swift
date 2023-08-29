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
    
    var name: String {
        get {
            return userDefaults.string(forKey: "name") ?? ProfileItem.name.text
        }
        set {
            userDefaults.set(newValue, forKey: "name")
        }
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: "nickname") ?? ProfileItem.nickname.text
        }
        set {
            userDefaults.set(newValue, forKey: "nickname")
        }
    }
    
    var introduction: String {
        get {
            return userDefaults.string(forKey: "introduction") ?? ProfileItem.introduction.text
        }
        set {
            userDefaults.set(newValue, forKey: "introduction")
        }
    }
}
