//
//  DetailPresenter.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 11.02.2021.
//

import UIKit

protocol DetailViewProtocol: class {
    func setupImage(image: UIImage?)
    func setPhotoData(photo: Photo?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol?, networkServise: NetworkServiseProtocol?, photo: Photo?)
    func setupUI()
    
    var photo: Photo? { get set }
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let networkServise: NetworkServiseProtocol?
    var photo: Photo?
    
    required init(view: DetailViewProtocol?, networkServise: NetworkServiseProtocol?, photo: Photo?) {
        
        self.view = view
        self.networkServise = networkServise
        self.photo = photo
    }
    
    private func getPhoto() {
        guard let url = photo?.largeImageURL, let imageUrl = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    let photo = UIImage(data: imageData)
                    self.view?.setupImage(image: photo)
                }
            }
        }
    }
    
    public func setupUI() {
        view?.setPhotoData(photo: photo)
        getPhoto()
    }
}
