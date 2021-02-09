//
//  MessageCenterVC.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/8.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
@_exported import JXSegmentedView
class MessageCenterVC: ViewController,JXSegmentedListContainerViewDataSource {
    
    
    // 头部数据源
    var segmentedDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    
    @objc func injected() {
        re()
    }
    
    func re() {
        
    }
}


extension MessageCenterVC {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.dataSource.count
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        // 消息列表
        if index == 0  {
            let messgeListVC = MessageListVC(MessageListViewModel())
            return messgeListVC
        }else {
        // 好友列表
            let friendList = FriendListVC(FriendListViewModel())
            return friendList
        }
    }
}
