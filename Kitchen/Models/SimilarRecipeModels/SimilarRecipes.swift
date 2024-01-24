//
//  SimilarRecipes.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

// MARK: - SimilarRecipe
struct SimilarRecipe: Codable {
    let id: Int
    let imageType: ImageType
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String

    enum CodingKeys: String, CodingKey {
        case id, imageType, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
    }
}

enum ImageType: String, Codable {
    case png
    case jpg
    case unknown // Add a default case to handle unknown values if needed

}

typealias SimilarRecipes = [SimilarRecipe]
