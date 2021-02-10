//
//  AssemblyBuilder.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkServise = NetworkServise()
        let presenter = MainPresenter(view: view, networkServise: networkServise)
        view.presenter = presenter
        return view
    }
}
