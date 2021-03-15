//
//  WebJsVC.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/12.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import UIKit



struct JSBridgeBaseModel: HandyJSON {
    // 类型
    //case 0 // data 不限制, responseData 不限制
    //case 1 // 关闭顶部导航data 不限制, responseData 不限制
    //case 2 // 刷新用户Token, data 不限制, responseData 包含token参数
    //case 3 // 调用客户端的分享,data 中至少有sharetype这个参数，表示调用的分享类型 ，responseData 不限制
//    case 4 data 中至少有router这个参数，表示需要跳转的页面 ，responseData 不限制
    var type: Int = 0
    
    var data: JSBridgeDetailModel?
}


struct JSBridgeDetailModel: HandyJSON {
    var title: String?
    var content: String?
    var sharetype = 0 // 1微信好友,2朋友圈
    var url: String?
    var imageurl: String?
    
    // 路由
    var router: String?
    
    // 用户的id
    var _id: String?
    
    // 分享图片地址
    var imageurlString: String?
}


let routerList = ["my","recharge"]
class WebJsVC: TTWebViewController {
    var bridge: WebViewJavascriptBridge!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 是否可以手势返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        title = "asdfsddf"
        navigationBarDefaultConfig()
       jsBridgeConfig()
    }
    
    
    override func makeUI() {
        super.makeUI()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        webView.load(URLRequest.init(url: currentUrl))
    }

    func jsBridgeConfig() {
        // 初始化桥接对象
        bridge = WebViewJavascriptBridge.init(self.webView)
        
        // 注册web中的handler
        bridge.registerHandler("dataToNative") { (data, responseCallback) in
            
             
            if let data = data as? [String : Any] {
                if let model = JSBridgeBaseModel.model(data) {
                    switch model.type {
                    case 0:
                        print("pop回去")
                        self.navigationController?.navigationBar.isHidden = false
                        self.navigationController?.navigationBar.isTranslucent = false
                    case 1:
                        // 隐藏导航栏
                        self.hiddenNavigationBar()
                        
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.navigationBar.isTranslucent = true
                    case 2:
                        // 刷新用户token
                        print("刷新用户token")
                    case 3:
                        // 分享
                        print("分享类型是\(model.data?.sharetype)")
                    case 4:
                        let routerName = model.data!.router
                        
                        switch routerName {
                        case "my":
                            print("跳转个人中心")
                        case "recharge":
                            print("跳转重置页面")
                        case "income":
                            print("跳转到我的红包页面")
                        case "onlineRoom":
                            print("跳转到相亲房列表页")
                        case "profile":
                            print("跳转到某个用户profile中心")
                        default:
                            break
                        }
                    default:
                        break
                    }
                    
                    // 类型
                    if  model.type != 2 {
                        // 获取token后
                        let tokenData = ["token" : "新的token"]
                        responseCallback?(tokenData)
                    }else {
                        responseCallback?(data)
                    }
                }else {
                    responseCallback?(data)
                }
            }else {
                responseCallback?(data)
            }
        }
        
        
       
        
//        print("echo \(String(describing: data))")

        
    
        
        // 调用js
//        bridge.callHandler("dataToNative", data: nil) { (responseData) in
//            print("received response:\(String(describing: responseData))")
//        }
    }
    
    
    
    
    // 同步获取token
    func fetchToken() {
        // type为1 隐藏导航栏
//        hiddenNavigationBar()
        
    }
    
    func shareAction() {
        print("分享事件")
    }
}
