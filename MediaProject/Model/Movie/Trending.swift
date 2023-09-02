//
//  Trending.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/14.
//

import Foundation

// MARK: - MovieTrending
struct MovieTrending: Codable {
    let totalPages, totalResults, page: Int
    let results: [MovieResult]

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page, results
    }
}

// MARK: - Result
struct MovieResult: Codable {
    let originalLanguage: String
    let genreIDS: [Int]
    let posterPath: String?
    let id: Int
    let releaseDate: String
    let voteAverage: Double
    let backdropPath: String?
    let voteCount: Int
    let mediaType: MediaType?
    let video: Bool
    let originalTitle, overview: String
    let popularity: Double
    let title: String
    let adult: Bool
    
    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case posterPath = "poster_path"
        case id
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case mediaType = "media_type"
        case video
        case originalTitle = "original_title"
        case overview, popularity, title, adult
    }
    
    var genres: String {
        let genreDict = [
            28: "Action",
            12: "Adventure",
            16: "Animation",
            35: "Comedy",
            80: "Crime",
            99: "Documentary",
            18: "Drama",
            10751: "Family",
            14: "Fantasy",
            36: "History",
            27: "Horror",
            10402: "Music",
            9648: "Mystery",
            10749: "Romance",
            878: "Science Fiction",
            10770: "TV Movie",
            53: "Thriller",
            10752: "War",
            37: "Western"
        ]
        var text: String = ""
        
        for id in genreIDS {
            if let genre = genreDict[id] {
                text += "#" + genre + " "
            }
        }
        return text
    }
}

// MARK: - TVTrending
struct TVTrending: Codable {
    let page: Int
    let results: [TVResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TVResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let name, originalLanguage, originalName, overview: String
    let posterPath: String?
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
    
    var genres: String {
        let genreDict = [
            10759: "Action & Adventure",
            16: "Animation",
            35: "Comedy",
            80: "Crime",
            99: "Documentary",
            18: "Drama",
            10751: "Family",
            10762: "Kids",
            9648: "Mystery",
            10763: "News",
            10764: "Reality",
            10765: "Sci-Fi & Fantasy",
            10766: "Soap",
            10767: "Talk",
            10768: "War & Politics",
            37: "Western"
        ]
        var text: String = ""
        
        for id in genreIDS {
            if let genre = genreDict[id] {
                text += "#" + genre + " "
            }
        }
        return text
    }
}
