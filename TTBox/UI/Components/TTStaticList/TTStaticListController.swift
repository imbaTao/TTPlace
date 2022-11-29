//
//  TTStaticListController.swift
//  EatWhat
//
//  Created by Mr.hong on 2021/4/12.
//

import Foundation

class TTStaticListController: TTViewController {
    let list = TTStackView()
    
    private(set) var rowInterval: CGFloat {
        get {
            return list.spacing
        }
        set {
            list.spacing = newValue
        }
    }
    
    
    let listContainer = UIScrollView()

    override func makeUI() {
        super.makeUI()
        addSubview(listContainer)
        listContainer.addSubview(list)

        listContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        list.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        // config
        list.axis = .vertical
        list.distribution = .fill
        list.alignment = .fill
        list.spacing = 0
        listContainer.showsVerticalScrollIndicator = false
        listContainer.isScrollEnabled = true
    }

    // 添加行数
    func addRows(_ rows: [TTStaticRow]) {
        guard rows.count > 0 else { return }
        list.addArrangedSubviews(rows)
    }

    func addRow(_ rows: TTStaticRow) {
        list.addArrangedSubview(rows)
    }

    // 获取行
    func row(_ index: Int) -> TTStaticRow {
        return list.arrangedSubviews[index] as! TTStaticRow
    }

    var rows: [TTStaticRow] {
        return list.arrangedSubviews as! [TTStaticRow]
    }
}
