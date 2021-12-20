//
//  PreviewPhotoVC.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import UIKit

class PreviewPhotoVC: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: PhotoDataModel?
    
    override func viewDidLoad() {
        if let photo = self.photo {
            photoImageView.setImageWithUrl(urlString: photo.url, placeholderImage: nil)
        }
    }
    
    @IBAction func closedButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
