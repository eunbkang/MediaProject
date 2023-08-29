//
//  MovieDetailSection.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation

enum MovieDetailSection: Int, CaseIterable {
    case poster
    case overview
    case cast
    case video
    case similar
    
    var header: String {
        switch self {
        case .poster: return ""
        case .overview: return "OverView"
        case .cast: return "Cast"
        case .video: return "Videos"
        case .similar: return "Similar Movies"
        }
    }
}
