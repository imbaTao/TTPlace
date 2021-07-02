//
//  DynamicPublishViewController.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/24.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa
class DynamicPublishViewController: TTTableViewController {

    let sendButton = UIButton()
    
    override func makeUI() {
        super.makeUI()
        // 禁止滚动
        tableView.isScrollEnabled = false
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(cellWithClass: DynamicPublishEditContentCell.self)
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
        let dataSource = RxTableViewSectionedReloadDataSource<DynamicSection> { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch item {
                case .editTitle(viewModel: let viewModel):
                    let cell = tableView.dequeueReusableCell(withClass: DynamicPublishEditContentCell.self)
                    cell.bind(to: viewModel)
                    return cell
            }
        }
        output.items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
}

extension DynamicPublishViewController {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var rowHeight: CGFloat = 75
//        switch indexPath.section {
//        case 0:
//            rowHeight = 332
//        default:
//            rowHeight = 75
//            break
//        }
//
//        return rowHeight
//    }
}

