//
//  TTTableView.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit

class TTTableView: UITableView {
    
    // 带默认的cell的cell类型数组
    lazy var cellClassNames: [String] = {
        var cellClassNames = ["TTTableViewCell"]
        return cellClassNames
    }()
    
    init(cellClassNames:[String], style: UITableView.Style) {
        super.init(frame: CGRect.zero, style: style)
        self.cellClassNames.append(contentsOf: cellClassNames)
        uiConfig()
        registerCell()
    }
    
    func uiConfig() {
        // 默认背景色白色
        self.backgroundColor = .white
        
        // 隐藏横向和纵向的指示条
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        
        // 设置默认自动frame转约束为false, 目前主要用snp或者masonry
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        
        if #available(iOS 11.0, *){
//            self.estimatedRowHeight = 0
//            self.estimatedSectionHeaderHeight = 0
//            self.estimatedSectionFooterHeight = 0
//            self.contentInsetAdjustmentBehavior = .never;
            
            rowHeight = UITableView.automaticDimension
            estimatedRowHeight = 50
//            sectionHeaderHeight = 40
            backgroundColor = .clear
            cellLayoutMarginsFollowReadableWidth = false
            keyboardDismissMode = .onDrag
            separatorColor = .white
            separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            separatorStyle = .none
//            tableHeaderView = TTView(height: 1)
//            tableFooterView = UIView()
        }
    }
    
    func registerCell() {
        // 遍历传进来需要注册的类
        for name in self.cellClassNames {
            // 判断xib文件是否存在
           
            if Bundle.main.path(forResource: name, ofType: "nib") != nil {
                // 存在注册xib
                self.register(UINib.init(nibName: name, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: name)
            }else {
                // 注册cell类别 & 判断类是否存在
                let appName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                if  let cellClass: AnyClass = NSClassFromString(appName + "." + name) {
                    self.register(cellClass,forCellReuseIdentifier: name)
                }
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


