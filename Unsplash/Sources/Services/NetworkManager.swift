//
//  NetworkManager.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    // MARK: - Public Properties
    
    static let shared = NetworkManager()
    
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private enum Path {
        static let urlString = "https://api.unsplash.com/photos/random?client_id=spBEyWqFsVhxMlXU5k0ll2g_7C5S5HUJDA_CCOyQIZk&count=30"
    }
    
    // MARK: - Public Methods
    
    func fetchData<T: Codable>(of type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: Path.urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let parseredData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try self.decoder.decode(T.self, from: parseredData)
                completion(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
