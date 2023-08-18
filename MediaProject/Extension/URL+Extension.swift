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
    static let languageQuery = "?language=ko-KR"
    static let youTubeBaseUrl = "https://www.youtube.com/embed/"
    
    static func makeEndPointUrl() -> String {
        return baseUrl + "trending/movie/week" + languageQuery
    }
    
    static func makeTVTrendingUrl() -> String {
        return baseUrl + "trending/tv/week" + languageQuery
    }
    
    static func makeTVDetailUrl(seriesId id: Int) -> String {
        return baseUrl + "tv/\(id)" + languageQuery
    }
    
    static func makeTVSeasonUrl(seriesId id: Int, seasonNo: Int) -> String {
        return baseUrl + "tv/\(id)/season/\(seasonNo)" + languageQuery
    }
    
    static func makeImageUrl() -> String {
        return imageBaseUrl + "w500"
    }
    
    static func makeCreditUrl(movieId: Int) -> String {
        return baseUrl + "movie/\(movieId)/credits" + languageQuery
    }
    
    static func makeYouTubeUrl(with id: String) -> String {
        return youTubeBaseUrl + id
    }
    
    static func makeSimilarMovieUrl(movieId: Int) -> String {
        return baseUrl + "movie/\(movieId)/similar"
    }
}
