//
//  MovieTrending.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/14.
//

import Foundation

// MARK: - MovieTrending
struct MovieTrending: Codable {
    let totalPages, totalResults, page: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page, results
    }
}

// MARK: - Result
struct Result: Codable {
    let originalLanguage: String
    let genreIDS: [Int]
    let posterPath: String
    let id: Int
    let releaseDate: String
    let voteAverage: Double
    let backdropPath: String
    let voteCount: Int
    let mediaType: MediaType
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
    
    var posterImageUrl: String {
        let url = URL.makeImageUrl()
        return url + posterPath
    }
    
    var backdropImageUrl: String {
        let url = URL.makeImageUrl()
        return url + backdropPath
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

enum MediaType: String, Codable {
    case movie = "movie"
}
