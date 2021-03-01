//
//  MyVipViewModel.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/1.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class MyVipViewModel: TTViewModel<TTTableViewStaticListModel> {
    override func vm() {
        fetchData()
    }
    
    func fetchData() {
        let model1 =  TTTableViewStaticListModel.init()
        model1.mainContent = "尊贵VIP会员身份标识"
        model1.subContent = "在相亲房、群聊等地方带VIP身份标识"
        model1.iconName = ""
        model1.type = .one
        
        
        let model2 =  TTTableViewStaticListModel.init()
        model2.mainContent = "会员畅聊"
        model2.subContent = "每天免费聊天人数增至50人"
        model2.iconName = ""
        model2.type = .two
        
        let model3 =  TTTableViewStaticListModel.init()
        model3.mainContent = "文案会修改"
        model3.subContent = "在相亲房、群聊等地方带VIP身份标识"
        model3.iconName = ""
        model3.type = .tree
        
        let model4 =  TTTableViewStaticListModel.init()
        model4.mainContent = "文案会修改"
        model4.subContent = "在相亲房、群聊等地方带VIP身份标识"
        model4.iconName = ""
        model4.type = .four
        
        let model5 =  TTTableViewStaticListModel.init()
        model4.mainContent = "更多每日推荐"
        model4.subContent = "在相亲房、群聊等地方带VIP身份标识"
        model4.iconName = ""
        model4.type = .five
        
        let model6 =  TTTableViewStaticListModel.init()
        model4.mainContent = "查看最近访客"
        model4.subContent = "在相亲房、群聊等地方带VIP身份标识"
        model4.iconName = ""
        model4.type = .six
        
        data = [
            model1,
            model2,
            model3,
            model4,
            model5,
            model6
        ]
    }
}

