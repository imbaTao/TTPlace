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
    
    
    
    
    /// MARK: - 截屏
    /// 截取当前屏幕
       class func takeScreenshot() -> UIImage {
            var imageSize = CGSize.zero
            let screenSize = UIScreen.main.bounds.size
            let orientation = UIApplication.shared.statusBarOrientation
            if orientation.isPortrait {
                imageSize = screenSize
            } else {
                imageSize = CGSize(width: screenSize.height, height: screenSize.width)
            }
            
            UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
            if let context = UIGraphicsGetCurrentContext() {
                for window in UIApplication.shared.windows {
                    context.saveGState()
                    context.translateBy(x: window.center.x, y: window.center.y)
                    context.concatenate(window.transform)
                    context.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x, y: -window.bounds.size.height * window.layer.anchorPoint.y)
                    
                    if orientation == UIInterfaceOrientation.landscapeLeft {
                        context.rotate(by: .pi / 2)
                        context.translateBy(x: 0, y: -imageSize.width)
                    } else if orientation == UIInterfaceOrientation.landscapeRight {
                        context.rotate(by: -.pi / 2)
                        context.translateBy(x: -imageSize.height, y: 0)
                    } else if orientation == UIInterfaceOrientation.portraitUpsideDown {
                        context.rotate(by: .pi)
                        context.translateBy(x: -imageSize.width, y: -imageSize.height)
                    }
                    if window.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
                        window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
                    } else {
                        window.layer.render(in: context)
                    }
                    context.restoreGState()
                }
            }
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let image = image {
                return image
            } else {
                return UIImage()
            }
        }
}



