//
//  Cast.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation

struct Cast {
    let name: String
    let profileImage: String
    let character: String
    
    var profileImageUrl: String {
        let url = URL.makeImageUrl()
        return url + profileImage
    }
}
