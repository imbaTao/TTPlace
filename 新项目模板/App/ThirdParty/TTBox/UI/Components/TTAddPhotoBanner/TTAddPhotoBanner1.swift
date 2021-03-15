//
//  TTAddPhotoBanner1.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/27.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ZLPhotoBrowser

//// 图片编辑添加器
struct TTAddPhotoBannerModel {
    var image: UIImage?
    var imageUrl = ""
    var isAdd = false
    var index = 0
}

// 可点击的item
class TTAddPhotoBannerCell: TTControll {
    var iconView = UIImageView.empty()
    lazy var extendView: UIView = {
        var extendView = UIView()
        extendView.isUserInteractionEnabled = false
        addSubview(extendView)
        extendView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return extendView
    }()

    init(_ photoModel: TTAddPhotoBannerModel) {
        super.init(frame: .zero)
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }


        // config
        iconView.clipsToBounds = true
        iconView.isUserInteractionEnabled = false


        // 有图片直接显示图片，否则用url
        if photoModel.image != nil {
           iconView.image = photoModel.image
        }else {
            iconView.netImage(photoModel.imageUrl)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TTAddPhotoBannerConfigure {
    // item最大数
    var itemMaxCount = 3
    
    // item尺寸
    var itemSize = CGSize.init(width: 24 , height: 24)
    
    
    // item倒圆角
    var itemRadius: CGFloat = 0
    
    // item间距
    var spacing:CGFloat = 10
    
    // 默认加号图片
    var defaultAddIcon = R.image.ttAddPhotoBanner_defaultAddIcon()
}

// 配置闭包,在init的时候配置，就不用单独再alloc一个对象
typealias TTAddPhotoBannerConfigClosure = (_ configure: TTAddPhotoBannerConfigure)->()


class TTAddPhotoBanner: TTStackView {
    // 里面用一个stackView写,自动扩充宽度
    // 数据源生成item
    // item 点击事件,跳转
    // 数据源是双向的，有可能是网络图片，有可能是已经存在了的图片
    
    // cell回收袋
    var cellEventDisposeBag = DisposeBag()
    var data = [TTAddPhotoBannerModel]()
    var config = TTAddPhotoBannerConfigure()
    
    
    // 刷新item 闭包回调
    var renderItem: ((_ model: TTAddPhotoBannerModel,_ item: TTAddPhotoBannerCell) -> Void)?
    
    // 点击事件
    var selectedItem: ((_ model: TTAddPhotoBannerModel,_ item: TTAddPhotoBannerCell) -> Void)?
    
    init(configAction:TTAddPhotoBannerConfigClosure? = nil) {
        self.config = TTAddPhotoBannerConfigure()
        if configAction != nil {
            configAction!(self.config)
        }
        
        super.init(frame: .zero)
        axis = .horizontal
        alignment = .leading
        spacing = config.spacing
        
       
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    override func makeUI() {
        super.makeUI()
        
        // 设置高度
//        snp.makeConstraints { (make) in
//            make.height.equalTo(config.itemSize.height)
//        }
        

        // 第一次刷新数据源
        refreshPhotoItem()
    }
    
    
    
    // 刷新照片item
   private func refreshPhotoItem() {
        // 先释放上一次的点击事件池
        cellEventDisposeBag = DisposeBag()
        // 清空item
        removeArrangedSubviews()
        removeAllSubviews()
    
        var hasDefaultItem = false
        for model in data {
            if model.isAdd {
                hasDefaultItem = true
            }
        }
        
        // 如果没有添加item,且还没满
        if !hasDefaultItem && data.count < config.itemMaxCount {
            let defaultItem = TTAddPhotoBannerModel.init(image: R.image.ttAddPhotoBanner_defaultAddIcon()!,isAdd: true)
            data.append(defaultItem)
        }
        
        
        // 遍历数据源，生成cell
        for index in 0..<data.count {
            var model = data[index]
            model.index = index
            
          
            var tCell: TTAddPhotoBannerCell!
            
            // 遍历旧的item
            if index < arrangedSubviews.count {
                if let cell = arrangedSubviews[index] as? TTAddPhotoBannerCell {
                    
                    // 有图片直接显示图片，否则用url
                    if model.image != nil {
                        cell.iconView.image = model.image
                    }else {
                        cell.iconView.netImage(model.imageUrl)
                    }
                    
                    tCell = cell
                }
            }else {
                // 生成新的item
                let newCell = TTAddPhotoBannerCell(model)
                addArrangedSubview(newCell)
                tCell = newCell
            }
            
            
        
            // config
            tCell.cornerRadius = config.itemRadius
            tCell.snp.makeConstraints { (make) in
                make.size.equalTo(config.itemSize)
            }
            
            // 每次刷新事件传出去，自定义
            renderItem?(model,tCell)
            
            // 点击事件
            tCell.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self]  in guard let self = self else { return }
                if model.isAdd {
                    // 跳转相册选择
                    self.choosePhotos(parentVC: self.parentViewController!,maxCount: 1) { (models) in
                        self.data = models
                        self.refreshPhotoItem()
                    }
                }else {
                    self.selectedItem?(model,tCell)
                }
 
            }).disposed(by: cellEventDisposeBag)
        }
    }
    
    
    
    
    
    // 选择背景墙
     func choosePhotos(parentVC: UIViewController,maxCount: NSInteger,selectImages: @escaping ([TTAddPhotoBannerModel]) -> ()) {
        let config = ZLPhotoConfiguration.default()
        config.maxSelectCount = 1
        config.canSelectAsset = { (asset) -> Bool in
            return true
        }
        
        config.allowSelectGif = false
        config.allowSelectVideo = false
        config.allowMixSelect = false
        config.allowEditImage = false
        
        let ac = ZLPhotoPreviewSheet()
        ac.selectImageBlock = {(images, assets, isOriginal) in
            var models = [TTAddPhotoBannerModel]()
            for index in 0..<images.count {
                let model =  TTAddPhotoBannerModel.init(image: images[index])
                models.append(model)
            }
            
            selectImages(models)
            
//            debugPrint("\(images)   \(assets)   \(isOriginal)")
        }
        ac.cancelBlock = {
//            debugPrint("cancel select")
        }
        ac.selectImageRequestErrorBlock = { (errorAssets, errorIndexs) in
//            debugPrint("fetch error assets: \(errorAssets), error indexs: \(errorIndexs)")
        }
        
//        if preview {
//            ac.showPreview(animate: true, sender: parentVC)
//        } else {
            ac.showPhotoLibrary(sender: parentVC)
//        }
    }
    
    
    
    
    
    func reload(_ images: [UIImage]) {
        data.removeAll()
        for index in 0..<images.count {
            let image = images[index]
            let item = TTAddPhotoBannerModel.init(image: image, index: index)
            data.append(item)
        }
        
        refreshPhotoItem()
    }
    
    func reload(_ urls: [String]) {
        data.removeAll()
        for index in 0..<urls.count {
            
            let url = urls[index]
            if url.count > 0 {
                let item = TTAddPhotoBannerModel.init(image: nil, imageUrl: urls[index], isAdd: false, index: index)
                data.append(item)
            }
        }
        
        refreshPhotoItem()
    }
    
    
    // 获取image
    func fetchImages() -> [UIImage] {
        var imgs = [UIImage]()
        for model in data {
            if let img = model.image {
                imgs.append(img)
            }
        }
        return imgs
    }
    
}


