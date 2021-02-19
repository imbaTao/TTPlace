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
    
    // 搜索按钮
    var searchButton = UIButton.button(iconName: "")
    
    init() {
        super.init(nil)
        
        //1、初始化JXSegmentedView
        segmentedView = JXSegmentedView()
        
        //2、配置数据源
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.isItemSpacingAverageEnabled = false
        segmentedDataSource.titles = ["消息列表","好友列表"]
        segmentedDataSource.titleSelectedColor = rgba(51, 51, 51, 1)
        segmentedDataSource.titleSelectedFont = .medium(24)
        segmentedDataSource.titleNormalColor = rgba(102, 102, 102, 1)
        segmentedDataSource.titleNormalFont = .medium(18)
        segmentedDataSource.itemSpacing = 24
        segmentedView.dataSource = segmentedDataSource
        
        
        
        //3、配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 47
        indicator.lineStyle = .normal
        indicator.indicatorColor = .mainStyleColor
        segmentedView.indicators = [indicator]
    
        //5、初始化JXSegmentedListContainerView
        listContainerView = JXSegmentedListContainerView(dataSource: self)

        //6、将listContainerView.scrollView和segmentedView.contentScrollView进行关联
        segmentedView.listContainer = listContainerView
//        segmentedView
        
        
        addSubviews([segmentedView,listContainerView,searchButton])
        
        // layout
        segmentedView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(ttSafeTop())
            make.height.equalTo(45)
        }
        
        searchButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-inset)
        }
        
        
        listContainerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentedView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        
    }
    
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
            let messgeListVC = MessageListVC()
            return messgeListVC
        }else {
        // 好友列表
            let friendList = FriendListVC(FriendListViewModel())
            return friendList
        }
    }
}
