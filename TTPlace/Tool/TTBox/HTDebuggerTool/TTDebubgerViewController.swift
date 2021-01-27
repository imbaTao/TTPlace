//
//  TTDebubgerViewController.swift
//  TTSwiftLearn
//
//  Created by Mr.hong on 2019/8/22.
//  Copyright © 2019 Mr.hong. All rights reserved.
//

import UIKit

class TTDebubgerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.title = "测试用控制器"

    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //创建分享消息对象
//        let messageObject = UMSocialMessageObject()
//
////        share(withTitle: "分享标题", descr: "分享内容描述", thumImage: UIImage(named: "icon"))
//
//        //创建网页内容对象
//        let shareObject = UMShareWebpageObject.shareObject(withTitle: "分享标题", descr: "分享内容描述", thumImage: R.image.test1())
//
//        //设置网页地址
//        shareObject?.webpageUrl = "https://www.baidu.com"
//        
//        //分享消息对象设置分享内容对象
//        messageObject.shareObject = shareObject
//
//        //调用分享接口
//        UMSocialManager.default().share(to: .wechatSession, messageObject: messageObject, currentViewController: self) { data, error in
//            if let error = error {
//                print("************Share fail with error \(error)*********")
//            } else {
//                if let data = data {
//                    print("response data is \(data)")
//                }
//            }
//        }
    }

}

