//
//  TTWeChatLoginManager.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/2/26.
//

import UIKit
import Kingfisher

class TTWeChatTool: NSObject {
//    class func shareWithType(_ type: Int) {
//        let shareInfo = CacheManager.shared.onlineParameter.mobile_wechat_share
//        let webpageObject = WXWebpageObject()
//        webpageObject.webpageUrl = shareInfo?.redirect_url ?? ""
//
//        let message = WXMediaMessage()
//        message.title = shareInfo?.title ?? ""
//        message.description = shareInfo?.content ?? ""
//        
//        // 图片
//        let imageUrl = shareInfo?.image_url
//        
//        // 下载礼物图
//        ImageDownloader.default.downloadImage(with:imageUrl, retrieveImageTask: nil, options: nil, progressBlock: nil) { (image, error, url, _) in
//            
//                if error == nil && image != nil {
//                    message.thumbnail = image!
//                    // 插入到聊天框中
//                    self.insertNewMessageItem(message)
//                }
//        }
//        
//        
//        
//        message.setThumbImage(R.image.test1()!)
//        message.mediaObject = webpageObject
//
//        let req = SendMessageToWXReq()
//        req.bText = false
//        req.message = message
//        req.scene = Int32(WXSceneSession.rawValue)
//        WXApi.send(req)
//    }
}
