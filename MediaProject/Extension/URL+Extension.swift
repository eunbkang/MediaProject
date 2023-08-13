//
//  URL+Extension.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation

extension URL {
    static let baseUrl = "https://api.themoviedb.org/3/"
    
    static func makeEndPointUrl(_ endPoint: String) -> String {
        return baseUrl + endPoint
    }
}
