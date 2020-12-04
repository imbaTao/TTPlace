//
//  TTView.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/4.
//

import UIKit

class TTView: UIView {
    convenience init(height: CGFloat,color: UIColor = .gray) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        backgroundColor = color
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }
}
