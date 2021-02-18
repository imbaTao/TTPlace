//
//  ViewController1.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import Kingfisher
import RxCocoa
import TTThirdParityOC
import RongIMKit
import HandyJSON
import SwiftyJSON

class ViewController: TTViewController {
    
}

class TTButton1: UIButton {
    
}
struct Profile: HandyJSON {
    var age: Int = 0
    var gender: Int = 1
    var hometown: Int = 1
    var latitude: Float = 0.0
    var location: String? = "暂无"
    var longitude: Float = 0.0
    var nick: String? = ""
    var photos_count: Int = 0
    var qrcode: String = ""
}

class User: HandyJSON {
    var __v: Int = 0
    var _id = ""
    var created_at: String?
    var current_token: String = ""
    var identity: Int = 0 // 这个是认证
    var mobile: String?
    var profile = Profile()
    var refresh_token: String = ""
    var register: Int = 0
    var rights: Int = 0
    var score: Int = 0
    
    
    var type: Int = 0 // 这个是身份
    var updated_at: String?
    
    // 主动禁言列表（单向）
    var muted = [User]()
    
    // 被禁言列表(单向)
    var be_muted = [User]()
    
    // 是否是加好友,微信好友发起人
    var isAddFriendInitiator = false
    
 
    required init() {
        
    }
    
}



// 应用内消息
class YuhunMessage: RCMessageContent {
    var content = ""
    var extra = ""
    var type = 0 // TYPE.INTERNAL    1    应用内消息   TYPE.PUSH    2    推送 TYPE.INTERNAL_AND_PUSH    3    应用内消息+推送
    var title = ""
    override class func getObjectName() -> String! {
        return "YH:Custom"
    }
}

// 私聊送礼物消息
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


// 先封装轮播图
class ViewController1: RCConversationListViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // 设置想要显示的会话类型
        setDisplayConversationTypes([
            NSNumber.init(value:  RCConversationType.ConversationType_PRIVATE.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_APPSERVICE.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_PUBLICSERVICE.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_GROUP.rawValue),
            NSNumber.init(value:  RCConversationType.ConversationType_SYSTEM.rawValue),
        ])
        

        // 聚合会话类型
//        setCollectionConversationType([NSNumber.init(value: RCConversationType.ConversationType_SYSTEM.rawValue)])
        
      
        // 设置头像倒圆角
        setConversationAvatarStyle(.USER_AVATAR_CYCLE)


        
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
        conversationListTableView.allowsSelection = false
        
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
        
        
        // 如果数据列表没有值,那么要插入,系统通知和最近访客
        if !hasSystem {
            let model = RCConversationModel()
            model.targetId = "systemNotification"
            model.conversationType = .ConversationType_SYSTEM
            model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION
            dataSource.insert(model, at: 0)
            model.isTop = true
        }
        
        
        // 没有访客信息就插入
        if !hasVistor {
            let model = VistorsModel()
            model.targetId = "visitor"
            model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION
            dataSource.insert(model, at: 1)
            model.isTop = true
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
                return cell
            }
            
            
        }

        return RCConversationBaseCell()
    }
    
    override func rcConversationListTableView(_ tableView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        return 56 + 29
    }
    
//    insertIncomingMessage
    override func didReceiveMessageNotification(_ notification: Notification!) {
        
        if let message = notification.object as? RCMessage {

            // 如果能解析到visitor访客，那么访客数量+1，是异性，才加入系统通知
            if let model = YuhunMessageModel.deserialize(from: message.content.rawJSONData.toDictionary()) {
                
                // 如果有访客
                if let visitor = model.extra?.visitor {
                    print("取到了")
                }
            }
            
            
  
            print(message.content)
            
            
            print(message.extra)
            
//            message.extra
        }
        
        
        print(notification)
        super.didReceiveMessageNotification(notification)
        
        
        RCIMClient.shared()
    }
    
    override func willDisplayConversationTableCell(_ cell: RCConversationBaseCell!, at indexPath: IndexPath!) {
        
        print(cell)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func re() {
        
    }
}


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
        var badge = TTBadge.init(edge: .zero)
        badge.backGroundCircle.backgroundColor = .red
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

// 私聊cell
class PrivateChatCell: ChatListBaseCell {
    override func makeUI() {
        super.makeUI()
        addSubviews([timeLabel,badge])
        
        // layout
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
        
        mainTitle.text = "我是发送人啊"
        subTitle.text = model.lastContentStr
        avatar.image = R.image.message_guestRecord()
        timeLabel.text = Int(model.sentTime).chatTime()
        badge.changeBadgeNumb(numb: model.unreadMessageCount)
    
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

extension RCConversationModel {
    
    // 最近一条消息的内容
    var lastContentStr: String {
        if  let model = YuhunMessageModel.deserialize(from: self.lastestMessage.rawJSONData.toDictionary()) {
            return model.content
        }
        return  ""
    }
}


extension Data {
    // data转Dic
    func toDictionary() -> [String : Any] {
        do {
            let jsonData = try JSON.init(data: self)
            if let dataDic = jsonData.dictionaryObject {
                return dataDic
            }
        } catch {
        }
        
        return [String : Any]()
    }
}

 
class ColorsManager: UIColor {
    
}

extension UIColor {
    // 性别颜色， 男1，女2
   class func genderColor(_ gender: Int = 1) -> UIColor {
        if gender == 1 {
           return rgba(124, 200, 255, 1)
        }else {
          return rgba(255, 127, 182, 1)
        }
    }
    
    // 主要文本颜色
    static var mainStyleColor: UIColor {
        return #colorLiteral(red: 0.5607843137, green: 0.2509803922, blue: 0.9647058824, alpha: 1)
    }
    
    // 主要文本颜色
    static var mainTextColor: UIColor {
        return rgba(51, 51, 51, 1)
    }
    
    // 主要文本颜色2
    static var mainTextColor2: UIColor {
        return rgba(102, 102, 102, 1)
    }
    

}
