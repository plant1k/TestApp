//
//  NetworkServise.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

protocol NetworkServiseProtocol {
    func fetchData(completion: @escaping (Result<[Photo]?, Error>) -> Void)
    
    func fetchImage(from url: String?, completion: @escaping (Result<UIImage?,Error>) -> ())
}

final class NetworkServise: NetworkServiseProtocol {
    
    func fetchData(completion: @escaping (Result<[Photo]?, Error>) -> Void) {
       
        //var photos = [Photo]()
        
        guard let url = URL(string: Constants.url) else { return }
        
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
                    let json = try JSONDecoder().decode(PhotoData.self, from: data)
                    completion(.success(json.hits))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
    
    func fetchImage(from urlString: String?, completion: @escaping (Result<UIImage?,Error>) -> ()) {
        guard let fetchUrl = urlString, let url = URL(string: fetchUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                    guard let data = data else { return }
                    completion(.success(UIImage(data: data)))
            }
        }
        .resume()
    }
}



