//
//  TTCustomTextContainerView.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/7.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

// 自定义textView，包裹textView
class TTCustomTextContainerView: TTView {
    let textView = TTTextView.init()

    // textView，文本右侧字数提示
    lazy var textCountTips: UILabel = {
        var textCountTips = UILabel.regular(
            size: 12, textColor: .black, text: "0/10", alignment: .right)
        addSubview(textCountTips)
        textCountTips.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
        return textCountTips
    }()

    // 是否有数量提示
    init(hasCountTips: Bool = false) {
        super.init(frame: .zero)
        if hasCountTips {
            self.textView.rx.didChange
                .asObservable()
                .subscribe(onNext: { [weak self] _ in guard let self = self else { return }
                    // 显示最大数提示
                    self.textCountTips.text =
                        "\(self.textView.text.count)/\(self.textView.configure.maxTextCount)"
                })
                .disposed(by: rx.disposeBag)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeUI() {
        super.makeUI()
        addSubview(textView)

        textView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
