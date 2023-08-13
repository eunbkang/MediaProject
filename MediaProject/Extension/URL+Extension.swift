//
//  URL+Extension.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation

extension URL {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/"
    
    static func makeEndPointUrl(_ endPoint: String) -> String {
        return baseUrl + endPoint
    }
    
    static func makeImageUrl(_ image: String) -> String {
        return imageBaseUrl + image
    }
}
