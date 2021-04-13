//
//  TTStaticListController.swift
//  EatWhat
//
//  Created by Mr.hong on 2021/4/12.
//

import Foundation

class TTStaticListController: ViewController {
    let list = TTStackView()
    private let listContainer =  UIScrollView()
    
    
    override func makeUI() {
        super.makeUI()
        addSubview(listContainer)
        listContainer.addSubview(list)
        
        listContainer.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: SCREEN_H))
        }
        
        list.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        // config
        list.axis = .vertical
        list.distribution = .fill
        list.alignment = .center
        list.spacing = 0
        listContainer.showsVerticalScrollIndicator = false
    }
    
    
    // 添加行数
    func addRows(_ rows: [TTStaticRow]) {
        list.addArrangedSubviews(rows)
    }
    
    // 获取行
    func row(_ index: Int) -> TTStaticRow {
        return list.arrangedSubviews[index] as! TTStaticRow
    }
    
    var rows: [TTStaticRow] {
        return list.arrangedSubviews as! [TTStaticRow]
    }
}
