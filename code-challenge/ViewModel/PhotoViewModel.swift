//
//  PhotoViewModel.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import Foundation
import SVProgressHUD
import Toast_Swift
import PhotosUI

class PhotoViewModel: NSObject {
    private(set) var photos: [PhotoDataModel]! {
        didSet {
            self.bindPhotoViewModelToController()
        }
    }
    private(set) var downloadUrl: URL! {
        didSet {
            self.bindDownloadUrlViewModelToController()
        }
    }
    public var bindPhotoViewModelToController: (() -> ()) = {}
    public var bindDownloadUrlViewModelToController: (() -> ()) = {}
    
    func requestGetPhotos() {
        SVProgressHUD.show()
        let urlString: String = UrlManager.PhotoAPI.photos()
        NetworkManager.GET(endPoint: urlString) { (response) in
            if response.isSuccess() {
                var photos: [PhotoDataModel] = []
                for dict in response.payload {
                    let photo = PhotoDataModel()
                    photo.deserialize(dictionary: dict)
                    photos.append(photo)
                }
                self.photos = photos
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func requestDownloadPhoto(photoUrl: String) {
        SVProgressHUD.show()
        NetworkManager.DOWNLOAD(endpoint: photoUrl, completion: { url in
            if let url = url {
                self.saveToDevive(url: url)
            }
            SVProgressHUD.dismiss()
        })
    }
    
    private func saveToDevive(url: URL) {
        PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
        }, completionHandler: { succeeded, error in
          guard error == nil, succeeded else {
            return
          }
            self.downloadUrl = url
        })
      }
}
