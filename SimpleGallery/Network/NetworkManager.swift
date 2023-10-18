//
//  NetworkManager.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 18/10/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    static func fetchArtworks(page: Int, limit: Int, completion: @escaping ([Artwork]?, Error?) -> Void) {
        let urlString = "https://api.artic.edu/api/v1/artworks?page=\(page)&limit=\(limit)"

        guard let url = URL(string: urlString) else {
            completion(nil, NetworkError.invalidURL)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
                
                let artworkData = try decoder.decode(ArtworkData.self, from: data)
                print(artworkData)
                let artworks = artworkData.data.map { artwork in
                    return Artwork(id: artwork.id,
                                   title: artwork.title,
                                   thumbnail: artwork.thumbnail,
                                   artistDisplay: artwork.artistDisplay,
                                   placeOfOrigin: artwork.placeOfOrigin,
                                   dimensionsDetail: artwork.dimensionsDetail,
                                   mediumDisplay: artwork.mediumDisplay,
                                   creditLine: artwork.creditLine,
                                   catalogueDisplay: artwork.catalogueDisplay,
                                   publicationHistory: artwork.publicationHistory,
                                   exhibitionHistory: artwork.exhibitionHistory,
                                   provenanceText: artwork.provenanceText,
                                   edition: artwork.edition,
                                   publishingVerificationLevel: artwork.publishingVerificationLevel,
                                   internalDepartmentID: artwork.internalDepartmentID,
                                   copyrightNotice: artwork.copyrightNotice,
                                   color: artwork.color,
                                   onLoanDisplay: artwork.onLoanDisplay,
                                   galleryTitle: artwork.galleryTitle,
                                   galleryID: artwork.galleryID,
                                   nomismaID: artwork.nomismaID,
                                   artworkTypeTitle: artwork.artworkTypeTitle,
                                   artworkTypeID: artwork.artworkTypeID,
                                   departmentTitle: artwork.departmentTitle,
                                   departmentID: artwork.departmentID,
                                   artistID: artwork.artistID,
                                   artistTitle: artwork.artistTitle,
                                   termTitles: artwork.termTitles,
                                   classificationID: artwork.classificationID,
                                   classificationTitle: artwork.classificationTitle,
                                   altClassificationIDS: artwork.altClassificationIDS,
                                   classificationIDS: artwork.classificationIDS,
                                   classificationTitles: artwork.classificationTitles,
                                   materialID: artwork.materialID,
                                   altMaterialIDS: artwork.altMaterialIDS,
                                   materialIDS: artwork.materialIDS,
                                   materialTitles: artwork.materialTitles,
                                   imageID: artwork.imageID,
                                   suggestAutocompleteAll: artwork.suggestAutocompleteAll,
                                   sourceUpdatedAt: artwork.sourceUpdatedAt,
                                   updatedAt: artwork.updatedAt,
                                   timestamp: artwork.timestamp)
                }

                completion(artworks, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    static func searchArtworks(query: String, completion: @escaping ([Artwork]?, Error?) -> Void) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let searchURL = "https://api.artic.edu/api/v1/artworks/search?q=\(query)"
        
        guard let url = URL(string: searchURL) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ArtworkData.self, from: data)
                
                let artworks = artworkData.data.map { artwork in
                    return Artwork(id: artwork.id,
                                   title: artwork.title,
                                   thumbnail: artwork.thumbnail,
                                   artistDisplay: artwork.artistDisplay,
                                   placeOfOrigin: artwork.placeOfOrigin,
                                   dimensionsDetail: artwork.dimensionsDetail,
                                   mediumDisplay: artwork.mediumDisplay,
                                   creditLine: artwork.creditLine,
                                   catalogueDisplay: artwork.catalogueDisplay,
                                   publicationHistory: artwork.publicationHistory,
                                   exhibitionHistory: artwork.exhibitionHistory,
                                   provenanceText: artwork.provenanceText,
                                   edition: artwork.edition,
                                   publishingVerificationLevel: artwork.publishingVerificationLevel,
                                   internalDepartmentID: artwork.internalDepartmentID,
                                   copyrightNotice: artwork.copyrightNotice,
                                   color: artwork.color,
                                   onLoanDisplay: artwork.onLoanDisplay,
                                   galleryTitle: artwork.galleryTitle,
                                   galleryID: artwork.galleryID,
                                   nomismaID: artwork.nomismaID,
                                   artworkTypeTitle: artwork.artworkTypeTitle,
                                   artworkTypeID: artwork.artworkTypeID,
                                   departmentTitle: artwork.departmentTitle,
                                   departmentID: artwork.departmentID,
                                   artistID: artwork.artistID,
                                   artistTitle: artwork.artistTitle,
                                   termTitles: artwork.termTitles,
                                   classificationID: artwork.classificationID,
                                   classificationTitle: artwork.classificationTitle,
                                   altClassificationIDS: artwork.altClassificationIDS,
                                   classificationIDS: artwork.classificationIDS,
                                   classificationTitles: artwork.classificationTitles,
                                   materialID: artwork.materialID,
                                   altMaterialIDS: artwork.altMaterialIDS,
                                   materialIDS: artwork.materialIDS,
                                   materialTitles: artwork.materialTitles,
                                   imageID: artwork.imageID,
                                   suggestAutocompleteAll: artwork.suggestAutocompleteAll,
                                   sourceUpdatedAt: artwork.sourceUpdatedAt,
                                   updatedAt: artwork.updatedAt,
                                   timestamp: artwork.timestamp)
                }
                
                completion(artworks, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
