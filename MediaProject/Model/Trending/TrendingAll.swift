//
//  Person.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/09/02.
//

import Foundation

struct TrendingAll: Codable {
    let totalPages, totalResults: Int
    let page: Int
    let results: [Trending]
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page, results
    }
}

struct Trending: Codable {
    let id: Int
    let name, title: String?
    let originalName, originalTitle: String?
    let overview: String?
    let mediaType: MediaType
    let posterPath, backdropPath, profilePath: String?
    let genreIds: [Int]?
    let voteAverage: Double?
    let releaseDate, firstAirDate: String?
    let popularity: Double
    let gender: Gender?
    let knownForDepartment: Department?
    
    enum CodingKeys: String, CodingKey {
        case id, name, title, overview
        case popularity, gender
        case originalName = "original_name"
        case originalTitle = "original_title"
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case profilePath = "profile_path"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case knownForDepartment = "known_for_department"
    }
    
    var genres: String {
        let genreDict = [
            12: "Adventure",
            14: "Fantasy",
            16: "Animation",
            18: "Drama",
            27: "Horror",
            28: "Action",
            35: "Comedy",
            36: "History",
            37: "Western",
            53: "Thriller",
            80: "Crime",
            99: "Documentary",
            878: "Science Fiction",
            9648: "Mystery",
            10402: "Music",
            10749: "Romance",
            10751: "Family",
            10752: "War",
            10759: "Action & Adventure",
            10762: "Kids",
            10763: "News",
            10764: "Reality",
            10765: "Sci-Fi & Fantasy",
            10766: "Soap",
            10767: "Talk",
            10768: "War & Politics",
            10770: "TV Movie"
        ]
        var text: String = ""
        guard let genreIds else { return "" }
        
        for id in genreIds {
            if let genre = genreDict[id] {
                text += "#" + genre + " "
            }
        }
        return text
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}

enum Gender: Int, Codable {
    case male = 1
    case female = 2
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
    case creator = "Creator"
}
