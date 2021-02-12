//
//  MainPresenter.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import Foundation

// MARK: - Protocol
protocol MainViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkServise: NetworkServiseProtocol, router: RouterProtocol)
    func getData()
    func tapOnPhoto(photo: Photo?)
    var photos: [Photo] { get set }
}

final class MainPresenter: MainViewPresenterProtocol {
    // MARK: - Properties
    weak var view: MainViewProtocol?
    let router: RouterProtocol?
    let networkServise: NetworkServiseProtocol?
    var photos = [Photo]()
    
    //MARK: - Initializer
    required init(view: MainViewProtocol, networkServise: NetworkServiseProtocol, router: RouterProtocol) {
        self.view = view
        self.networkServise = networkServise
        self.router = router
        getData()
    }
    
    // MARK: - Methods
    func tapOnPhoto(photo: Photo?) {
        router?.showDetail(photo: photo)
    }
    
    func getData() {
        networkServise?.fetchData(page: Constants.page) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.photos.append(contentsOf: data)
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
        Constants.page += 1
    }
}
