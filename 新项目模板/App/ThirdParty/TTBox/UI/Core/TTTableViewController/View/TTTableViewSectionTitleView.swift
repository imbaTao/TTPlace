//
//  TTTableViewSectionTitleView.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/4/6.
//

import UIKit

class TTTableViewSectionTitleView: View {
    let title = UILabel.regular(size: 15, textColor: .black, text: "我是组标题", alignment: .left)
    
    override func makeUI() {
        super.makeUI()
        addSubviews([title])
        
        title.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }

}
