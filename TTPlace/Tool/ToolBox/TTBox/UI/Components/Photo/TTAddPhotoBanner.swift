//
//  TTAddPhotoBanner.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/3.
//

import UIKit

class TTAddPhotoBanner: UIView {
    var datas = [TTAddPhotoBannerModel]()
    
    var itemsArray = [TTAddPhotoBannerItem]()
    
    // 默认添加图片的加号
    lazy var defaultAddItem: TTAddPhotoBannerItem = {
        var defaultAddItem = TTAddPhotoBannerItem.init(image: R.image.ttAddPhotoBanner_defaultAddIcon()!)
        
        // addAction event
        defaultAddItem.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            
            // choose photo
            PhotoManager.chooseProfilePhotos(parentVC: topNav()!) {[weak self] (images) in

                self?.addImage(images: images)
            }
        }).disposed(by: rx.disposeBag)
        return defaultAddItem
    }()
    
    // defalut max count
    var maxCount: Int = 6
    
    init(images: [UIImage],models: [TTAddPhotoBannerModel] = [TTAddPhotoBannerModel](),maxCount: Int) {
        super.init(frame: .zero)
        
        self.maxCount = maxCount
        addImage(images: images, models: models)
    }
    
    // 添加图片
    func addImage(images: [UIImage],models: [TTAddPhotoBannerModel] = [TTAddPhotoBannerModel]()) {
        datas.removeAll()
        itemsArray.removeAll()
        removeSubviews()
        
        if images.count > 0 && models.count > 0 {
            assert(false, "只能有一种初始化方式")
        }
        
        
        if images.count > 0 {
            
            
            // creat Model
            var count = 0
            for image in images {
                if count == maxCount {
                    break
                }
                
                datas.append(TTAddPhotoBannerModel.init(image: image))
                count += 1
            }
        }else {
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

        addDefaultItem()
        addSubviews(itemsArray)
        itemsArray.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 10, leadSpacing: 0, tailSpacing: 0)
        itemsArray.snp.makeConstraints { (make) in
            make.height.equalTo(ver(24))
            make.width.equalTo(hor(24))
        }
    }
    
    
    
    // defalut plus sign Item
    private func addDefaultItem() {
        if itemsArray.contains(defaultAddItem) == false && datas.count < maxCount {
            addSubview(defaultAddItem)
            itemsArray.append(defaultAddItem)
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
//    var asset =
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
