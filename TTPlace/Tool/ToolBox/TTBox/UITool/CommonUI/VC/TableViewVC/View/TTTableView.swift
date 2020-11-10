//
//  TTTableView.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit

class TTTableView: UITableView {
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
        
        // ios 11关闭预计算高度,自动计算边距
        if #available(iOS 11.0, *){
            self.estimatedRowHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.estimatedSectionFooterHeight = 0
            self.contentInsetAdjustmentBehavior = .never;
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
    
    // 带默认的cell的cell类型数组
    lazy var cellClassNames: [String] = {
        var cellClassNames = ["TTTableViewCell"]
        return cellClassNames
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


