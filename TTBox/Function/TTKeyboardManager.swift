//
//  TTKeyboardManager.swift
//  hdd4iPhone
//
//  Created by Mr.hong on 2021/10/22.
//  Copyright © 2022 Q. All rights reserved.
//

import Foundation

class TTKeyboardManager: NSObject {
    static let shared = TTKeyboardManager()

    //  键盘是否正在显示
    var isKeyboardShowing = BehaviorRelay<Bool>.init(value: false)

    // 变更空视图的高度
    var keyboardAnimateInteval: CGFloat = 0.25

    // 收到键盘高度的时候，变更其他面板的约束
    var keyboardHeight: CGFloat = 0

    // 旋转屏幕中的高度
    let keyboardChangingHeight = BehaviorRelay<CGFloat>.init(value: 0.0)

    override init() {
        super.init()
        NotificationCenter.default.rx.notification(
            UIApplication.keyboardWillChangeFrameNotification
        ).distinctUntilChanged().takeUntil(self.rx.deallocated).subscribe(onNext: {
            [weak self] notification in
            guard let self = self else { return }
            // 显示键盘
            if let endBounce = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect,
                endBounce.height > 100,
                let beginBounce = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"]
                    as? CGRect
            {

                // 真正高，
                let realHeight = self.fetchRealKeyboardHeight()
                if realHeight != self.keyboardHeight {
                    self.keyboardHeight = realHeight
                }

                // 收起键盘
                if endBounce.origin.y != SCREEN_W && endBounce.origin.y != SCREEN_H {
                    self.isKeyboardShowing.accept(true)
                    self.keyboardChangingHeight.accept(
                        realHeight < endBounce.height ? realHeight : endBounce.height)
                } else {
                    self.isKeyboardShowing.accept(false)

                    self.keyboardChangingHeight.accept(0)
                }
                //                debugPrint("键盘的end\(endBounce)  begin\(beginBounce)")
            }

        }).disposed(by: rx.disposeBag)

    }

    func fetchRealKeyboardHeight() -> CGFloat {
        let keyboardWindow = UIApplication.shared.windows.last
        let inputView = keyboardWindow?.rootViewController?.view.tkp_findSubview(
            "UIInputSetHostView")
        if let inputView = inputView {

            //            debugPrint("输入视图的Y\(inputView.y)")
            return inputView.height
        }
        return 0
    }

    func dismissKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}

extension UIView {
    func tkp_findSubview(_ name: String?) -> UIView? {
        return tkp_findSubview(name, resursion: false)
    }

    func tkp_findSubview(_ name: String?, resursion: Bool) -> UIView? {
        if let tempClass: AnyClass = NSClassFromString(name ?? "") {
            for subview in subviews {
                subview.isKind(of: tempClass)
                return subview
            }
        }

        if resursion {
            for subview in subviews {
                let tempView = subview.tkp_findSubview(name, resursion: resursion)
                if let tempView = tempView {
                    return tempView
                }
            }
        }

        return nil
    }
}
