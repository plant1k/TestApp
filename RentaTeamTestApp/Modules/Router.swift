//
//  Router.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 12.02.2021.
//

import UIKit

protocol RouterName {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterName {
    func initialViewController()
    func showDetail(photo: Photo?)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol   ) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(photo: Photo?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetainModule(router: self, photo: photo) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
