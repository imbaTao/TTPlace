//
//  DynamicPublishEditTitleCell.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/24.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class DynamicPublishEditTitleCell: TTTableViewCell {
    
    let inputTextFiled = TTTextFiled.init { (config) in
        config.placeholderText = "填写标题会有更多赞哦~"
        config.textColor = .black
        config.placeholderColor = .gray
    }
    
    override func makeUI() {
        super.makeUI()
        addSubviews([inputTextFiled,segementLine])
    
        
        // 分割线
        segementLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    override func bind(to viewModel: TTTableViewCellViewModel) {
        super.bind(to: viewModel)
        
        guard let viewModel = viewModel as? DynamicPublishEditTitleCellViewModel else {
            return
        }
        
        
        // 绑定内容关系
        viewModel.title.asDriver().drive(self.inputTextFiled.rx.text).disposed(by: cellDisposeBag)
        
        // 双向绑定
        self.inputTextFiled.rx.text.orEmpty.asDriver().drive(viewModel.title).disposed(by: cellDisposeBag)
    }
}
