//
//  ViewModel.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/14.
//

import Foundation
//import Kingfisher

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
   var page = 0
   var data = [HandyJSON]()
   override init() {
        super.init()
        setupViewModel()
    }
    
    func setupViewModel() {
        
    }
//
//    deinit {
//        logDebug("\(type(of: self)): Deinited")
//        logResourcesCount()
//    }
}
