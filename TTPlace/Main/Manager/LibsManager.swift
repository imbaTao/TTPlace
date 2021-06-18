//
//  LibsManager.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/17.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import Bugly

let umAppkey = "60caad098a102159db6a72bf"
let buglyKey = "b64ad030d9"
let rongKey = "lmxuhwagl6dkd"
func setupUM() {
    // 友盟
    UMConfigure.initWithAppkey(umAppkey, channel: "App Store")
}


// 初始化网络管理者
func setupNetAccessBility() {
    ZYNetworkAccessibility.setAlertEnable(false)
    ZYNetworkAccessibility.start()
}

func setupBugly() {
    Bugly.start(withAppId: buglyKey)
    
//    if USER._id.count > 0 {
//       Bugly.setUserIdentifier(USER._id)
//    }
}

// 网络状态监测
func checkNetWorking() {
    ZYNetworkAccessibility.setStateDidUpdateNotifier { (state) in
        // 判断状态
        switch state {
        case .checking,.unknown,.accessible:
            // 移除弹框
            TTCustomAlert.dismiss()
        case .restricted:
            // 显示网络权限获取弹框
            showOriginalAlert(title: "提示", message: "需要获取您的网络权限",buttonTitles: ["好的"]) { (index) in
                TTAuthorizer.openSettingUrl(.network, alert: false)
            }
        default:break;
        }
    }
}

// 初始化融云
//func setupRongIM() {
//    RCIM.shared()?.initWithAppKey(TTEnvironmentManager.shared.rongKey)
//
//    // 注册自定义消息
//    RCIMClient.shared().registerMessageType(YuhunMessage.self)
////        RCIMClient.shared().registerMessageType(YuhunWarningMessage.self)
//    RCIMClient.shared().registerMessageType(YuhunPrivateChatGiftMessage.self)
//    RCIMClient.shared().registerMessageType(YuhunInviteFriendsMessage.self)
//
//
//    // 语音质量
//    RCIMClient.shared()?.voiceMsgType = .highQuality
//
//
//    RCIM.shared()?.enableTypingStatus = true
//    RCIM.shared()?.enableSyncReadStatus = true
//    RCIM.shared()?.showUnkownMessage = true
//    RCIM.shared()?.enableMessageMentioned = true
//    RCIM.shared()?.enableMessageRecall = true
//    RCIM.shared()?.isMediaSelectorContainVideo = false
//    RCIM.shared()?.enableSendCombineMessage = true
//    RCIM.shared()?.enableDarkMode = false
//    RCIM.shared()?.reeditDuration = 120
//    RCIM.shared()?.globalMessageAvatarStyle = .USER_AVATAR_CYCLE
//
//    RCIMClient.shared()?.logLevel = RCLogLevel.log_Level_Info
//    RCIM.shared()?.userInfoDataSource = IMUserManager.shared
//
//    //设置会话列表头像和会话页面头像,缓存
//    RCIM.shared()!.enablePersistentUserInfoCache = true
//    // 设置常量
//
//    //
//    // 屏幕常亮
//    UIApplication.shared.rx.observe(Bool.self, "isIdleTimerDisabled").subscribe(onNext: {[weak self] (result) in guard let self = self else { return }
//        if result == false {
//            UIApplication.shared.isIdleTimerDisabled = true
//        }
//    }).disposed(by: rx.disposeBag)
//
//}
