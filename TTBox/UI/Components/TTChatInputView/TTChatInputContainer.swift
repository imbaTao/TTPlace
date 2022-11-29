//
//  ViewController.swift
//  NewSwiftProjectModul
//
//  Created by Mr.hong on 2020/11/3.
//

import NSObject_Rx
import UIKit

// 这个类主要来承载需要输入的内容面板，自动控制键盘升起调整自身位置
class TTChatInputContainer: UIView {
    // 点击收起蒙层
    let clickDismissMaskView = UIButton()

    // 防点击蒙层
    lazy var unEnabelClickMaskView: UIButton = {
        var unEnabelClickMaskView = UIButton()
        unEnabelClickMaskView.backgroundColor = .clear
        unEnabelClickMaskView.isUserInteractionEnabled = false
        addSubview(unEnabelClickMaskView)
        unEnabelClickMaskView.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
        }).disposed(by: rx.disposeBag)
        return unEnabelClickMaskView
    }()

    weak var chatBar: UIView!
    lazy var container: UIView = {
        var container = UIView.init()
        return container
    }()

    lazy var tableViewContainer: UIView = {
        var tableViewContainer = UIView()
        tableViewContainer.addSubview(chatList)
        chatList.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return tableViewContainer
    }()

    weak var chatList: UITableView!
    weak var chatTextView: UITextView!
    var chatBarHeight: CGFloat {
        return chatBar.height
    }

    // 底部安全区
    var safeArreaBottomWidget = UIView.color(.white)

    init(chatBar: UIView, chatBarHeight: CGFloat, chatList: UITableView, chatTextView: UITextView) {
        self.chatBar = chatBar
        self.chatList = chatList
        self.chatTextView = chatTextView
        super.init(frame: .zero)
        addSubview(container)
        container.addSubviews([
            safeArreaBottomWidget, clickDismissMaskView, tableViewContainer, chatBar,
            unEnabelClickMaskView,
        ])

        // layout
        container.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        tableViewContainer.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.left.right.equalTo(self.safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.left.right.equalToSuperview()
            }
            make.bottom.equalTo(-chatBarHeight - ttSafeBottom())
            make.height.equalTo(SCREEN_H - chatBarHeight - NavigationBarHeight - SafeBottomHeight)
//            make.top.left.right.equalToSuperview()
//            make.bottom.equalTo(chatBar.snp.top)
        }

        clickDismissMaskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        unEnabelClickMaskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        chatBar.snp.makeConstraints { (make) in
            // 为了高度动态化，只能外面设置高度
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeArreaBottomWidget.snp.top)
        }

        safeArreaBottomWidget.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.height.equalTo(ttSafeBottom())
            } else {
                make.height.equalTo(0)
                // Fallback on earlier versions
            }
        }
        // config
        safeArreaBottomWidget.backgroundColor = chatBar.backgroundColor

        bindViewModel(chatTextView)
    }

    var isShowing = false
    func bindViewModel(_ textView: UITextView) {
        // 开始编辑栏
        //        Observable.zip(TTKeyboardManager.shared.isKeyboardShowing,textView.rx.didBeginEditing).subscribe(onNext: {[weak self] (_,isKeyboardShowing) in guard let self = self else { return }
        //            self.showOrHidenKeyboard(true)
        //        }).disposed(by: rx.disposeBag)

        //        // 结束编辑了
        Observable.zip(
            TTKeyboardManager.shared.isKeyboardShowing.skip(1), textView.rx.didEndEditing
        ).subscribe(onNext: { [weak self] (_, isKeyboardShowing) in
            guard let self = self else { return }
            self.checkContentHeight(0)
        }).disposed(by: rx.disposeBag)

        // 实时监听键盘高度
        TTKeyboardManager.shared.keyboardChangingHeight.skip(1).subscribe(onNext: {
            [weak self] (changingHeight) in guard let self = self else { return }
            // 键盘升起，且不是第一响应者就无视高度变更
            if changingHeight > 0 && self.chatTextView.isFirstResponder == false {
                return
            }

            // 如果键盘高度为0，且还是第一响应者也无视高度
            if changingHeight == 0 && self.chatTextView.isFirstResponder {
                return
            }

            self.checkContentHeight(changingHeight)
        }).disposed(by: rx.disposeBag)

        chatList.rx.observe(CGSize.self, "contentSize").skip(1).subscribe(onNext: {
            [weak self] (contentSize) in guard let self = self else { return }
            self.checkContentHeight(TTKeyboardManager.shared.keyboardChangingHeight.value)
        }).disposed(by: rx.disposeBag)

        // 点击蒙层
        clickDismissMaskView.rx.methodInvoked(#selector(touchesBegan(_:with:))).subscribe {
            [weak self] _ in guard let self = self else { return }
            // 点击收起键盘，内容下降
            UIApplication.shared.keyWindow?.endEditing(true)
        }.disposed(by: rx.disposeBag)

        // 键盘为空就隐藏点击收起蒙层
        TTKeyboardManager.shared.keyboardChangingHeight.map { $0 == 0.0 }.bind(
            to: clickDismissMaskView.rx.isHidden
        ).disposed(by: rx.disposeBag)
    }

    // 检测内容高度
    func checkContentHeight(
        _ keboardHeight: CGFloat = TTKeyboardManager.shared.keyboardChangingHeight.value
    ) {
        let isKeyboardShow = TTKeyboardManager.shared.isKeyboardShowing.value

        // 键盘和输入的间距
        let keyboardInputInterval = isKeyboardShow ? 0 : ttSafeBottom()

        // 键盘高度
        let keyBoardHeight: CGFloat = isKeyboardShow ? keboardHeight : 0

        // 输出栏高度
        let chatBarHeight = chatBar.height

        // 可显示的内容是屏幕高 - 导航栏高度 - 列表的Y起点 - 键盘的高度
        let visableHeight = SCREEN_H - NavigationBarHeight - keyBoardHeight - chatBarHeight

        // 内容的高度
        let contentSizeHeight = chatList.contentSize.height

        // 如果内容尺寸高大于了可见高度，证明超过了键盘区间，需要调整，tableView上移
        if contentSizeHeight > visableHeight {
            self.tableViewContainer.snp.updateConstraints { (make) in
                var offSet = contentSizeHeight - visableHeight
                offSet = offSet > keyBoardHeight ? keyBoardHeight : offSet
                make.height.equalTo(SCREEN_H - chatBarHeight - NavigationBarHeight)
                make.bottom.equalTo(-(offSet + chatBarHeight + keyboardInputInterval))

                //                    debugPrint("距离底部距离\(offSet + chatBarHeight)_高度内容是多少\(SCREEN_H - chatBarHeight - NavigationBarHeight)_ 键盘高度是\(keyBoardHeight)")
            }
//            self.chatBar.snp.updateConstraints { make in
//                make.bottom.equalTo(safeArreaBottomWidget.snp.top).offset(keyBoardHeight)
//            }
        } else {
            self.tableViewContainer.snp.updateConstraints { (make) in
                make.height.equalTo(SCREEN_H - chatBarHeight - NavigationBarHeight - SafeBottomHeight)
                // 键盘显示了约束为0
                make.bottom.equalTo(-chatBar.height - SafeBottomHeight)
            }
//            self.chatBar.snp.updateConstraints { make in
//                make.bottom.equalTo(safeArreaBottomWidget.snp.top)
//            }
        }

        // 更新底部楔块
        safeArreaBottomWidget.snp.updateConstraints { (make) in
            if keboardHeight == 0 {
                make.height.equalTo(ttSafeBottom())
            } else {
                make.height.equalTo(keboardHeight)
            }
        }
    }

    func scrollToBottomRow() {
        // 滚动底部
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let lastIndexPath = self.chatList.indexPathForLastRow(inSection: 0) {
                self.chatList.safeScrollToRow(at: lastIndexPath, at: .bottom, animated: true)
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
