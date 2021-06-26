//
//  TTNormalCarousel.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/11.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class TTCarouselConfig: NSObject {
    // 每页内容大小
    var pageContentSize = CGSize.init(width: SCREEN_W, height: 100)
    var pageContentCornerRadius: CGFloat = 0.0
    
    // 轮播图本身设置
    var isPagingEnabled = true
   
    // 自动滚动间隔
    var autoScrollDuration: TimeInterval = 0.0
    var autoScroll: Bool {
        return autoScrollDuration > 0.0
    }
    
    // 滚动一页所需要的时间
    var scrollOnePageTime: TimeInterval = 0.5

    
    
    // pagecontroll设置
    var pageIndicatorTintColor: UIColor = rgba(255, 255, 255, 0.3)
    var currentPageIndicatorTintColor: UIColor = rgba(255, 255, 255, 1)
    var pageControllSize = CGSize.init(width: 4, height: 4)
    var pageControllSpacing: CGFloat = 5
    var pagecontrollBottomOffset: CGFloat = 3
}



// 常规分页轮播banner
class TTNormalCarousel: TTCarousel {
    
    // 添加pageContontroll
    lazy var pageControll: TTPageControll = {
        var pageControll = TTPageControll.init(pageCount: items?.count ?? 0, itemSize: config.pageControllSize, spacing: config.pageControllSpacing)
        pageControll.pageIndicatorTintColor = config.pageIndicatorTintColor
        pageControll.currentPageIndicatorTintColor = config.currentPageIndicatorTintColor
        addSubview(pageControll)
        pageControll.snp.makeConstraints { (make) in
            make.bottom.equalTo(-config.pagecontrollBottomOffset)
            make.height.equalTo(config.pageControllSize.height)
//            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        
    
        if config.pagecontrollBottomOffset < 0 {
            self.clipsToBounds = false
        }
        
        // 下标变更
        self.indexDidChange = { (index) in
            pageControll.refreshIndicator(withCurrentIndex: index)
        }
        
        return pageControll
    }()
    
    // 滚动倒计时
   private var scrollCountdown: TimeInterval = 0.0
    
    
    // 默认设置对象
    private(set) var config = TTCarouselConfig()
    
    // 初始化设置
    init(config: ((TTCarouselConfig) -> ())? = nil) {
        config?(self.config)
        super.init(items: nil, itemSize: .zero)
    }
    
    
    override func makeUI() {
        super.makeUI()
        // 默认允许分页
        isPagingEnabled =  config.isPagingEnabled
        
        // 是否默认滚动
        if config.autoScroll {
            // 每秒倒计时
            TTTimer.shared.oneSecondsTimer.subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                if self.items?.count ?? 0 < 2 {
                    return
                }
                
                // 每秒增加计数
                self.scrollCountdown += 1.0
                
                // 滚动中就把倒计时时间置为0
                if self.isScrolling {
                    self.scrollCountdown = 0
                }
                
                // 三秒一滚动
                if self.scrollCountdown == self.config.autoScrollDuration {
                    self.scroll(byNumberOfItems: 1, duration: self.config.scrollOnePageTime)
                    self.scrollCountdown = 0
                }
            }).disposed(by: self.rx.disposeBag)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        dataChangeSigle.subscribe(onNext: {[weak self] (count) in guard let self = self else { return }
            if count > 1 {
                self.pageControll.numberOfPages = count
                self.pageControll.isHidden = false
            }else {
                self.pageControll.isHidden = true
            }
        }).disposed(by: rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TTNormalCarousel {
    /// MARK: - 滚动代理
    override func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let urlStr = items?[index]
        if let view = view {
            for subView in view.subviews {
                if let imageView = subView as? UIImageView {
                    imageView.netImage(urlStr)
                }
            }
            return view
        }else {
            // 一个容器，包含一个图片视图
            let baseView = View()
            baseView.backgroundColor = .clear
            baseView.frame = CGRect.init(x: 0, y: 0, width: config.pageContentSize.width, height: config.pageContentSize.height)
            addSubview(baseView)
            
            
            let imageView = UIImageView()
            imageView.cornerRadius = config.pageContentCornerRadius
            imageView.contentMode = .scaleAspectFill
            imageView.netImage(urlStr)
            baseView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.size.equalTo(config.pageContentSize)
            }
            return baseView
        }
    }
    
    // 滚动时将数值置为0
    func carouselDidScroll(_ carousel: iCarousel) {
        scrollCountdown = 0
    }
    
    func carouselWillBeginDragging(_ carousel: iCarousel) {
        scrollCountdown = 0
    }
    
    func carouselWillBeginScrollingAnimation(_ carousel: iCarousel) {
        scrollCountdown = 0
    }
}


