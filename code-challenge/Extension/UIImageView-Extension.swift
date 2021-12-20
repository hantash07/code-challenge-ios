//
//  UIImageView-Extension.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import UIKit
import Foundation
import SDWebImage

extension UIImageView {
    public func setImageWithUrl(urlString: String, placeholderImage: UIImage?) {
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholderImage, options: .refreshCached, completed: nil)
    }
}
