//
//  DetailViewController.swift
//  RentaTeamTestApp
//
//  Created by Андрей Цурка on 11.02.2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var downloadCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            if #available(iOS 13.0, *) {
                indicator.style = .large
            } else {
                indicator.style = .gray
            }
        }
    }
   
    
    var presenter: DetailViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        presenter?.setupUI()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setupImage(image: UIImage?) {
        imagePhoto.image = image
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func setPhotoData(photo: Photo?) {
        navigationItem.title = photo?.user
        likeCountLabel.text = String(photo?.likes ?? 0)
        downloadCountLabel.text = String(photo?.downloads ?? 0)
    }
}
