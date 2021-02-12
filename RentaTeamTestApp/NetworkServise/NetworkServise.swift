//
//  NetworkServise.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

protocol NetworkServiseProtocol {
    func fetchData(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
    
    func fetchImage(from url: String?, completion: @escaping (Result<UIImage?,Error>) -> ())
    
    var imageCache: NSCache<NSString, UIImage> { get set }
}

final class NetworkServise: NetworkServiseProtocol {
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func fetchData(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        guard let url = URL(string: Constants.url + "\(page)") else { return }
        
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
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
        } else {
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error.localizedDescription)
                        completion(.failure(error))
                        return
                    }
                    guard let data = data, let image = UIImage(data: data) else { return }
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(.success(image))
                }
            }
            .resume()
        }
    }
}



