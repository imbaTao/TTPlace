//
//  TTCommonViewModel.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit


//struct TModel<T> {
//    var name = ""
//
//}



class TTViewModel<T>: NSObject {
    
    
    // 子类复写拓展，无需复写init方法
    lazy var data: [T] = {
        var data = [T]()
        return data
    }()
    
    
    override init() {
        super.init()
        vm()
    }
    
    
    func vm() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 可被订阅的data
//    lazy var oData: RxSwift.Observable<Self.Element> = {
//        var oData = RxSwift.Observable<Self.Element>()
//        return oData
//    }()
}


