//
//  TestVC.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/23.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
struct Event: HandyJSON {
    var name = ""
    
}

class TestCellViewModel: TTTableViewCellViewModel {
    let event: Event
    
    
    
    init(with event: Event) {
        self.event = event
        super.init()
        
        mainContent.accept(event.name)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
//    required init() {
//        fatalError("init() has not been implemented")
//    }
    
}

class TestViewModel: TTTableViewViewModel, ViewModelType {
 
    struct Input {
        let selection: Driver<TestCellViewModel>
    }

    // 输出事件
    struct Output {
        // 数据源
        let items: BehaviorRelay<[TestCellViewModel]>
        let testDetail: Driver<Test2ViewModel>
//        let navigationTitle: Driver<String>
//        let imageUrl: Driver<URL?>
       
//        let userSelected: Driver<UserViewModel>
//        let repositorySelected: Driver<RepositoryViewModel>
//        let hidesSegment: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[TestCellViewModel]>(value: [])
        let testDetail = input.selection.map({ (model) -> Test2ViewModel in
            //  let viewModel =  详细跳转事件
            return Test2ViewModel()
        })
        
        return Output(items: elements, testDetail: testDetail)
    }
}

class Test2ViewModel: TTTableViewViewModel {
    
}


private let reuseIdentifier = "TestVCCell"
class TestVCCell: TTTableViewCell {
    override func bind(to viewModel: TTTableViewCellViewModel) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? TestCellViewModel else { return }
        // 释放之前的
        cellDisposeBag = DisposeBag()
        
        
        // cell里将事件跟控件绑定
        leftImageView.rx.tap().map{ _ in
            viewModel.event.name
        }.filterEmpty().bind(to: viewModel.avatarImageUrl).disposed(by: cellDisposeBag)
    }
}


class TestVC: TTTableViewController {
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? TestViewModel else { return }
        
        
        
        
        let input = TestViewModel.Input(selection: tableView.rx.modelSelected(TestCellViewModel.self).asDriver())
        let output = viewModel.transform(input: input)
        
        // 直接绑定tableView
        output.items.asDriver().drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: TestVCCell.self)) {
            tableView,cellViewModel,cell in
            
        }.disposed(by: rx.disposeBag)
        
        
        // 详情点击事件
        output.testDetail.drive(onNext: { [weak self] (viewModel) in
//            self?.navigator.show(segue: .repositoryDetails(viewModel: viewModel), sender: self, transition: .detail)
        }).disposed(by: rx.disposeBag)


    }
}
