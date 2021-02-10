//
//  NetworkServise.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import Foundation

protocol NetworkServiseProtocol {
    func fetchData(completion: @escaping (Result<PhotoData?, Error>) -> Void)
}

final class NetworkServise: NetworkServiseProtocol {
    
    func fetchData(completion: @escaping (Result<PhotoData?, Error>) -> Void) {
        let urlString = Constants.url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                do {
                    guard let data = data else { return }
                    print(data)
                    let unsplashData = try JSONDecoder().decode(PhotoData.self, from: data)
                    completion(.success(unsplashData))
                    print(unsplashData)
                } catch {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
}

