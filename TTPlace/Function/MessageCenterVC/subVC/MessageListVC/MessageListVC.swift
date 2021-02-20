//
//  MessageListVC.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/19.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import UIKit


// 先封装轮播图
class MessageListVC: RCConversationListViewController,JXSegmentedListContainerViewListDelegate {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        // 设置想要显示的会话类型
        setDisplayConversationTypes([
            NSNumber.init(value:  RCConversationType.ConversationType_PRIVATE.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_APPSERVICE.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_PUBLICSERVICE.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_GROUP.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_SYSTEM.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue),
        ])
        

        // 聚合会话类型
        // setCollectionConversationType([NSNumber.init(value: RCConversationType.ConversationType_SYSTEM.rawValue)])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 注册cell
        conversationListTableView.register(cellWithClass: SystemNotificationCell.self)
        conversationListTableView.register(cellWithClass: VistorConversationCell.self)
        conversationListTableView.register(cellWithClass: PrivateChatCell.self)
        conversationListTableView.separatorStyle = .none
        
        
//        let model = VistorsModel()
//        model.conversationType = .ConversationType_CUSTOMERSERVICE
//        model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION
//        model.targetId = "6111111"
//        model.sentTime = Int64(Date().timeIntervalSince1970)
//        model.receivedTime = Int64(Date().timeIntervalSince1970)
//        model.isTop = true
//        refreshConversationTableView(with: model)
        
        // 如果数据列表没有值,那么要插入,系统通知和最近访客
   //        if !hasSystem {
               let model = RCConversationModel()
               model.targetId = "systemNotification"
               model.conversationType = .ConversationType_SYSTEM
               model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION
               conversationListDataSource.insert(model, at: 0)
               model.isTop = true
   //        }
        
    }
    
    //*********************插入自定义Cell*********************//
    //插入自定义会话model
    
    override func willReloadTableData(_ dataSource: NSMutableArray!) -> NSMutableArray! {
        var hasSystem = false
        var hasVistor = false
        for index in 0..<dataSource.count {
            if let model = dataSource[index] as? RCConversationModel {
                model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION
                
//                switch model.conversationType {
//                case .ConversationType_SYSTEM:
//                    model.isTop = true
//                    hasSystem = true
//
//                    print("是否有系统通知了\(hasSystem)")
//                default:
//                    break
//                }
                
                if (model.conversationType == .ConversationType_SYSTEM)  {
                    model.isTop = true
                    hasSystem = true

                    print("是否有系统通知了\(hasSystem)")
                }else {
                    model.isTop = false
                }
                
                
                // 是否是最近访客会话，同样置顶
                if model.isMember(of: VistorsModel.self) {
                    hasVistor = true
                    model.isTop = true
                }
            }
        }
        
        
//        // 如果数据列表没有值,那么要插入,系统通知和最近访客
        if !hasSystem {
            let model = RCConversationModel()
            model.targetId = "systemNotification"
            model.conversationType = .ConversationType_SYSTEM
            model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION
//            dataSource.insert(model, at: 0)
            model.isTop = true
            refreshConversationTableView(with: model)
        }
        
        
        // 没有访客信息就插入
        if !hasVistor {
            let model = VistorsModel()
            model.conversationType = .ConversationType_CUSTOMERSERVICE
            model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION
            model.targetId = "visitor"
            model.sentTime = Int64(Date().timeIntervalSince1970)
            model.receivedTime = Int64(Date().timeIntervalSince1970)
            model.isTop = true
            
         
//            dataSource.insert(model, at: 1)
            print("刷新会话1")
            refreshConversationTableView(with: model)
//            super.refreshConversationTableViewIfNeeded()
            print("刷新会话2")
        }

        return dataSource
    }
    
    // 是否有最近访客会话
    func hasVistorConversation(_ array: NSMutableArray) -> Bool {
        // 遍历数组
        for item in conversationListDataSource {
            if let _ = item as? VistorsModel {
                return true
            }
        }
        return false
    }
    

    
