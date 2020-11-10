//
//  TTTableViewViewModel.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit
import RxSwift

class  TTTableViewViewModel: NSObject {
    // 数据源
    var data = Observable.just([""])
    
    // 默认每页网络请求的数量 10个
    var pageSize: Int = 10
     
     // 当前页的下标
     var pageIndex: Int = 1
     
     // 是否可以上拉, 默认false
     var canPullUp: Bool  = false
     
     // 是否可以下拉, 默认false
     var canPullDown: Bool  = false
     
     // 风格, 默认grouped风格, 如果需要卡主组头，或平铺那么就换风格为plain
    var style: UITableView.Style = .grouped
     
     // 默认的单类型cell名称
     var cellSingelClassName: String = "TTTableViewCell"
     
     // cell的类型数组
     var allCellClassNames: [String] = ["TTTableViewCell"]

    
    
    required override init() {
        super.init()
        

    }
    
    
    
    // 初始化的时候会调用
//    func vmSetup()
    
//    // 控制tableView的组数
//    func numberOfSections() -> Int
//
//    // 控制行数
//    func numberOfRowsInSection() -> Int
//
//    // 根据indexPath获取cellID, ID默认就是cell的类名,可自定义变更
//    func cellIdentiferWithIndexPath(_: IndexPath) -> String
}




//protocol TTTableViewViewModelDelegate {
//    var data: ObservableObject<Array> { get set}
//
//
//    // 默认每页网络请求的数量 10个
//    var pageSize: Int { get set }
//
//     // 当前页的下标
//     var pageIndex: Int { get set }
//
//     // 是否可以上拉, 默认false
//     var canPullUp: Bool { get set }
//
//     // 是否可以下拉, 默认false
//     var canPullDown: Bool { get set }
//
//     // 风格, 默认grouped风格, 如果需要卡主组头，或平铺那么就换风格为plain
//    var style: UITableView.Style {get set}
//
//     // 默认的单类型cell名称
//     var cellSingelClassName: String {get set}
//
//     // cell的类型数组
//     var allCellClassNames: [String] {get set}
//
//    // 初始化的时候会调用
//    func vmSetup()
//
//    // 控制tableView的组数
//    func numberOfSections() -> Int
//
//    // 控制行数
//    func numberOfRowsInSection() -> Int
//
//    // 根据indexPath获取cellID, ID默认就是cell的类名,可自定义变更
//    func cellIdentiferWithIndexPath(_: IndexPath) -> String
//}


//extension TTTableViewViewModelDelegate {
//    // 子类复写，初始化之后的操作
//    func vmSetup() {
//
//    }
//
//
////    // 控制tableView的组数,默认返data的数量
////    func numberOfSections() -> Int {
////        return data.count;
////    }
////
////    // 控制行数,默认返回1
////    func numberOfRowsInSection() -> Int {
////        return 1;
////    }
////
////    // 返回tableViewCell的Identifer,有需要子类进行复写
////    func cellIdentiferWithIndexPath(_: IndexPath) -> String {
////           return cellSingelClassName;
////    }
//}


//class TTTableViewModel: TTTableViewViewModelDelegate {
//
//    var pageSize = 10;
//
//    var pageIndex = 10;
//
//    var canPullUp = true;
//
//    var canPullDown = true;
//
//    var style = UITableView.Style.grouped
//
//    var cellSingelClassName = "UITableViewCell"
//
//    var allCellClassNames = [String]()
//
//    var data: Array<Any> = [Any]()
//
//
//    // 初始化的时候加入vmSetup方法，后面可以子类去复写这个方法
//      init() {
//        self.vmSetup()
//    }
//
//    // 获取数据
//    func fetchData() {
//
//    }
//
//    func vmSetup() {
//
//    }
//}
