//
//  MyProfileViewModel.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/27.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation


class ProfileViewModel: TTViewModel<TTTableViewStaticListModel> {
    override func vm() {
        fetchData()
    }
    
    func fetchData() {
        let model1 =  TTTableViewStaticListModel.init()
        model1.mainContent = "编辑资料"
        model1.subContent = "已完成50%"
        model1.iconName = ""
        model1.type = .one
        
        
        let model2 =  TTTableViewStaticListModel.init()
        model2.mainContent = "筛选条件"
        model2.subContent = "21-29岁｜上海｜老家江苏"
        model2.iconName = ""
        model2.type = .two
        
        let model3 =  TTTableViewStaticListModel.init()
        model3.mainContent = "我的认证"
        model3.subContent = ""
        model3.iconName = ""
        model3.type = .tree
        
        let model4 =  TTTableViewStaticListModel.init()
        model4.mainContent = "我的相亲资料"
        model4.subContent = "已完成50%"
        model4.iconName = ""
        model4.type = .four
        
        data = [
            model1,
            model2,
            model3,
            model4,
        ]
    }
}

