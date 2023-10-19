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
    let apiLink: String
    let imageID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case apiLink = "api_link"
        case imageID = "image_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        apiLink = (try? container.decode(String.self, forKey: .apiLink)) ?? ""
        imageID = (try? container.decode(String.self, forKey: .imageID)) ?? ""
    }
}

// MARK: - ArtworkDetailData
struct ArtworkDetailData: Decodable {
    let data: ArtworkDetail
    let info: Info
    let config: Config
}

// MARK: - ArtworkDetail
struct ArtworkDetail: Decodable {
    let id: Int
    let dateDisplay, artistDisplay, placeOfOrigin, artworkDescription, dimensions, mediumDisplay, creditLine, imageID: String
    
    let artworkTypeID: Int
    let artworkTypeTitle: String
    
    let departmentID, departmentTitle: String
    
    let artistID: Int
    let artistTitle: String
    
    let categoryTitles, termTitles, classificationTitles, materialTitles, themeTitles: [String]
    let sourceUpdatedAt, updatedAt, timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case id, dimensions, timestamp
        case dateDisplay = "date_display"
        case artistDisplay = "artist_display"
        case placeOfOrigin = "place_of_origin"
        case artworkDescription = "description"
        case mediumDisplay = "medium_display"
        case creditLine = "credit_line"
        case imageID = "image_id"
        
        case artworkTypeID = "artwork_type_id"
        case artworkTypeTitle = "artwork_type_title"
        
        case departmentID = "department_id"
        case departmentTitle = "department_title"
        
        case artistID = "artist_id"
        case artistTitle = "artist_title"
        
        case categoryTitles = "category_titles"
        case termTitles = "term_titles"
        case classificationTitles = "classification_titles"
        case materialTitles = "material_titles"
        case themeTitles = "theme_titles"
        
        case sourceUpdatedAt = "source_updated_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        dimensions = (try? container.decode(String.self, forKey: .dimensions)) ?? ""
        dateDisplay = (try? container.decode(String.self, forKey: .dateDisplay)) ?? ""
        artistDisplay = (try? container.decode(String.self, forKey: .artistDisplay)) ?? ""
        placeOfOrigin = (try? container.decode(String.self, forKey: .placeOfOrigin)) ?? ""
        artworkDescription = (try? container.decode(String.self, forKey: .artworkDescription)) ?? ""
        mediumDisplay = (try? container.decode(String.self, forKey: .mediumDisplay)) ?? ""
        creditLine = (try? container.decode(String.self, forKey: .creditLine)) ?? ""
        imageID = (try? container.decode(String.self, forKey: .imageID)) ?? ""
        
        artworkTypeID = (try? container.decode(Int.self, forKey: .artworkTypeID)) ?? 0
        artworkTypeTitle = (try? container.decode(String.self, forKey: .artworkTypeTitle)) ?? ""
        
        departmentID = (try? container.decode(String.self, forKey: .departmentID)) ?? ""
        departmentTitle = (try? container.decode(String.self, forKey: .departmentTitle)) ?? ""
        
        artistID = (try? container.decode(Int.self, forKey: .artistID)) ?? 0
        artistTitle = (try? container.decode(String.self, forKey: .artistTitle)) ?? ""
        
        categoryTitles = (try? container.decode([String].self, forKey: .categoryTitles)) ?? []
        termTitles = (try? container.decode([String].self, forKey: .termTitles)) ?? []
        classificationTitles = (try? container.decode([String].self, forKey: .classificationTitles)) ?? []
        materialTitles = (try? container.decode([String].self, forKey: .materialTitles)) ?? []
        themeTitles = (try? container.decode([String].self, forKey: .themeTitles)) ?? []
        
        sourceUpdatedAt = (try? container.decode(String.self, forKey: .sourceUpdatedAt)) ?? ""
        updatedAt = (try? container.decode(String.self, forKey: .updatedAt)) ?? ""
        timestamp = (try? container.decode(String.self, forKey: .timestamp)) ?? ""
    }
}
