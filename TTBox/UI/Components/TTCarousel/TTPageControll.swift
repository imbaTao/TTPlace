//
//  TTPageControll.swift
//  TTBox
//
//  Created by Mr.hong on 2021/2/5.
//

import Foundation

class TTPageControll: UIStackView {

    private let pageRelay = BehaviorRelay<Int>.init(value: 0)
    // 当前页
    var currentPage = 0 {
        didSet {
            pageRelay.accept(currentPage)
        }
    }

    // 总的最大页数
    var numberOfPages = 0 {
        didSet {
            // TODO: Page越界，0 <= currentPage < numberOfPages
            currentPage = max(0, min(currentPage, numberOfPages - 1))
            self.creatItems()
        }
    }

    /// 默认指示点颜色
    var pageIndicatorTintColor: UIColor?

    /// 当前指示点0颜色
    var currentPageIndicatorTintColor: UIColor?

    // 指示点大小
    var itemSize = CGSize.init(width: 5, height: 5)

    // 选中指示点大小
    var selectedItemSize: CGSize?

    // 存储指示点
    var items = [UIView]()

    // 动画间隔
    var refreshIndexAnimateInterval = 0.2

    // 根据页码数，初始化指示器
    init(
        pageCount: Int = 0, currentPage: Int = 0, itemSize: CGSize, selectedItemSize: CGSize? = nil,
        spacing: CGFloat
    ) {
        super.init(frame: .zero)
        // 如何排列的
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = spacing

        self.currentPage = currentPage
        self.itemSize = itemSize
        self.selectedItemSize = selectedItemSize

        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = false

        self.numberOfPages = pageCount
        creatItems()

        pageRelay.distinctUntilChanged().throttle(
            .milliseconds(200), latest: false, scheduler: MainScheduler.instance
        ).subscribe(onNext: { [weak self] (page) in guard let self = self else { return }
            self.refreshIndicator(withCurrentIndex: page)
        }).disposed(by: rx.disposeBag)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 创建items
    func creatItems() {
        for item in items {
            item.removeFromSuperview()
        }

        // 如果没有页码数，那么就不显示
        if numberOfPages <= 1 {
            return
        }

        items = [UIView]()
        for i in 0..<numberOfPages {
            let item = UIImageView()

            item.tag = 100 + i
            item.backgroundColor = pageIndicatorTintColor
            if i == currentPage {
                item.backgroundColor = currentPageIndicatorTintColor
            }

            if i == currentPage, let selectItemSize = self.selectedItemSize {
                item.snp.makeConstraints { (make) in
                    make.size.equalTo(selectItemSize)
                }
            } else {
                item.snp.makeConstraints { (make) in
                    make.size.equalTo(self.itemSize)
                }
            }

            item.circle()
            items.append(item)
            addArrangedSubview(item)
        }
    }

    // 布局完成时刷新下标
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        refreshIndicator(withCurrentIndex: index)
    //    }

    // 刷新指示器下标
    func refreshIndicator(withCurrentIndex index: Int) {
        for item in items {
            if item.tag - 100 == index {
                item.backgroundColor = currentPageIndicatorTintColor

                // 有选中size
                if let selectedItemSize = selectedItemSize {
                    item.snp.updateConstraints { (make) in
                        make.size.equalTo(selectedItemSize)
                    }
                }
            } else {
                item.backgroundColor = pageIndicatorTintColor

                // 有选中尺寸，且自身尺寸不是选中尺寸的，执行动画
                if let _ = selectedItemSize, itemSize != self.size {
                    item.snp.updateConstraints { (make) in
                        make.size.equalTo(self.itemSize)
                    }
                }
            }
        }
    }
}
