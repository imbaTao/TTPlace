//
//  HTCommonUIExtension.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation

extension UIEdgeInsets {
    public init(sameValue: CGFloat)  {
        self.init()
        self.top = sameValue
        self.left = sameValue
        self.right = sameValue
        self.bottom = sameValue
//         return UIEdgeInsets.init(top: value, left: value, bottom: value, right: value)
    }
    

}
