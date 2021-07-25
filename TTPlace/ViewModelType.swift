//
//  ViewModel.swift
//  TTBox
//
//  Created by Mr.hong on 2020/12/14.
//

import Foundation
import RxSwift
import RxCocoa


protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
//    var provider: EatWhatAPIProtocol = Application.shared.provider!
    var page = 1
    
    override init() {
        super.init()
        setupViewModel()
    }
    
    func setupViewModel() {
        
    }


//    deinit {
//        logDebug("\(type(of: self)): Deinited")
//        logResourcesCount()
//    }
}
