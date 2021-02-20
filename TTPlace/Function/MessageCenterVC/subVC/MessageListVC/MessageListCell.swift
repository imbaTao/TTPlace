//
//  MessageListCell.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/19.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class ChatListBaseCell: RCConversationBaseCell {
    lazy var avatar: TTAvatar = {
        var avatar = TTAvatar()
        avatar.snp.makeConstraints { (make) in
            make.size.equalTo(56)
        }
        return avatar
    }()
    
    lazy var mainTitle: UILabel = {
        var mainTitle = UILabel.medium(size: 16, textColor: rgba(51, 51, 51, 1), text: "我是标题", alignment: .left)
        return mainTitle
    }()
    
    lazy var subTitle: UILabel = {
        var subTitle = UILabel.regular(size: 14, textColor: rgba(102, 102, 102, 1), text: "暂无新消息", alignment: .left)
        return subTitle
    }()
    
    lazy var timeLabel: UILabel = {
        var timeLabel = UILabel.regular(size: 12, textColor: rgba(102, 102, 102, 1), text: "28分钟前", alignment: .right)
        return timeLabel
    }()
    
    lazy var badge: TTBadge = {
        var badge = TTBadge.init(padding: .zero,pointSize: CGSize.init(width: 18, height: 18))
        badge.backgroundColor = rgba(254, 64, 61, 1)
        badge.contentLable.config(font: .regular(13), textColor: .white, text: "1", alignment: .center, numberOfline: 1)
        return badge
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
    }
    
    func makeUI() {
        addSubviews([avatar,mainTitle,subTitle])
        
        // layout
        avatar.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
        }
        
        mainTitle.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(12)
            make.top.equalTo(avatar).offset(4)
            make.right.equalToSuperview()
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.left.equalTo(mainTitle)
            make.bottom.equalTo(avatar).offset(-4)
            make.right.equalToSuperview()
        }
        
        // config
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 系统通知cell
class SystemNotificationCell: ChatListBaseCell {
    override func makeUI() {
        super.makeUI()
     
    }
    
    // 设置数据源
    override func setDataModel(_ model: RCConversationModel!) {
        self.model = model
        
        mainTitle.text = "系统通知"
        subTitle.attributedText = subTitleContent()
        avatar.image = R.image.message_systemNotification()
    }
    
    func subTitleContent() -> NSMutableAttributedString {
        if model.unreadMessageCount > 0 {
            let countStr = "\(model.unreadMessageCount)"
            let att = NSMutableAttributedString.init(string: "有\(countStr)条新消息")
            att.setColor(.mainStyleColor, range: .init(location: 1, length: countStr.count))
            return att
        }else {
            let att = NSMutableAttributedString.init(string: "暂无新消息")
            att.color = rgba(102, 102, 102, 1)
            return att
        }
    }
}

// 最近访客通知cell
class VistorConversationCell: ChatListBaseCell {
    override func makeUI() {
        super.makeUI()
     
    }
    
    // 设置数据源
    override func setDataModel(_ model: RCConversationModel!) {
        self.model = model
        
        mainTitle.text = "最近访客"
        subTitle.attributedText = subTitleContent()
        avatar.image = R.image.message_guestRecord()
    }
    
    func subTitleContent() -> NSMutableAttributedString {
        if model.unreadMessageCount > 0 {
            let countStr = "\(model.unreadMessageCount)"
            let att = NSMutableAttributedString.init(string: "你有\(countStr)位新访客")
            att.setColor(.mainStyleColor, range: .init(location: 2, length: countStr.count))
            return att
        }else {
            let att = NSMutableAttributedString.init(string: "暂无新消息")
            att.color = rgba(102, 102, 102, 1)
            return att
        }
    }
}

// 私聊cell
class PrivateChatCell: ChatListBaseCell {
    override func makeUI() {
        super.makeUI()
        addSubviews([timeLabel,badge])
        
        // layout
        
        mainTitle.snp.remakeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(12)
            make.top.equalTo(avatar).offset(4)
            make.right.equalTo(timeLabel.snp.left).offset(-12)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.centerY.equalTo(mainTitle)
            make.left.equalTo(mainTitle.snp.right).offset(12)
        }
        
        badge.snp.makeConstraints { (make) in
            make.right.equalTo(timeLabel)
            make.centerY.equalTo(subTitle)
        }
        
        // 默认隐藏未读角标
        badge.changeBadgeNumb(numb: 0)
    }
    
    // 设置数据源
    override func setDataModel(_ model: RCConversationModel!) {
        self.model = model
        
        
        
        
//        RCUserInfo *userInfo = [[RCIM sharedRCIM] getUserInfoCache:self.userId];
        // 获取用户缓存，没有会从服务器拿
        let user = RCIM.shared()?.getUserInfoCache(model.senderUserId)
        mainTitle.text = user?.name
        avatar.netImage(user?.portraitUri)
        timeLabel.text = Int(model.sentTime).chatTime()
        badge.changeBadgeNumb(numb: model.unreadMessageCount)
        
        
        // 如果是文本消息
        if let message =  model.lastestMessage as?  RCTextMessage {
            subTitle.text = message.content
        }
    }
    
    func subTitleContent() -> NSMutableAttributedString {
        if model.unreadMessageCount > 0 {
            let countStr = "\(model.unreadMessageCount)"
            let att = NSMutableAttributedString.init(string: "有\(countStr)条新消息")
            att.setColor(.mainStyleColor, range: .init(location: 1, length: countStr.count))
            return att
        }else {
            let att = NSMutableAttributedString.init(string: "暂无新消息")
            att.color = rgba(102, 102, 102, 1)
            return att
        }
    }
}
