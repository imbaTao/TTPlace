//
//  TTPhotoManager.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/1/22.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import UIKit
import ZLPhotoBrowser

class TTPhotoManager: NSObject {
    // 选择头像
    class func chooseAvatar(parentVC: UIViewController,selectImage: @escaping (UIImage) -> ()) {
        let config = ZLPhotoConfiguration.default()
        config.maxSelectCount = 1
        
        //        config.editImageClipRatios = [.custom, .wh1x1, .wh3x4, .wh16x9, ZLImageClipRatio(title: "2 : 1", whRatio: 2 / 1)]
        config.editImageClipRatios = [.wh1x1]
        config.canSelectAsset = { (asset) -> Bool in
            return false
        }
        config.showClipDirectlyIfOnlyHasClipTool = true
        config.editAfterSelectThumbnailImage = true
        config.allowSelectGif = false
        config.allowSelectVideo = false
        config.allowMixSelect = false
        config.editImageTools = [.clip]

    
        let ac = ZLPhotoPreviewSheet()
        ac.selectImageBlock = {(images, assets, isOriginal) in
//            self?.selectedImages = images
//            self?.selectedAssets = assets
//            self?.isOriginal = isOriginal
//            self?.collectionView.reloadData()
            
            selectImage(images.first ?? UIImage())
            
            debugPrint("\(images)   \(assets)   \(isOriginal)")
        }
        ac.cancelBlock = {
            debugPrint("cancel select")
        }
        ac.selectImageRequestErrorBlock = { (errorAssets, errorIndexs) in
            debugPrint("fetch error assets: \(errorAssets), error indexs: \(errorIndexs)")
        }
        
//        if preview {
//            ac.showPreview(animate: true, sender: parentVC)
//        } else {
            ac.showPhotoLibrary(sender: parentVC)
//        }
    }
    
    
    
    // 选择背景墙
    class func chooseProfilePhotos(parentVC: UIViewController,selectImages: @escaping ([UIImage]) -> ()) {
        let config = ZLPhotoConfiguration.default()
        config.maxSelectCount = 6
        
        //        config.editImageClipRatios = [.custom, .wh1x1, .wh3x4, .wh16x9, ZLImageClipRatio(title: "2 : 1", whRatio: 2 / 1)]
//        config.editImageClipRatios = [.wh1x1]
        config.canSelectAsset = { (asset) -> Bool in
            return true
        }
//        config.showClipDirectlyIfOnlyHasClipTool = true
//        config.editAfterSelectThumbnailImage = true
        config.allowSelectGif = false
        config.allowSelectVideo = false
        config.allowMixSelect = false
        config.allowEditImage = false
        

        
        let ac = ZLPhotoPreviewSheet()
        ac.selectImageBlock = {(images, assets, isOriginal) in
//            self?.selectedImages = images
//            self?.selectedAssets = assets
//            self?.isOriginal = isOriginal
//            self?.collectionView.reloadData()
            
            selectImages(images)
            
            debugPrint("\(images)   \(assets)   \(isOriginal)")
        }
        ac.cancelBlock = {
            debugPrint("cancel select")
        }
        ac.selectImageRequestErrorBlock = { (errorAssets, errorIndexs) in
            debugPrint("fetch error assets: \(errorAssets), error indexs: \(errorIndexs)")
        }
        
//        if preview {
//            ac.showPreview(animate: true, sender: parentVC)
//        } else {
            ac.showPhotoLibrary(sender: parentVC)
//        }
    }
}


