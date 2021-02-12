//
//  AssemblyBuilder.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

protocol Builder {
    static func createMainModule() -> MainViewController
    static func createDetainModule(photo: Photo?) -> DetailViewController
}

final class ModelBuilder: Builder {
    static func createMainModule() -> MainViewController {
        let view = MainViewController()
        let networkServise = NetworkServise()
        let presenter = MainPresenter(view: view, networkServise: networkServise)
        view.presenter = presenter
        return view
    }
    
    static func createDetainModule(photo: Photo?) -> DetailViewController {
        let view = DetailViewController()
        let networkServise = NetworkServise()
        let presenter = DetailPresenter(view: view, networkServise: networkServise, photo: photo)
        view.presenter = presenter
        return view
    }
}
