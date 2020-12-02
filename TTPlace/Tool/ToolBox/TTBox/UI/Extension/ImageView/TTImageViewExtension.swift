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
    class func name(_ name: String) -> UIImageView {
        let imageView = UIImageView.init()
        imageView.image = UIImage.name(name)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    class func empty() -> UIImageView {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
     
    class func name(_ name: String,canClick: Bool) -> UIImageView {
        let imageView = self.name(name)
        imageView.isUserInteractionEnabled = canClick
        return imageView
    }
    
    class func colorImageView(_ color: UIColor) -> UIImageView {
        let imageView = self.empty()
        return imageView
    }
}