//    insertIncomingMessage
    override func didReceiveMessageNotification(_ notification: Notification!) {
        
        if let message = notification.object as? RCMessage {

            // 如果是系统会话
            if message.conversationType == .ConversationType_SYSTEM {
                // 如果能解析到visitor访客，那么访客数量+1，是异性，才加入系统通知
                if let model = YuhunMessageModel.deserialize(from: message.content.rawJSONData.toDictionary()) {
                    
                    // 如果有访客
                    if let visitor = model.extra?.visitor {
                        
    //                    //  更新会话
    //                    let customModel = RCConversationModel.init()
    //                    customModel.conversationType = .ConversationType_CUSTOMERSERVICE
    //                    customModel.targetId = "visitor"
    //                    customModel.sentTime = message.sentTime
    //                    customModel.receivedTime = message.receivedTime
    //                    customModel.senderUserId = message.senderUserId
    //                    customModel.lastestMessage = message.content
    //
    //                    DispatchQueue.main.async {
    //                        self.refreshConversationTableView(with: customModel)
    //                        self.notifyUpdateUnreadMessageCount()
    //                        let left = notification.userInfo!["left"] as? NSNumber
    //                        if 0 == left?.intValue ?? 0 {
    //                           super.refreshConversationTableViewIfNeeded()
    //                        }
    //                    }
                        
                    }else {
                        
                        
                         

                    }
                }else {
    //                super.didReceiveMessageNotification(notification)
                }
                
            }else {
    //            super.didReceiveMessageNotification(notification)
            }
        }
            
            
           
        
        super.didReceiveMessageNotification(notification)
    
    }
    
    //MARK: - 自定义cell
    override func rcConversationListTableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> RCConversationBaseCell! {
        if let model = conversationListDataSource[indexPath.row] as? RCConversationModel {
            
            // 如果是访客的会话模型
            if model.targetId == "visitor" {
                let cell = tableView.dequeueReusableCell(withClass: VistorConversationCell.self)
                cell.setDataModel(model)
                 return cell
            }
            
            // 会话类型是系统消息
            if model.conversationType == .ConversationType_SYSTEM {
                let cell = tableView.dequeueReusableCell(withClass: SystemNotificationCell.self)
                cell.setDataModel(model)
                 return cell
            }
            
            // 会话类型是私聊消息
            if model.conversationType == .ConversationType_PRIVATE {
                let cell = tableView.dequeueReusableCell(withClass: PrivateChatCell.self)
                cell.setDataModel(model)

                print("进来了")
                return cell
            }
            
            
        }

        return RCConversationBaseCell()
    }
    
    override func rcConversationListTableView(_ tableView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        return 56 + 29
    }
    
    override func willDisplayConversationTableCell(_ cell: RCConversationBaseCell!, at indexPath: IndexPath!) {
        
        print(cell)
    }
    
    
    // 选中了某行
    
//    点击会话列表中Cell的回调

