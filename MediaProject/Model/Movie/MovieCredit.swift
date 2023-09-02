//
//  MovieCredit.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/15.
//

import Foundation

// MARK: - MovieCredit
struct MovieCredit: Codable {
    let cast: [Cast]
    let crew: [Crew]
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: Department
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int
    let character, creditID: String
    let order: Int

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

// MARK: - Crew
struct Crew: Codable {
    let knownForDepartment: Department?
    let popularity: Double
    let gender: Int
    let originalName: String
    let adult: Bool
    let creditID: String
    let id: Int
    let name: String
    let job: String?
    let profilePath: String?
    let department: String?
    let character: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case popularity, gender
        case originalName = "original_name"
        case adult
        case creditID = "credit_id"
        case id, name, job
        case profilePath = "profile_path"
        case department
        case character
        case order
    }
}
