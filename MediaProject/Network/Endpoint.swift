//
//  Endpoint.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation

enum Endpoint {
    case trending
    case credit
    
    var requestUrl: String {
        switch self {
        case .trending: return URL.makeEndPointUrl("trending/movie/week?language=ko-KR")
        case .credit: return URL.makeEndPointUrl("")
        }
    }
}
