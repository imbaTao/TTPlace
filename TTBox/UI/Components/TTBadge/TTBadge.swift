//
//  TTBadage.swift
//  TTBox
//
//  Created by Mr.hong on 2021/2/1.
//

import Foundation

// 通用红点标记
class TTBadge: TTAutoSizeView {
    
    // 内容文字提示
    var contentLable = UILabel.regular(size: 10, textColor: .white,alignment: .center);
    
    // 自身红点大小
    var pointSize = CGSize.init(width: 16, height: 16)
    
    init(padding: UIEdgeInsets,pointSize: CGSize = CGSize.init(width: 16, height: 16)) {
        super.init()
        self.pointSize = pointSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        super.makeUI()
        t_addSubViews([contentLable])
        
        // config
        backgroundColor = rgba(254, 64, 61, 1)
        circle()
    }
    
    
    // 仅显示红点
    func justRedPoint(size: CGSize) {
        self.isHidden = false
        contentLable.text = ""
        contentLable.snp.remakeConstraints { (make) in
            make.edges.equalTo(padding)
            make.size.equalTo(size)
        }
    }

    // 变更badage数量
    func changeBadgeNumb(numb: Int) {
        if numb == 0 {
            self.isHidden = true
        }else {
            self.isHidden = false
        }
        
        if numb < 100 {
            contentLable.text = "\(numb)"
        }else {
            // 大于100 显示99+
            contentLable.text = "99+"
        }
        
        contentLable.snp.remakeConstraints { (make) in
            make.edges.equalTo(padding)
            make.size.greaterThanOrEqualTo(pointSize)
        }
    }
}
