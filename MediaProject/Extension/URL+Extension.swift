//
//  URL+Extension.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation

extension URL {
    enum BaseUrl: String {
        case tmdbBase = "api.themoviedb.org"
        case tmdbImage = "image.tmdb.org"
        case youTubeBase = "www.youtube.com"
        
        var basePath: String {
            switch self {
            case .tmdbBase: return "/3"
            case .tmdbImage: return "/t/p/w500"
            case .youTubeBase: return "/embed"
            }
        }
    }
    
    enum PathType {
        case trendingAll
        case trendingMovie
        case trendingTV
        case tvDetail
        case tvSeason
        case movieCredit
        case movieVideo
        case movieSimilar
        case image
        case youTube
        
        var baseUrl: BaseUrl {
            switch self {
            case .image: return .tmdbImage
            case .youTube: return .youTubeBase
            default: return .tmdbBase
            }
        }
        
        func makePath(id: String?, season: Int?) -> String {
            switch self {
            case .trendingAll: return "/trending/all/week"
            case .trendingMovie: return "/trending/movie/week"
            case .trendingTV: return "/trending/tv/week"
            case .tvDetail:
                guard let id else { return "" }
                return "/tv/\(id)"
            case .tvSeason:
                guard let id, let season else { return "" }
                return "/tv/\(id)/season/\(season)"
            case .movieCredit:
                guard let id else { return "" }
                return "/movie/\(id)/credits"
            case .movieVideo:
                guard let id else { return "" }
                return "/movie/\(id)/videos"
            case .movieSimilar:
                guard let id else { return "" }
                return "/movie/\(id)/similar"
            case .image:
                guard let id else { return "" }
                return id
            case .youTube:
                guard let id else { return "" }
                return "/\(id)"
            }
        }
        
        func makeUrl(id: String?, season: Int?, page: Int?) -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = self.baseUrl.rawValue
            components.path = self.baseUrl.basePath + makePath(id: id, season: season)
            
            components.queryItems = []
            
            if self.baseUrl == .tmdbBase {
                let languageQuery = URLQueryItem(name: "language", value: "ko-KR")
                components.queryItems?.append(languageQuery)
            }
            
            if let page {
                let pageQuery = URLQueryItem(name: "page", value: "\(page)")
                components.queryItems?.append(pageQuery)
            }
            
            return components.url
        }
    }
}
