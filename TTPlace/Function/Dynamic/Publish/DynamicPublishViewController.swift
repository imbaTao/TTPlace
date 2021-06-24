//
//  DynamicPublishViewController.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/24.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation


class DynamicPublishViewController: TTTableViewController {

    let sendButton = UIButton()
    
    override func makeUI() {
        super.makeUI()
        // 禁止滚动
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        sendButton.title("发送笔记")
        sendButton.backgroundColor = .red
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel =  viewModel as? DynamicPublishViewModel else {
            return
        }

        
        let input = DynamicPublishViewModel.Input(publishTrigger: sendButton.rx.controlEvent(.touchUpInside).asDriver())
        
        let output = viewModel.transform(input: input)
//        output.data.subscribe(onNext: {[weak self] (viewModel) in guard let self = self else { return }
//
//        }).disposed(by: rx.disposeBag)
        
        
        output.data.asDriver().drive(tableView.rx.items(cellIdentifier: "DynamicPublishEditTitleCell", cellType: DynamicPublishEditTitleCell.self)) { tableView,viewModel,cell in
            
            if let viewModel = viewModel as? TableViewCellViewModel {
             
            }

            cell.bind(to: viewModel)
        }.disposed(by: rx.disposeBag)
        
        
        output.publishComplete.drive(onNext: <#T##((()) -> Void)?##((()) -> Void)?##(()) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        
    }
}
