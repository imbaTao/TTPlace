//
//  TTCommonViewModel.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

// 协议
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

class TTViewModel: NSObject {
    let error = ErrorTracker()
    let serverError = PublishSubject<Error>()
    
    override init() {
        super.init()
        setupViewModel()
    }
    
    
    func setupViewModel() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//class ViewModel: NSObject {
//    var provider: EatWhatAPIProtocol = Application.shared.provider!
//    var page = 1
//    let loading = ActivityIndicator()
//    let headerLoading = ActivityIndicator()
//    let footerLoading = ActivityIndicator()
//
//
////    let parsedError = PublishSubject<ApiError>()
//
//    override init() {
//        super.init()
//        setupViewModel()
//    }
//
//    func setupViewModel() {
//
//    }
//
//
//    deinit {
//        logDebug("\(type(of: self)): Deinited")
//        logResourcesCount()
//    }
//}
//


