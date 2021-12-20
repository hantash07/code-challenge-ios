//
//  ViewController.swift
//  code-challenge
//
//  Created by Hantash on 19/12/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: PhotoViewModel!
    private var photos: [PhotoDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestForUIUpdate()
        
        viewModel.requestGetPhotos()
    }

    private func setupUI() {
        viewModel = PhotoViewModel()
        collectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func requestForUIUpdate() {
        viewModel.bindPhotoViewModelToController = {
            self.updateCollectionView()
        }
        
        viewModel.bindDownloadUrlViewModelToController = {
            if self.viewModel.downloadUrl != nil {
                DispatchQueue.main.async {
                    self.view.makeToast("Photo Downloaded Successfully!")
                }
            }
        }
    }

    private func updateCollectionView() {
        photos = viewModel.photos
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func previewPhoto(photo: PhotoDataModel) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewPhotoVC") as! PreviewPhotoVC
        destVC.photo = photo
        present(destVC, animated: true)
    }
    
    private func downloadPhoto(photo: PhotoDataModel) {
        viewModel.requestDownloadPhoto(photoUrl: photo.url)
    }
    
    private func showBottomMenuSelection(photo: PhotoDataModel) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Preview", style: .default, handler: { _ in
            self.previewPhoto(photo: photo)
        }))
        
        alert.addAction(UIAlertAction(title: "Download", style: .default, handler: { _ in
            self.downloadPhoto(photo: photo)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showBottomMenuSelection(photo: photos[indexPath.row])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configCell(with: photos[indexPath.row])
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: size, height: size)
    }
}
