//
//  PhotoCollectionViewCell.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(with photo: PhotoDataModel) {
        photoImageView.setImageWithUrl(urlString: photo.url, placeholderImage: nil)
    }
}
