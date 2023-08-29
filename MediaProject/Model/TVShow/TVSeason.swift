//
//  TVSeason.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/17.
//

import Foundation

// MARK: - TVSeason
struct TVSeason: Codable {
    let seasonId: String
    let airDate: String?
    let episodes: [Episode]
    let name, overview: String
    let id: Int
    let posterPath: String
    let seasonNumber: Int?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case seasonId = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case id
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

// MARK: - Episode
struct Episode: Codable {
    let airDate: String
    let episodeNumber: Int
    let episodeType: String
    let id: Int
    let name, overview, productionCode: String
    let runtime: Int?
    let seasonNumber, showID: Int
    let stillPath: String?
    let voteAverage: Double
    let voteCount: Int
    let crew, guestStars: [Crew]?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case id, name, overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case crew
        case guestStars = "guest_stars"
    }
    
    var stillUrl: String {
        guard let stillPath else { return "" }
        
        let url = URL.makeImageUrl()
        return url + stillPath
    }
}
