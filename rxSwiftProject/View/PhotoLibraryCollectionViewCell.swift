//
//  PhotoLibraryCollectionViewCell.swift
//  rxSwiftProject
//
//  Created by ericzero on 5/15/23.
//

import UIKit
import SnapKit

class PhotoLibraryCollectionViewCell: UICollectionViewCell {
    
    lazy var gridImg: UIImageView = {
        let gridImg = UIImageView()
        
        return gridImg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(gridImg)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        gridImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
