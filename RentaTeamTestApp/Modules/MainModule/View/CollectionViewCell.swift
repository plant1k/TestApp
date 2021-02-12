//
//  CollectionViewCell.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            if #available(iOS 13.0, *) {
                activityIndicator.style = .large
            } else {
                activityIndicator.style = .gray
            }
        }
    }
    
    //MARK: - Private
    private var networkServise = NetworkServise()
    
    private var imageURL: String? {
        didSet {
            photoView?.image = nil
            updateUI()
        }
    }
    
    //MARK: - Private Methods
    private func updateUI() {
        activityIndicator.startAnimating()
        
        networkServise.fetchImage(from: imageURL, completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.photoView.image = image
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            case .failure(let error):
                print (error.localizedDescription)
            }
        })
    }

// MARK: - Public Methods
    public func setupCollectionViewCell(by photoData: Photo) {
        imageURL = photoData.largeImageURL
        photoName.text = photoData.user
    }
}
