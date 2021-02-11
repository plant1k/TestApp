//
//  ViewController.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Propirties
    private var isNavigationBarSetuped: Bool = false
    var presenter: MainViewPresenterProtocol!
    
    // MARK: - UIViewControllerLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isNavigationBarSetuped {
            // first setup for navBar
            setNavigationBar()
            isNavigationBarSetuped = true
        }
    }
    // MARK: - Private Methods
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: Constants.collectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCellIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = Constants.navigationBarTitle
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.setupCollectionViewCell(by: (presenter.photos![indexPath.row]))
        return cell
    }
}

// MARK: -UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat.zero
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = presenter.photos?[indexPath.row]
        let detailViewController = ModelBuilder.createDetainModule(photo: photo)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let indexCount = presenter.photos?.count else { return }
        if indexPath.row == indexCount - 1 {
            print("fetch Data")
        }
    }
}

//MARK: - Extention
extension MainViewController: MainViewProtocol {
    func succes() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}





