//
//  CollectionViewCell.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 10.02.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
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
    private var imageURL: String? {
        didSet {
            photoView?.image = nil
            updateUI()
        }
    }
    
//MARK: - Private Methods
     private func updateUI() {
        guard let url = imageURL, let imageUrl = URL(string: url) else { return }
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.photoView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }

// MARK: - Public Methods
    public func setupCollectionViewCell(by photoData: Photo) {
        imageURL = photoData.largeImageURL
        photoName.text = photoData.user
    }
}
