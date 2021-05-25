//
//  TTCollectionViewPhotoCell.swift
//  TTBox
//
//  Created by Mr.hong on 2021/3/9.
//

import Foundation


class TTCollectionViewPhotoCell: TTCollectionViewCell {
    override func makeUI() {
        super.makeUI()
        addSubviews([centerImageView])
        centerImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
