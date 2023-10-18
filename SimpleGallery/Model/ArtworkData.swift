//
//  Artwork.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 18/10/23.
//

import Foundation

// MARK: - ArtworkData
struct ArtworkData: Decodable {
    let pagination: Pagination
    let data: [Artwork]
    let info: Info
    let config: Config
}

// MARK: - Pagination
struct Pagination: Decodable {
    let total, limit, offset, totalPages, currentPage: Int
    let nextURL: String
    
    enum CodingKeys: String, CodingKey {
        case total, limit, offset
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextURL = "next_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        total = (try? container.decode(Int.self, forKey: .total)) ?? 0
        limit = (try? container.decode(Int.self, forKey: .limit)) ?? 0
        offset = (try? container.decode(Int.self, forKey: .offset)) ?? 0
        totalPages = (try? container.decode(Int.self, forKey: .totalPages)) ?? 0
        currentPage = (try? container.decode(Int.self, forKey: .currentPage)) ?? 0
        nextURL = (try? container.decode(String.self, forKey: .nextURL)) ?? ""
    }
}

// MARK: - Info
struct Info: Decodable {
    let licenseText, version: String
    let licenseLinks: [String]
    
    enum CodingKeys: String, CodingKey {
        case version
        case licenseText = "license_text"
        case licenseLinks = "license_links"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        licenseText = (try? container.decode(String.self, forKey: .licenseText)) ?? ""
        version = (try? container.decode(String.self, forKey: .version)) ?? ""
        licenseLinks = (try? container.decode([String].self, forKey: .licenseLinks)) ?? []
    }
}

// MARK: - Config
struct Config: Decodable {
    let iiifURL, websiteURL: String
    
    enum CodingKeys: String, CodingKey {
        case iiifURL = "iiif_url"
        case websiteURL = "website_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        iiifURL = (try? container.decode(String.self, forKey: .iiifURL)) ?? ""
        websiteURL = (try? container.decode(String.self, forKey: .websiteURL)) ?? ""
    }
}

// MARK: - Artwork
struct Artwork: Decodable {
    let id: Int
//    let apiModel: APIModel
//    let apiLink: String
//    let isBoosted: Bool
//    let title: String
//    let altTitles: String?
//    let thumbnail: Thumbnail
//    let mainReferenceNumber: String
//    let hasNotBeenViewedMuch: Bool
//    let boostRank: String?
//    let dateStart, dateEnd: Int
//    let dateDisplay: String
//    let dateQualifierTitle: DateQualifierTitle
//    let dateQualifierID: Int?
//    let artistDisplay, placeOfOrigin: String
//    let datumDescription: String?
//    let dimensions: String
//    let dimensionsDetail: [DimensionsDetail]
//    let mediumDisplay: String
//    let inscriptions: String?
//    let creditLine: String
//    let catalogueDisplay, publicationHistory, exhibitionHistory, provenanceText: String?
//    let edition: String?
//    let publishingVerificationLevel: PublishingVerificationLevel
//    let internalDepartmentID: Int
//    let fiscalYear: Int?
//    let fiscalYearDeaccession: String?
//    let isPublicDomain, isZoomable: Bool
//    let maxZoomWindowSize: Int
//    let copyrightNotice: String?
//    let hasMultimediaResources, hasEducationalResources, hasAdvancedImaging: Bool
//    let colorfulness: Double
//    let color: Color
//    let latitude, longitude: Double?
//    let latlon: String?
//    let isOnView: Bool
//    let onLoanDisplay: String?
//    let galleryTitle, galleryID, nomismaID: String?
//    let artworkTypeTitle: String
//    let artworkTypeID: Int
//    let departmentTitle, departmentID: String
//    let artistID: Int?
//    let artistTitle: String?
//    let altArtistIDS: [String?]
//    let artistIDS: [Int]
//    let artistTitles, categoryIDS, categoryTitles, termTitles: [String]
//    let styleID, styleTitle: String?
//    let altStyleIDS, styleIDS, styleTitles: [String]
//    let classificationID, classificationTitle: String
//    let altClassificationIDS, classificationIDS, classificationTitles: [String]
//    let subjectID: String?
//    let altSubjectIDS, subjectIDS, subjectTitles: [String]
//    let materialID: String?
//    let altMaterialIDS, materialIDS, materialTitles: [String]
//    let techniqueID: String?
//    let altTechniqueIDS, techniqueIDS, techniqueTitles, themeTitles: [String]
    let imageId: String
//    let altImageIDS, documentIDS, soundIDS: [String]
//    let videoIDS, textIDS, sectionIDS, sectionTitles: [String?]
//    let siteIDS: [String?]
//    let suggestAutocompleteAll: [SuggestAutocompleteAll]
//    let sourceUpdatedAt, updatedAt, timestamp: Date
//    let suggestAutocompleteBoosted: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageId = "image_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        imageId = (try? container.decode(String.self, forKey: .imageId)) ?? ""
    }
}

//enum APIModel: String, Decodable {
//    case artworks
//}
//
//// MARK: - Color
//struct Color: Decodable {
//    let h, l, s: Int
//    let percentage: Double
//    let population: Int
//}
//
//enum DateQualifierTitle: String, Decodable {
//    case c
//    case empty
//    case made
//}
//
//// MARK: - DimensionsDetail
//struct DimensionsDetail: Decodable {
//    let depthCM, depthIn, widthCM, widthIn: Double
//    let heightCM, heightIn, diameterCM, diameterIn: Double
//    let clarification: String?
//}
//
//enum PublishingVerificationLevel: String, Decodable {
//    case webBasic
//    case webCataloged
//}
//
//// MARK: - SuggestAutocompleteAll
//struct SuggestAutocompleteAll: Decodable {
//    let input: [String]
//    let contexts: Contexts
//    let weight: Int?
//}
//
//// MARK: - Contexts
//struct Contexts: Decodable {
//    let groupings: [Grouping]
//}
//
//enum Grouping: String, Decodable {
//    case accession
//    case title
//}
//
//// MARK: - Thumbnail
//struct Thumbnail: Decodable {
//    let lqip: String
//    let width, height: Int?
//    let altText: String
//}
