//
//  ViewController.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlete
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Propirties
    var presenter: MainViewPresenterProtocol!
    
    // MARK: - UIViewControllerLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
    }
    
    // MARK: - Private Methods
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photoData?.hits.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .white
        //        let photos = presenter.photoData?.hits[indexPath.row]
        //        cell?.photoName.text = photos?.user
        //        return UICollectionViewCell()
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
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



