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


struct TTPhotoManagerError: Error {
    var type = 0
    
    /**
     -1 没有权限
     -2 获取asset图片源出错
     -3 没有获取到单张图片
     */
    
}

class TTPhotoManager: NSObject {
    // 选择头像
    class func chooseAvatar(parentVC: UIViewController) -> Single<UIImage> {
        return Single<UIImage>.create {(single) -> Disposable in
            
            // 获取相册权限
            TTAuthorizer.fetchLibrayPermissionWithBlock { (result) in
                if result {
                    let config = ZLPhotoConfiguration.default()
                    config.maxSelectCount = 1
                    config.editImageClipRatios = [.wh1x1]
                    config.showClipDirectlyIfOnlyHasClipTool = true
                    config.editAfterSelectThumbnailImage = true
                    config.allowSelectGif = false
                    config.allowSelectVideo = false
                    config.allowMixSelect = false
                    config.editImageTools = [.clip]

                
                    let ac = ZLPhotoPreviewSheet()
                    ac.selectImageBlock = {(images, assets, isOriginal) in
                        if let avatarImage = images.first {
                            single(.success(avatarImage))
                        }else {
                            single(.error(TTPhotoManagerError.init(type: -3)))
                        }
                    
                //            self?.selectedImages = images
                //            self?.selectedAssets = assets
                //            self?.isOriginal = isOriginal
                //            self?.collectionView.reloadData()
//                        debugPrint("\(images)   \(assets)   \(isOriginal)")
                    }
                    
                    ac.cancelBlock = {
                        single(.error(TTPhotoManagerError.init(type: 0)))
//                        debugPrint("cancel select")
                    }
                    ac.selectImageRequestErrorBlock = { (errorAssets, errorIndexs) in
                        single(.error(TTPhotoManagerError.init(type: -2)))
//                        debugPrint("fetch error assets: \(errorAssets), error indexs: \(errorIndexs)")
                    }
                    
            //        if preview {
            //            ac.showPreview(animate: true, sender: parentVC)
            //        } else {
                        ac.showPhotoLibrary(sender: parentVC)
            //        }
                }else {
                    // 没有相册权限
                    single(.error(TTPhotoManagerError.init(type: -1)))
                }
            }
            return Disposables.create {}
        }
    }
    
    
    
    
    // MARK: - 截屏
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
    
    
    
    
    // MARK: - 根据Urlstring预览图片
    class func previewImage(datas: [String],index: Int,sender: UIViewController?) {
        var urls = [URL]()
        for urlStr in datas {
            if let url = URL.init(string: urlStr) {
                urls.append(url)
            }
        }
        self.previewImage(datas: urls, index: index, sender: sender)
    }
    

    
    
    // MARK: - 根据Url预览图片
   class func previewImage(datas: [URL],index: Int,sender: UIViewController?) {
        let vc = ZLImagePreviewController(datas: datas, index: index, showSelectBtn: false) { (url) -> ZLURLType in
                return .image
        } urlImageLoader: { (url, imageView, progress, loadFinish) in
            imageView.kf.setImage(with: url) { (receivedSize, totalSize) in
                let percentage = (CGFloat(receivedSize) / CGFloat(totalSize))
//                debugPrint("\(percentage)")
                progress(percentage)
            } completionHandler: { (_) in
                loadFinish()
            }
        }
        
        vc.doneBlock = { (datas) in
            debugPrint(datas)
        }
        
        vc.modalPresentationStyle = .fullScreen
        sender?.showDetailViewController(vc, sender: nil)
    }
    
    
}

