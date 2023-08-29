//
//  Profile.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/29.
//

import Foundation

struct Profile {
    var name: String
    var nickname: String
    var introduction: String
}

enum ProfileItem: Int, CaseIterable {
    case name
    case nickname
    case introduction
    
    var text: String {
        switch self {
        case .name: return "이름"
        case .nickname: return "닉네임"
        case .introduction: return "소개"
        }
    }
}
