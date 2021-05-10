//
//  TTCarousel.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/2/5.
//

import Foundation


class TTCarousel: iCarousel, iCarouselDataSource, iCarouselDelegate {
    /// 当前下标改变block
    var indexDidChange: ((_ index: Int) -> Void)?
    
    /// 选中当前下标block
    var itemDidSelected: ((_ index: Int) -> Void)?
    
    /// 轮播图数据源
    var items: [String]?
    
    var itemSize = CGSize.zero

    
    init(items: [String]?, itemSize: CGSize) {
        super.init(frame: .zero)
        self.layer.masksToBounds = true
        
        self.items = items
        self.itemSize = itemSize
        
        self.dataSource = self
        self.delegate = self
        self.reloadData()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TTCarousel {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.items?.count ?? 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
//        if let _view = view {
//           return _view
//        }else {
//           let _view = UIView()
//            _view?.frame = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
//            let imageView = UIImageView()
//            _view?.addSubview(imageView)
//            imageView.frame = view.frame
//
//            // 图片加载
//            let urlStr = items[index] as? String
//            imageView.sd_setImage(with: URL(string: urlStr ?? ""))
//            return _view
//        }
        return View()
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        //customize carousel display
        switch (option)
        {
        case .wrap:
                //normally you would hard-code this to YES or NO
                return 0;
        case .spacing:
                //add a bit of spacing between the item views
                return value;
        default:
            return value;
            break
        }
    }
    
    // 点击事件
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        itemDidSelected?(index)
    }
    
    // 当先下标变更
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        print(self.currentItemIndex)
    }
    
    
    func carouselDidEndDecelerating(_ carousel: iCarousel) {
        indexDidChange?(carousel.currentItemIndex)
    }
    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        indexDidChange?(carousel.currentItemIndex)
    }
    
    func carouselDidEndDragging(_ carousel: iCarousel, willDecelerate decelerate: Bool) {
        indexDidChange?(carousel.currentItemIndex)
    }
}
