//
//  TTStackViewExtension.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/1/22.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class TTStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 自动布局设置这个为false https://www.cnblogs.com/zhouhui231/p/12118540.html
        translatesAutoresizingMaskIntoConstraints = false
        makeUI()
        bindViewModel()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
        bindViewModel()
    }

    func makeUI() {
        spacing = 12
        axis = .vertical
        distribution = .fill
    }

    func updateUI() {

    }

    func bindViewModel() {

    }
}

extension TTStackView {
    class func horizontalStack() -> TTStackView {
        let statck = TTStackView()
        statck.axis = .horizontal
        return statck
    }

    class func verticalStack() -> TTStackView {
        let statck = TTStackView()
        statck.axis = .vertical
        return statck
    }
}

class TTHorizontalStackView: TTStackView {
    override func makeUI() {
        super.makeUI()
        axis = .horizontal
    }
}