//    @param conversationModelType   当前点击的会话的Model类型
//    @param model                   当前点击的会话的Model
//    @param indexPath               当前会话在列表数据源中的索引值
//
//    @discussion 您需要重写此点击事件，跳转到指定会话的会话页面。
//    如果点击聚合Cell进入具体的子会话列表，在跳转时，需要将isEnteredToCollectionViewController设置为YES。
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        
        switch model.conversationType {
        case .ConversationType_SYSTEM:
            var data = [YuhunMessageModel]()
            if let messages =  RCIMClient.shared()?.searchMessages(.ConversationType_SYSTEM, targetId: model.targetId, userId: model.senderUserId, count: 200, startTime: 0) {
                if messages.count > 0 {
                    messages.forEach { (message) in
                        if let messageModel = YuhunMessageModel.deserialize(from: message.content.rawJSONData.toDictionary()) {
                            // 如果解析出来了
                            messageModel.sendTime = message.sentTime
                            
                            data.append(messageModel)
                        }
                    }
                }
            }
            

            
            print(data)
            print(model.senderUserId)
            
            // 系统会话
            let vc = SystemNotificationDetailVC.init(data: data)
            self.navigationController?.pushViewController(vc)
            
            // 将未读消息置空
            RCIMClient.shared()?.clearMessagesUnreadStatus(.ConversationType_SYSTEM, targetId: model.targetId)
        case .ConversationType_PRIVATE:
            let chatVC = PrivateChatVC()
            chatVC.targetId = model.targetId
            chatVC.conversationType = model.conversationType
            
            if (model.conversationModelType == .CONVERSATION_MODEL_TYPE_NORMAL) {
                chatVC.unReadMessage = model.unreadMessageCount
                chatVC.enableNewComingMessageIcon = true // 开启消息提醒
                chatVC.enableUnreadMessageIcon = true
                
                if model.conversationType == .ConversationType_PRIVATE {
                    chatVC.displayUserNameInCell = false
                }
            }
            
            baseTabbar()?.isHidden = true
            self.navigationController?.pushViewController(chatVC)
            
            
//            RCDChatViewController *chatVC = [[RCDChatViewController alloc] init];
//            chatVC.conversationType = model.conversationType;
//            chatVC.targetId = model.targetId;
//            chatVC.userName = model.conversationTitle;
//            chatVC.title = model.conversationTitle;
//            if (model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_NORMAL) {
//                chatVC.unReadMessage = model.unreadMessageCount;
//                chatVC.enableNewComingMessageIcon = YES; //开启消息提醒
//                chatVC.enableUnreadMessageIcon = YES;
//                if (model.conversationType == ConversationType_SYSTEM) {
//                    chatVC.userName = RCDLocalizedString(@"de_actionbar_sub_system");
//                    chatVC.title = RCDLocalizedString(@"de_actionbar_sub_system");
//                } else if (model.conversationType == ConversationType_PRIVATE) {
//                    chatVC.displayUserNameInCell
//                }
//
//            [self.navigationController pushViewContr
            break
        default:
            break
        }
        
        
        // 选中某行
        print(model)
    }
    
    
    // 选中
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("选中")
//    }
    
    
    // 分页控制器返回内容视图,delgate
    func listView() -> UIView {
        return self.view
    }
    
    func re() {
        
    }
}


// 私聊控制器
class PrivateChatVC: RCConversationViewController {

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        
        return cell
    }
    
    override func willDisplayMessageCell(_ cell: RCMessageBaseCell!, at indexPath: IndexPath!) {
        super.willDisplayMessageCell(cell, at: indexPath)

         let model = conversationDataRepository[indexPath.row] as! RCMessageModel
        
        
        print(model.senderUserId)
        // 如果是视频消息
        if let imageCell = cell as? RCImageMessageCell {
//            imageCell.pictureView.image = model.
        }
        
        
        // 如果是文本消息
        if let textCell = cell as? RCTextMessageCell {
            textCell.statusContentView.isHidden = true
            
            let imageView = RCSwiftTool.getImageView(textCell)
            // 发送者id 是我自己
            if model.senderUserId == "6004f72a44c19f417fe3385a" {
                textCell.textLabel.textColor = rgba(141, 79, 255, 1)
                textCell.textLabel.font = .regular(17)
                
            
                imageView.isHidden = true
                textCell.baseContentView.x += 45
            
            }else {
                textCell.textLabel.textColor = rgba(51, 51, 51, 1)
                textCell.textLabel.font = .regular(17)
                imageView.isHidden = false
            }
            
//
//                imageView.snp.remakeConstraints { (make) in
//                    make.left.equalTo(textCell.baseContentView.snp.right)
//                    make.centerY.equalToSuperview()
//                }
                
//                if model.senderUserId == "" {
//
//                }
                
                
//                textCell.baseContentView.subviews.forEach { (subView) in
//                    if subView.size == .init(width: 40, height: 40) {
//
//                        // 找到contentView
//                        textCell.baseContentView.subviews.forEach { (subView1) in
//                            if subView1.isMember(of: RCContentView.self) {
//                                subView1.x += 40
//                            }
//                        }
//
//                        textCell.bubbleBackgroundView.image = UIImage.init(color: .white, size: textCell.baseContentView.size)
//                        textCell.bubbleBackgroundView.cornerRadius = 8
//
//
//                        print("文字内容size \(textCell.baseContentView.size)")
//                        subView.removeFromSuperview()
//                    }
//                }
        }
    }
}





