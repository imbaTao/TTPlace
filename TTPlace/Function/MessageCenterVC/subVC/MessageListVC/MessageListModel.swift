//
//  MessageListModel.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/19.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

// 应用内消息基类,属于自定义消息
class YuhunMessage: RCMessageContent {
    var content = ""
    var extra = ""
    var type = 0 // TYPE.INTERNAL    1    应用内消息   TYPE.PUSH    2    推送 TYPE.INTERNAL_AND_PUSH    3    应用内消息+推送
    var title = ""
    override class func getObjectName() -> String! {
        return "YH:Custom"
    }
}

// 私聊送礼物消息，也是自定义消息
class YuhunPrivateChatGiftMessage: YuhunMessage {
    override class func getObjectName() -> String! {
        return "YH:CustomPresentation"
    }
}

// 消息模型
class YuhunMessageModel: HandyJSON {
    var content = ""
    var extra : YuhunMessageExtraModel?
    var type = 0 // TYPE.INTERNAL    1    应用内消息   TYPE.PUSH    2    推送 TYPE.INTERNAL_AND_PUSH    3    应用内消息+推送
    var title = ""
    var sendTime: Int64 = 0 // 发送时间
    var avatarUrl = "" // 头像地址
    
    required init() {
        
    }
}

// 消息模型中的extra扩展内容
class YuhunMessageExtraModel: HandyJSON {
    var userId = ""
    var visitor: User?
    required init() {
        
    }
}

// 最近访客会话模型
class VistorsModel: RCConversationModel {
    
}
extension RCConversationModel {
    
    // 最近一条消息的内容
    var lastContentStr: String {
        if  let model = YuhunMessageModel.deserialize(from: self.lastestMessage.rawJSONData.toDictionary()) {
            return model.content
        }
        return  ""
    }
}
