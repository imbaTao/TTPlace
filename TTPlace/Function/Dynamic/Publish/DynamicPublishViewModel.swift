//
//  DynamicPublishViewModel.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/24.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class DynamicPublishViewModel: TTTableViewCellViewModel,ViewModelType {
    
    struct Input {
        let publishTrigger: Driver<()>
        // 照片变更
//        let photoChange: Observable<[TTAddPhotoBannerModel]>
        
//        let pulish: Observable<()>
        
    }
    
    struct Output {
        // 数据源
        let data: BehaviorRelay<[DynamicPublishEditTitleCellViewModel]>
        
        // 照片变更
//        let photoChange: Driver<[TTAddPhotoBannerModel]>
        
        // 文章标题变更
        let articleTitleChange:  Driver<String>
    
        
        let publishComplete: Driver<()>
    }
    
    
    // 转化
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[DynamicPublishEditTitleCellViewModel]>(value: [])
        let title = BehaviorRelay<String>(value: "")
        
        
        
        // 点击按钮，处理事件，然后把sigle传出去
        let sendEvent = input.publishTrigger.asObservable().flatMapLatest{ () -> Observable<()> in
            
//            return provider.rx.request(.publishArticle(content: "123")).filterSuccessfulStatusCodes().subscribe { (response) in
//
//            } onError: { (error) in
//
//            }.disposed(by: rx.disposeBag)

        }.asDriver(onErrorJustReturn: ())
        
        
//        let single = provider.rx.request(.publishArticle(content: "123")).filterSuccessfulStatusCodes()
        
        return Output.init(data: elements,articleTitleChange: title.asDriver(),publishComplete: sendEvent)
    }
    
    
    
    
//    func publishRequest() -> Single<()> {
//        return Single<()>.create {(single) -> Disposable in
//            TTNet.requst(type:.post,api: "/", parameters: ["" : ""]).subscribe {[weak self] (model) in
//                single(.success(()))
//            } onError: { (error) in
//                single(.error(TTNetError("")))
//            }.disposed(by: DisposeBag())
//            return Disposables.create {}
//        }.observeOn(MainScheduler.instance)
//    }
    
}
