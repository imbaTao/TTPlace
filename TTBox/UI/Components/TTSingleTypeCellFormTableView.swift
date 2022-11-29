//
//  TTSingleTypeCellFormTableView.swift
//  TTNew
//
//  Created by Mr.hong on 2021/10/20.
//

import Foundation

class TTSingleTypeCellFormTableView<T: TTTableViewCell>: TTTableView {
    let items = BehaviorRelay<[TTTableViewCellViewModel]>.init(value: [])
    var selectedItem = BehaviorRelay<TTTableViewCellViewModel?>.init(value: nil)

    /**
     想达到的效果，我只关心传进去的Cell,和CellViewModel,不用去关心数据源的变更
     */

    override func makeUI() {
        super.makeUI()
        register(T.self, forCellReuseIdentifier: "\(T.self)")
    }

    override func bindViewModel() {
        super.bindViewModel()
        // 绑定数据源
        items.bind(to: self.rx.items(cellIdentifier: "\(T.self)", cellType: T.self)) {
            (index, item, cell) in
            cell.bind(to: item)

            // 选中状态变更
            if item.isSelected.value {
                self.selectRow(
                    at: .init(row: index, section: 0), animated: false, scrollPosition: .none)
            }
        }.disposed(by: rx.disposeBag)

        // 模型选中
        self.rx.modelSelected(TTTableViewCellViewModel.self).subscribe(onNext: {
            [weak self] (item) in guard self != nil else { return }
            self?.selectedItem.accept(item)
            item.isSelected.accept(true)
        }).disposed(by: rx.disposeBag)

        // 模型反选
        self.rx.modelDeselected(TTTableViewCellViewModel.self).subscribe(onNext: {
            [weak self] (item) in guard self != nil else { return }
            item.isSelected.accept(false)
        }).disposed(by: rx.disposeBag)
    }
}
