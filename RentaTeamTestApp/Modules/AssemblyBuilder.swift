//
//  AssemblyBuilder.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

    //MARK: - Protocols
protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> MainViewController
    func createDetainModule(router: RouterProtocol, photo: Photo?) -> DetailViewController
}

final class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    //MARK: - Methods
    func createMainModule(router: RouterProtocol) -> MainViewController {
        let view = MainViewController()
        let networkServise = NetworkServise()
        let presenter = MainPresenter(view: view, networkServise: networkServise, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetainModule(router: RouterProtocol, photo: Photo?) -> DetailViewController {
        let view = DetailViewController()
        let networkServise = NetworkServise()
        let presenter = DetailPresenter(view: view, networkServise: networkServise, router: router, photo: photo)
        view.presenter = presenter
        return view
    }
}
