//
//  TTDevice.swift
//  TTNew
//
//  Created by Mr.hong on 2022/3/9.

import Foundation
import UIKit

enum TTDeviceOrientationStatusType {
    case willChange
    case didChange
}

class TTDevice: NSObject {
    static let shared = TTDevice()

    // 导航栏方向
    let orientationDidChangeRelay = BehaviorRelay<UIInterfaceOrientation>.init(value: .portrait)
//    let orientationWillChangeRelay = BehaviorRelay<UIInterfaceOrientation>.init(value: .portrait)

    var isLand: Bool {
        var isLand = false
        switch orientationDidChangeRelay.value {
        case .landscapeLeft, .landscapeRight:
            isLand = true
        default:
            break
        }
        return isLand
    }

    override init() {
        super.init()

        // 监听屏幕即将
//        NotificationCenter.default.rx.notification(
//            UIApplication.willChangeStatusBarOrientationNotification
//        ).subscribe(onNext: { [weak self] (_) in guard let self = self else { return }
//            let orientaion = UIApplication.shared.statusBarOrientation
//            self.orientationWillChangeRelay.accept(orientaion)
//        }).disposed(by: rx.disposeBag)

        
        //首次赋值
        orientationDidChangeRelay.accept(UIApplication.shared.statusBarOrientation)
        
        // 监听屏幕旋转完毕
        NotificationCenter.default.rx.notification(
            UIApplication.didChangeStatusBarOrientationNotification
        ).subscribe(onNext: { [weak self] (_) in guard let self = self else { return }
            let orientaion = UIApplication.shared.statusBarOrientation
            self.orientationDidChangeRelay.accept(orientaion)
        }).disposed(by: rx.disposeBag)
    }
    
    
    // 强制横向旋转
    func forceRotateDevice(_ orientation: UIInterfaceOrientation) {
        // 给个默认设备的方向
        UIDevice.current.setValue(
            orientation.rawValue, forKey: "orientation")
    }
}
