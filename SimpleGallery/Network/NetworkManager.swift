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
                let response = try decoder.decode(ArtworkData.self, from: data)
                
                let artworks = response.artworks.map { artworkData in
                    return Artwork(title: artworkData.title, imageIdentifier: artworkData.imageIdentifier)
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
                
                let artworks = response.artworks.map { artworkData in
                    return Artwork(title: artworkData.title, imageIdentifier: artworkData.imageIdentifier)
                }
                
                completion(artworks, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
