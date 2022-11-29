//
//  TTImageViewExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation

extension UIImageView {
    // 根据图片名直接生成
    class func name(_ name: String) -> Self {
        let imageView = Self.init(frame: .zero)
        imageView.image = UIImage.name(name)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    // 生成一个空的UIImageView
    class func empty() -> Self {
        let imageView = Self.init(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }

    // 根据名字初始化且是否能点击
    class func name(_ name: String, canClick: Bool) -> Self {
        let imageView = self.name(name)
        imageView.isUserInteractionEnabled = canClick
        return imageView
    }

    class func colorImageView(_ color: UIColor) -> Self {
        let imageView = self.empty()
        return imageView
    }

}

extension UIImageView {
    //  设置kingfisher加载网络图片
    func netImage(_ urlStr: String?, placeholder: String = "") {
        if let urlStr = urlStr {
            if urlStr.count > 0 {
                kf.setImage(with: URL(string: urlStr), placeholder: UIImage.name(placeholder))
            }
        } else {
            self.image = UIImage.name(placeholder)
        }
    }
}
