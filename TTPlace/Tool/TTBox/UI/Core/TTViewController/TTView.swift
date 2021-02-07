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
    
    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
        }
    }

    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        bindViewModel()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
        self.layer.masksToBounds = true
     
    }
    
    func bindViewModel() {
        
    }

    func updateUI() {
        setNeedsDisplay()
    }

    func getCenter() -> CGPoint {
        return convert(center, from: superview)
    }
}

class View: TTView {
    
}
