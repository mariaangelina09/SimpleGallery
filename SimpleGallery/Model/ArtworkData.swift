//
//  Artwork.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 18/10/23.
//

import Foundation

//struct ArtworkData: Codable {
//    let artworks: [Artwork]
//    
//    private enum CodingKeys: String, CodingKey {
//        case artworks
//    }
//    
//    init(artworks: [Artwork]) {
//        self.artworks = artworks
//    }
//    
//    init(from decoder:Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        artworks = try values.decode([Artwork].self, forKey: .artworks)
//    }
//}
//
//struct Artwork: Codable {
//    let title: String
//    let imageIdentifier: String
//}

// MARK: - ArtworkData
struct ArtworkData: Decodable {
    let pagination: Pagination
    let data: [Artwork]
    let info: Info
    let config: Config
}

// MARK: - Config
struct Config: Decodable {
    let iiifURL: String
    let websiteURL: String
}

// MARK: - Artwork
struct Artwork: Decodable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    let artistDisplay, placeOfOrigin: String
    let dimensionsDetail: [DimensionsDetail]
    let mediumDisplay: String
    let creditLine: String
    let catalogueDisplay, publicationHistory, exhibitionHistory, provenanceText: String?
    let edition: String?
    let publishingVerificationLevel: PublishingVerificationLevel
    let internalDepartmentID: Int
    let copyrightNotice: String?
    let color: Color
    let onLoanDisplay: String?
    let galleryTitle, galleryID, nomismaID: String?
    let artworkTypeTitle: String
    let artworkTypeID: Int
    let departmentTitle, departmentID: String
    let artistID: Int?
    let artistTitle: String?
    let termTitles: [String]
    let classificationID, classificationTitle: String
    let altClassificationIDS, classificationIDS, classificationTitles: [String]
    let materialID: String?
    let altMaterialIDS, materialIDS, materialTitles: [String]
    let imageID: String
    let suggestAutocompleteAll: [SuggestAutocompleteAll]
    let sourceUpdatedAt, updatedAt, timestamp: Date
}

// MARK: - Color
struct Color: Decodable {
    let h, l, s: Int
    let percentage: Double
    let population: Int
}

// MARK: - DimensionsDetail
struct DimensionsDetail: Decodable {
    let depthCM, depthIn, widthCM, widthIn: Double
    let heightCM, heightIn, diameterCM, diameterIn: Double
    let clarification: String?
}

enum PublishingVerificationLevel: Decodable {
    case webBasic
    case webCataloged
}

// MARK: - SuggestAutocompleteAll
struct SuggestAutocompleteAll: Decodable {
    let input: [String]
    let contexts: Contexts
    let weight: Int?
}

// MARK: - Contexts
struct Contexts: Decodable {
    let groupings: [Grouping]
}

enum Grouping: Decodable {
    case accession
    case title
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    let lqip: String
    let width, height: Int?
    let altText: String
}

// MARK: - Info
struct Info: Decodable {
    let licenseText: String
    let licenseLinks: [String]
    let version: String
}

// MARK: - Pagination
struct Pagination: Decodable {
    let total, limit, offset, totalPages: Int
    let currentPage: Int
    let nextURL: String
}
