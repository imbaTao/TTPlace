//
//  TTCommonTableViewController.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.


import UIKit

class TTTableViewController<T: TTTableViewViewModel>: UIViewController {
    /**
     包含一个默认的vm
     vm.可以控制tableView的样式
     管理data
     处理加工data
     */
    
    
    // 设置VM
    let vm = T()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.addSubview(tableView)
//
//
//
//        // layout
//        tableView.snp.makeConstraints { (make) in
//            make.edges.equalTo((self.view))
//        }
//
//
//
//
//        // rx
//        //设置单元格数据（其实就是对 cellForRowAt 的封装）
//        self.vm.data.bind(to: tableView.rx.items){ (tableview, row, element) in
//            let cell = tableview.dequeueReusableCell(withIdentifier: "cell")
//            cell?.accessoryType = .detailDisclosureButton
//            cell?.textLabel?.text = "\(row): \(element)"
//            return cell!
//        }.disposed(by: rx.disposeBag)
//
//
//        //        获取点击行
//                tableView.rx.itemSelected.subscribe(onNext: { [weak self] (index) in
//                     print("\(index.row)")
//        //            self?.showAlert(title: "点击第几行", message: "\(index.row)")
//                }).disposed(by: rx.disposeBag)
//
//        //        获取点击内容
//                tableView.rx.modelSelected(String.self).subscribe(onNext: { [weak self] (title) in
//                    print("\(title)")
//        //            self?.showAlert(title: "点击内容", message: "\(title)")
//                }).disposed(by: rx.disposeBag)
//
//
//                // 获取选中项的索引和内容
//                Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self)).bind { indexPath, item in
//                    print("选中项的indexPath为: \(indexPath)")
//                    print("选中项的标题为: \(item)")
//                    }.disposed(by: rx.disposeBag)
//
//        //        获取被取消选中项的索引
//                tableView.rx.itemDeselected.subscribe(onNext: { (index) in
//                    print("点击取消行：\(index.row)")
//                }).disposed(by: rx.disposeBag)
//
//        //        获取被取消选中项的内容
//                tableView.rx.modelDeselected(String.self).subscribe(onNext: { (title) in
//                    print("点击取消内容：\(title)")
//                }).disposed(by: rx.disposeBag)
//
//        //        获取删除项的索引
//                tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
//                    print("删除项的indexPath为：\(indexPath)")
//                }).disposed(by: rx.disposeBag)
//
//                //获取删除项的内容
//                tableView.rx.modelDeleted(String.self).subscribe(onNext: { item in
//                    print("删除项的的标题为：\(item)")
//                }).disposed(by: rx.disposeBag)
//
//        //        获取移动项的索引
//                tableView.rx.itemMoved.subscribe(onNext: { sourceIndexPath, destinationIndexPath in
//                    print("移动项原来的indexPath为：\(sourceIndexPath.row)")
//                    print("移动项现在的indexPath为：\(destinationIndexPath.row)")
//                }).disposed(by: rx.disposeBag)
//
//                //获取插入项的索引
//                tableView.rx.itemInserted.subscribe(onNext: { indexPath in
//                    print("插入项的indexPath为：\(indexPath)")
//                }).disposed(by: rx.disposeBag)
//
//                // 单元格将要显示出来的事件响应
//                 tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
//                    print("将要显示的indexPath为：\(indexPath)")
//                    print("将要显示的cell为：\(indexPath)")
//                }).disposed(by: rx.disposeBag)
//
//                // 获取点击的尾部图标的索引
//                tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { indexPath in
//                    print("尾部项的indexPath为：\(indexPath)")
//                }).disposed(by: rx.disposeBag)
//    }
//
//
//
//    lazy var tableView: TTCommonTableView = {
//        var tableView = TTCommonTableView.init()
//        return tableView
//    }()
}




