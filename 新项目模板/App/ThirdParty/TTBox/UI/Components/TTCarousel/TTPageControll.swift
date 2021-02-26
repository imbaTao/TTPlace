//
//  TTPageControll.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/2/5.
//

import Foundation

        
class TTPageControll: UIStackView {
    // 当前页
    var currentPage = 0
    
    // 总的最大页数
    var numberOfPages = 0 {
        didSet {
            self.creatItems()
        }
    }
    
    // 全局指示点颜色
    var pageIndicatorTintColor: UIColor?
    
    // 当前指示点颜色
    var currentPageIndicatorTintColor: UIColor?
    
    // 指示点大小
    var itemSize = CGSize.zero
    
    // 存储指示点
    var items = [UIView]()
    

    // 当前下标
    var index = 0
    
    // 根据页码数，初始化指示器
    init(pageCount: Int, itemSize: CGSize, spacing: CGFloat) {
        super.init(frame: .zero)
        // 如何排列的
        self.axis = .horizontal;
        self.distribution = .equalSpacing;
        self.spacing = spacing;
        
        
        self.index = 0;
        self.itemSize = itemSize;
   
      
        self.layer.masksToBounds = true;
        self.isUserInteractionEnabled = false;
        
        self.numberOfPages = pageCount;
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
            if i == 0 {
                item.backgroundColor = currentPageIndicatorTintColor
            }

            item.snp.makeConstraints { (make) in
                make.size.equalTo(self.itemSize)
            }
            item.layer.cornerRadius = itemSize.height / 2.0
            items.append(item)
            addArrangedSubview(item)
        }
    }
    
    // 布局完成时刷新下标
    override func layoutSubviews() {
        super.layoutSubviews()
        refreshIndicator(withCurrentIndex: index)
    }
      
    // 刷新指示器下标
    func refreshIndicator(withCurrentIndex index: Int) {
        for item in items {
            if item.tag - 100 == index {
                item.backgroundColor = currentPageIndicatorTintColor
            } else {
                item.backgroundColor = pageIndicatorTintColor
            }
        }
    }
}
