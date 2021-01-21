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

//    let provider: YuHunAPI

    var page = 0
    
//    let error = ErrorTracker()
//    let serverError = PublishSubject<Error>()
//    let parsedError = PublishSubject<ApiError>()

   override init() {
        super.init()
        
        

//        serverError.asObservable().map { (error) -> ApiError? in
//            do {
//                let errorResponse = error as? MoyaError
//                if let body = try errorResponse?.response?.mapJSON() as? [String: Any],
//                    let errorResponse = Mapper<ErrorResponse>().map(JSON: body) {
//                    return ApiError.serverError(response: errorResponse)
//                }
//            } catch {
//                print(error)
//            }
//            return nil
//        }.filterNil().bind(to: parsedError).disposed(by: rx.disposeBag)
//
//        parsedError.subscribe(onNext: { (error) in
//            logError("\(error)")
//        }).disposed(by: rx.disposeBag)
        
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
