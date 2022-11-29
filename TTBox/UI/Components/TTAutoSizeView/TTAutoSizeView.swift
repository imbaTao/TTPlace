//
//  TTAutoSizeView.swift
//  TTBox
//
//  Created by Mr.hong on 2021/1/27.
//

import Foundation

//MARK: - 根据约束自动管理size的view，添加视图时，请使用t_addSubViews
class TTAutoSizeView: TTControll {
    // 里面只装container
    let stackView = TTStackView()
    let containerView = UIView()

    // 内边距
    var padding = UIEdgeInsets.zero {
        didSet {
            if superview != nil {
                stackView.snp.remakeConstraints { (make) in
                    make.edges.equalTo(padding)
                }
            }
        }
    }

    init(_ padding: UIEdgeInsets = .zero) {
        self.padding = padding
        super.init(frame: .zero)
        makeUI()

    }

    override func makeUI() {
        super.makeUI()
        addSubview(stackView)
        stackView.addArrangedSubview(containerView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(padding)
        }

        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // config
    }

    // 添加子类
    func t_addSubViews(_ views: [UIView]) {
        containerView.addSubviews(views)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

#if DEBUG
deinit {
    debugPrint("内存释放监测--TTAutoSizeView")
}
#endif
    
    
}
