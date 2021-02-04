//
//  TTAddPhotoBanner.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/3.
//

import UIKit
import Rswift

//
//  PhotoManager.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/2.
//

import UIKit
import ZLPhotoBrowser

class TTAddPhotoBanner: UIView {
    var datas = [TTAddPhotoBannerModel]()
    
    var itemsArray = [TTAddPhotoBannerItem]()
    
    // 默认添加图片的加号
    lazy var defaultAddItem: TTAddPhotoBannerItem = {
        var defaultAddItem = TTAddPhotoBannerItem.init(image: R.image.ttAddPhotoBanner_defaultAddIcon()!)
        defaultAddItem.iconView.contentMode = .scaleAspectFill
        // addAction event
        defaultAddItem.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            
            // choose photo
            TTPhotoManager.chooseProfilePhotos(parentVC: topNav()!,maxCount: self!.maxCount) {[weak self] (images) in
                self?.datas.removeAll()
                self?.addImage(images: images)
            }
        }).disposed(by: rx.disposeBag)
        return defaultAddItem
    }()
    
    // defalut max count
    private var maxCount: Int = 6
    private var itemSize: CGSize = .zero
    init(models: [TTAddPhotoBannerModel]? = nil,maxCount: Int,itemSize: CGSize) {
        super.init(frame: .zero)
        self.itemSize = itemSize
        self.maxCount = maxCount
        addImage(models: models)
    }
    
    // 根据image创建
    func addImage(images: [UIImage]?) {
        if let images = images {
            var count = 0
            for image in images {
                if count == maxCount {
                    break
                }
                
                datas.append(TTAddPhotoBannerModel.init(image: image))
                count += 1
            }
        }
        
        relayout()
    }
    
    // 根据model创建
    func addImage(models: [TTAddPhotoBannerModel]? = nil) {
        datas.removeAll()
        itemsArray.removeAll()
        removeSubviews()
        
        //        if images.count > 0 {
        //
        //
        //            // creat Model
        //            var count = 0
        //            for image in images {
        //                if count == maxCount {
        //                    break
        //                }
        //
        //                datas.append(TTAddPhotoBannerModel.init(image: image))
        //                count += 1
        //            }
        //        }else {
        //
        //        }
        
        //  解包
        if let models = models {
            datas = models
        }
        
        // 遍历出模型,生成item
        for bannerModel in datas {
            let item = TTAddPhotoBannerItem.init(image: bannerModel.image)
            // addAction event
            item.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
                
                // 跳转照片上传
            }).disposed(by: rx.disposeBag)
            itemsArray.append(item)
        }
        
        relayout()
    }
    
    
    // 重新布局
    func relayout() {
        // 如果是唯一的，就直接赋值图片
        if datas.count == 1  {
            defaultAddItem.iconView.image = datas.first?.image
        }else {
            addDefaultItem()
            addSubviews(itemsArray)
            
//            var i = 0
//            itemsArray.forEach { (item) in
//                item.snp.makeConstraints { (make) in
//                    make.size.equalTo(item)
//                    make.left.equalTo(12.0 * CGFloat(i) + itemSize.width)
//                }
//                i += 1
//            }
            
            itemsArray.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 10, leadSpacing: 0, tailSpacing: 0)
            itemsArray.snp.makeConstraints { (make) in
                make.size.equalTo(itemSize)
            }
        }
        
      
    }
    
    
    // defalut plus sign Item
    private func addDefaultItem() {
        
        // 如果不包含默认项
        if itemsArray.contains(defaultAddItem) == false && datas.count < maxCount {
            addSubview(defaultAddItem)
            itemsArray.append(defaultAddItem)
        }
    }
    
    // 获取image
    func fetchImages() -> [UIImage] {
        return self.datas.map { (model) -> UIImage in
            return model.image
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 图片编辑添加器
struct TTAddPhotoBannerModel {
    var image = UIImage()
    var imageUrl = ""
    
    // 可能相册相关
    // var asset =
}

// 可点击的item
class TTAddPhotoBannerItem: UIControl {
    var iconView = UIImageView.empty()
    
    init(image: UIImage) {
        super.init(frame: .zero)
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        iconView.clipsToBounds = true
        iconView.image = image
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
