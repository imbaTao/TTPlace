//
//  EmptyTableView.swift
//  hdd4iPhone
//
//  Created by 树猫 on 2022/7/15.
//  Copyright © 2022 Bifrost. All rights reserved.
//

//import DZNEmptyDataSet
import UIKit

class EmptyTableView: UITableView {
    var headerRefreshEvent = PublishSubject<Int>()
    var footerRefreshEvent = PublishSubject<Int>()
    var refreshFinish = ReplaySubject<(TTAutoRefreshState)>.create(bufferSize: 1)

    // 是否需要空数据显示
    var isNeedEmptyDatasource: Bool = false {
        didSet {

        }
    }

    // 空内容显示
    var emptyDataSourceConfig: TTEmptyDataSourceConifg = .init(
        content: "", font: .regular(12), color: .gray, offSet: 0, allowTouch: true)
    {
        didSet {
            // 设置空视图代理
            self.emptyDataSetDelegate = self
            self.emptyDataSetSource = self
            //            self.reloaEmptyDataSet()
        }
    }

    //  头部刷新结束事件
    var headerEndRefreshEvent = PublishSubject<()>()

    //  尾部刷新结束事件
    var footerEndRefreshEvent = PublishSubject<()>()

    var refreshState: TTAutoRefreshState = .empty {
        willSet {
            //            refreshHeaderOrFooterState(newValue,self.refreshState)
        }
    }

    // 带默认的cell的cell类型数组
    lazy var cellClassNames: [String] = {
        var cellClassNames = ["TTTableViewCell"]
        return cellClassNames
    }()

    init(style: UITableView.Style) {
        super.init(frame: CGRect.zero, style: style)
        makeUI()
        bindViewModel()
    }

    func bindViewModel() {

    }

    func makeUI() {
        // 默认背景色白色
        self.backgroundColor = .white

        // 隐藏横向和纵向的指示条
        //        self.showsVerticalScrollIndicator = false;
        //        self.showsHorizontalScrollIndicator = false;

        // 设置默认自动frame转约束为false, 目前主要用snp或者masonry
        self.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 13.0, *) {
            automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }

        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }

        estimatedSectionHeaderHeight = 0
        estimatedSectionFooterHeight = 0
        estimatedRowHeight = UITableView.automaticDimension
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }

        rowHeight = UITableView.automaticDimension
        backgroundColor = .clear
        cellLayoutMarginsFollowReadableWidth = false
        keyboardDismissMode = .onDrag
        separatorColor = .white
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        separatorStyle = .none
    }

    func registerCell() {
        // 遍历传进来需要注册的类
        //        for name in self.cellClassNames {
        //            // 判断xib文件是否存在
        //
        //            if Bundle.main.path(forResource: name, ofType: "nib") != nil {
        //                // 存在注册xib
        //                self.register(UINib.init(nibName: name, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: name)
        //            }else {
        //                // 注册cell类别 & 判断类是否存在
        //                let appName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        //                if  let cellClass: AnyClass = NSClassFromString(appName + "." + name) {
        //                    self.register(cellClass,forCellReuseIdentifier: name)
        //                }
        //            }
        //        }
    }

    var needShowEmptyViewBlock: (() -> (Bool))? = nil
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyTableView: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let content = emptyDataSourceConfig.content
        let attContent = NSMutableAttributedString.init(string: content)
        attContent.setColor(emptyDataSourceConfig.color)
        attContent.setFont(emptyDataSourceConfig.font)
        return attContent
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return emptyDataSourceConfig.offSet
    }

    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return emptyDataSourceConfig.allowTouch
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSetShouldBeForced(toDisplay scrollView: UIScrollView!) -> Bool {
        if needShowEmptyViewBlock != nil {
            return needShowEmptyViewBlock!()
        }
        return false
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        if let icon = emptyDataSourceConfig.emptyIcon {
            return icon
        } else {
            return UIImage()
        }
    }

    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 1
    }
}
