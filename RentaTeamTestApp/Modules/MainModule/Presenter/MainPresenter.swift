//
//  MainPresenter.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkServise: NetworkServiseProtocol)
    func getData()
    var photos: [Photo] { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkServise: NetworkServiseProtocol?
    var photos = [Photo]()
    
    required init(view: MainViewProtocol, networkServise: NetworkServiseProtocol) {
        self.view = view
        self.networkServise = networkServise
        getData()
    }
    
    func getData() {
        networkServise?.fetchData { [weak self] (result) in
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
        Constants.updataPage()
    }
}
