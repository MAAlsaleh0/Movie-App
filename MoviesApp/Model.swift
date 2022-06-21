//
//  Model.swift
//  MoviesApp
//
//  Created by Mohammed Alsaleh on 22/11/1443 AH.
//

// Model.swift

import Foundation

struct Model: Codable {
    var page: Int
    var results: [Result]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result: Codable {
    var genreIDS: [Int]
    var originalLanguage: OriginalLanguage
    var originalTitle: String?
    var posterPath: String
    var video: Bool?
    var voteAverage: Double
    var overview: String
    var releaseDate: String?
    var voteCount: Int
    var title: String?
    var adult: Bool?
    var backdropPath: String
    var id: Int
    var popularity: Double
    var mediaType: MediaType
    var originalName: String?
    var originCountry: [String]?
    var name, firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case title, adult
        case backdropPath = "backdrop_path"
        case id, popularity
        case mediaType = "media_type"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case name
        case firstAirDate = "first_air_date"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case tr = "tr"
}
