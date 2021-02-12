//
//  DetailPresenter.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 11.02.2021.
//

import UIKit

//MARK: - Protocols
protocol DetailViewProtocol: class {
    func setupImage(image: UIImage?)
    func setPhotoData(photo: Photo?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol?, networkServise: NetworkServiseProtocol?, photo: Photo?)
    func setupUI()
    
    var photo: Photo? { get set }
}

final class DetailPresenter: DetailViewPresenterProtocol {
//MARK: - Propirties
    weak var view: DetailViewProtocol?
    let networkServise: NetworkServiseProtocol?
    var photo: Photo?
    
    required init(view: DetailViewProtocol?, networkServise: NetworkServiseProtocol?, photo: Photo?) {
        
        self.view = view
        self.networkServise = networkServise
        self.photo = photo
    }
    
//MARK: - Private Func
    private func getPhoto() {
        guard let url = photo?.largeImageURL else { return }
        
        networkServise?.fetchImage(from: url, completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.view?.setupImage(image: image)
            case .failure(let error):
                print (error.localizedDescription)
            }
        })
    }
 
//MARK: - Public Func
    public func setupUI() {
        view?.setPhotoData(photo: photo)
        getPhoto()
    }
}
