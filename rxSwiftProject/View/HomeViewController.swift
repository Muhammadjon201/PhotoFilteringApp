//
//  HomeViewController.swift
//  rxSwiftProject
//
//  Created by ericzero on 4/23/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "placeholderImage")
        return img
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Apply Filter", for: .normal)
        btn.backgroundColor = .systemMint
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Camera Filter"
        
        applyNavigationItems()
        setConstraints()
    }
    
    private func setConstraints(){
        
        view.addSubview(img)
        view.addSubview(btn)
        
        img.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    private func applyNavigationItems(){
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusTapped))
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc func filterTapped(){
        guard let sourceImage = self.img.image else {
            return
        }
        FilterService().applyFilter(to: sourceImage) { filteredImage in
            DispatchQueue.main.async {
                self.img.image = filteredImage
            }
        }
    }
    
    @objc func plusTapped() {
        let vc = PhotoLibraryCollectionView()
        
        // Subscribe to the selectedPhoto observable directly
        vc.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
        
        self.present(vc, animated: true)
    }
    
    private func updateUI(with image: UIImage) {
        self.img.image = image
        self.btn.isHidden = false
    }

}
