//
//  TTAutoRefreshTableViewController.swift
//  TTBox
//
//  Created by Mr.hong on 2021/1/20.
//

import UIKit

class TTTableViewConfigManager: NSObject {
    static let shared = TTTableViewConfigManager()

    
    // 标题字体
    var titleFont = UIFont()
    var titleColor = UIColor.white
    
    // 描述字体
    var desFont = UIFont()
    var desColor = UIColor.white
    
    // 按钮字体
    var buttonFont = UIFont()
    var buttonTitleColor = UIColor.white
    var buttonTitle = "重新加载"
    var buttonBackgroundImage = UIImage()
 
    
    // 无网络连接空页面占位图
    var notNetworkEmptyIcon = UIImage()
    var notNetworkemptyText = "对不起网络好像故障了~"
    
    
    
    // 无数据空页面占位图
    var notDataEmptyIcon = UIImage()
    var notDataEmptyText = "暂时还没有房间去其他地方逛逛～"
    
    
    
    // 刷新尾部
    var footerImage: UIImage?
    var footerContent: String?
    var refreshFooterClass: MJRefreshAutoStateFooter.Type?
}


class TTAutoRefreshTableViewController: TTTableViewController {
    override func makeUI() {
        super.makeUI()
        tableView =  TTTableView.init(cellClassNames: [""], style: .plain, state: .justHeader)
        contentView.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        isNeedShowEmptyData = true
    }
}
