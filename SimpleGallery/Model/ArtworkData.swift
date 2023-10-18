//
//  Artwork.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 18/10/23.
//

import Foundation

struct ArtworkData: Codable {
    let artworks: [Artwork]
    
    private enum CodingKeys: String, CodingKey {
        case artworks
    }
    
    init(artworks: [Artwork]) {
        self.artworks = artworks
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artworks = try values.decode([Artwork].self, forKey: .artworks)
    }
}

struct Artwork: Codable {
    let title: String
    let imageIdentifier: String
}
