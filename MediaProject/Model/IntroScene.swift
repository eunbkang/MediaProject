//
//  IntroScene.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/27.
//

import Foundation

enum IntroScene: Int, CaseIterable {
    case trendingMovie, movieInfo, theaterMap, trendingTVShow
    
    var imageName: String {
        switch self {
        case .trendingMovie: return "trendingMovie"
        case .movieInfo: return "movieInfo"
        case .theaterMap: return "theaterMap"
        case .trendingTVShow: return "trendingTVShow"
        }
    }
    
    var introText: String {
        switch self {
        case .trendingMovie: return "트랜딩 영화를 볼 수 있어요."
        case .movieInfo: return "영화 정보를 볼 수 있어요."
        case .theaterMap: return "주변 영화관을 확인할 수 있어요."
        case .trendingTVShow: return "트랜딩 TV쇼를 볼 수 있어요."
        }
    }
}
