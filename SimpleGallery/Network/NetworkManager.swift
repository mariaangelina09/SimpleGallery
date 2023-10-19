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
    case dataCorrupted
    case keyNotFound
    case valueNotFound
    case typeMismatch
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
                let artworkData = try decoder.decode(ArtworkData.self, from: data)
                let artworks = artworkData.data
                print(artworks)

                completion(artworks, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                completion(nil, NetworkError.dataCorrupted)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.keyNotFound)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.valueNotFound)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.typeMismatch)
            } catch {
                print("Error:", error)
                completion(nil, error)
            }
        }.resume()
    }
    
    static func fetchArtworkDetail(id: Int, completion: @escaping (ArtworkDetail?, Error?) -> Void) {
        let urlString = "https://api.artic.edu/api/v1/artworks/\(id)"

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
                let artworkDetailData = try decoder.decode(ArtworkDetailData.self, from: data)
                let artworkDetail = artworkDetailData.data
                print(artworkDetail)

                completion(artworkDetail, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                completion(nil, NetworkError.dataCorrupted)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.keyNotFound)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.valueNotFound)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.typeMismatch)
            } catch {
                print("Error:", error)
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
                let artworkData = try decoder.decode(ArtworkData.self, from: data)
                let artworks = artworkData.data
                completion(artworks, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                completion(nil, NetworkError.dataCorrupted)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.keyNotFound)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.valueNotFound)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, NetworkError.typeMismatch)
            } catch {
                print("Error:", error)
                completion(nil, error)
            }
        }.resume()
    }
}
