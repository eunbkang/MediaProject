//
//  Movie.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let posterImagePath: String
    let backdropImagePath: String
    let releaseDate: String
    let overview: String
    let genreIds: [Int]
    let rate: Double
    
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
        
        for id in genreIds {
            if let genre = genreDict[id] {
                text += "#" + genre + " "
            }
        }
        return text
    }
}
