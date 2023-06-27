//
//  PhotoLibraryCollectionView.swift
//  rxSwiftProject
//
//  Created by ericzero on 5/15/23.
//

import UIKit
import Photos
import RxSwift

class PhotoLibraryCollectionView: UIViewController {
    
    private let selectedPhotosSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotosSubject.asObservable()
    }
    
    lazy var collectionV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionV
    }()
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
        setConstraints()
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(PhotoLibraryCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoLibraryCollectionViewCell")
    }
    
    private func setConstraints(){
        view.addSubview(collectionV)
        collectionV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func populatePhotos(){
        // Asking permission to access to photo library..
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                // Here is access and fetching images..
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reversed()
                DispatchQueue.main.async {
                    self?.collectionV.reloadData()
                }
            }
        }
    }
    
}

extension PhotoLibraryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoLibraryCollectionViewCell", for: indexPath) as! PhotoLibraryCollectionViewCell
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize: CGSize(width: collectionView.frame.width / 3 - 10, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.gridImg.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            guard let info = info else { return }
            
            let isDeradedImage = info["PHImageResultIsDegradedKey"] as! Bool
        
            if !isDeradedImage {
                if let image = image {
                    self?.selectedPhotosSubject.onNext(image)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
           
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 10, height: 100)
    }
}
