//
//  Observable+Logging.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
    func logError(prefix: String = "Error: ") -> Observable<Element> {
        return self.do(
            onNext: nil,
            onError: { (error) in
                debugPrint("\(prefix)\(error)")
            },
            onCompleted: nil,
            onSubscribe: nil,
            onDispose: nil)

    }

    func logServerError(message: String) -> Observable<Element> {
        return self.do(
            onNext: nil,
            onError: { (error) in
                debugPrint("\(message)")
                debugPrint("Error: \(error.localizedDescription). \n")
            },
            onCompleted: nil,
            onSubscribe: nil,
            onDispose: nil)
    }

    func logNext() -> Observable<Element> {
        return self.do(
            onNext: { (element) in
                debugPrint("\(element)")
            },
            onError: nil,
            onCompleted: nil,
            onSubscribe: nil,
            onDispose: nil)

    }
}
