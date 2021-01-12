//
//  TTImageViewExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation

// 对UIImageView扩展
extension UIImageView{
    
    // 根据图片名来直接
    //    convenience init(name: String) {
    //        self.init()
    //        self.image = UIImage.init(named: name)
    //    }
    //
    class func name(_ name: String) -> Self {
        let imageView = Self.init(frame: .zero)
        imageView.image = UIImage.name(name)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    class func empty() -> Self {
        let imageView = Self.init(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }
     
    class func name(_ name: String,canClick: Bool) -> Self {
        let imageView = self.name(name)
        imageView.isUserInteractionEnabled = canClick
        return imageView
    }
    
    class func colorImageView(_ color: UIColor) -> Self {
        let imageView = self.empty()
        return imageView
    }
    
    class func netImage(_ url: String) -> Self {
        let imageView = self.empty()
        imageView.netImage(url)
        return imageView
    }
    
}


extension UIImageView {
    //  设置网络图片
    func netImage(_ value: String?,placeholder: String = "") {
        if value != nil {
            
            if value!.count > 0 {
                kf.setImage(with: URL(string: value),placeholder: UIImage.name(placeholder))
            }
           
        }
    }
}



