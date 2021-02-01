//
//  TTBadage.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/2/1.
//

import Foundation

// 通用红点标记
class TTBadge: UIView {
    
    // 背景框，随lable的内容而扩大
    var backGroundCircle = UIView()
    
    // 内容文字提示
    var contentLable = UILabel.regular(size: 10, textColor: .white);
    
    // 之前的edge
    var sourceEdge = UIEdgeInsets.zero
    init(edge: UIEdgeInsets) {
        super.init(frame: .zero)
        
        sourceEdge = edge
        
        backGroundCircle.backgroundColor = rgba(222, 10, 24, 1)
        addSubview(backGroundCircle)
        
        
        contentLable.textAlignment = .center
        addSubview(contentLable)
        
        // layout
        contentLable.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.greaterThanOrEqualTo(12)
        }
        
        backGroundCircle.snp.makeConstraints { (make) in
            make.top.equalTo(contentLable.snp.top).offset(-edge.top)
            make.left.equalTo(contentLable.snp.left).offset(-edge.left)
            make.bottom.equalTo(contentLable.snp.bottom).offset(edge.bottom)
            make.right.equalTo(contentLable.snp.right).offset(edge.right)
        }
    }
    
    // 仅显示红点
    func justRedPoint(size: CGSize) {
        self.isHidden = false
        contentLable.text = ""
    
        // 重新约束
        backGroundCircle.snp.remakeConstraints { (make) in
            make.size.equalTo(size)
            make.center.equalTo(self)
        }
        
        // 倒圆角
        backGroundCircle.settingCornerRadius(size.height / 2)
    }

    // 变更badage数量
    func changeBadgeNumb(numb: Int) {
        if numb == 0 {
            self.isHidden = true
        }else {
            self.isHidden = false
        }
        
        // 重新约束约束
        backGroundCircle.snp.remakeConstraints { (make) in
           make.top.equalTo(contentLable.snp.top).offset(-sourceEdge.top)
           make.left.equalTo(contentLable.snp.left).offset(-sourceEdge.left)
           make.bottom.equalTo(contentLable.snp.bottom).offset(sourceEdge.bottom)
           make.right.equalTo(contentLable.snp.right).offset(sourceEdge.right)
        }
        

        if numb < 100 {
            contentLable.text = "\(numb)"
        }else {
            // 大于100 显示99+
            contentLable.text = "99+"
        }
        
        self.layoutIfNeeded()

        // 导个圆角
        backGroundCircle.settingCornerRadius((contentLable.height + sourceEdge.top + sourceEdge.bottom) / 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
