//
//  Navigator.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/5/18.
//  Copyright © 2018 Khoren Markosyan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol Navigatable {
    var navigator: Navigator! { get set }
}


class Navigator {
    static var shared = Navigator()

    // MARK: - segues list, all app scenes
    enum Scene {
        case tabs
    }

    enum Transition {
        case root(in: UIWindow)
    }

    // MARK: - get a single VC
    func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .tabs:
            // tabbar 模型数量
            let models = [
                TTTabbarViewControllerItemModel(normalImageName: "homeUnselected", selectedImageName: "homeSelected", itemContent: "首页", selected: true,isTuber: false),
                TTTabbarViewControllerItemModel(normalImageName: "homeUnselected", selectedImageName: "homeSelected", itemContent: "相亲资料", selected: false,isTuber: false),
                TTTabbarViewControllerItemModel(normalImageName: "personUnselected", selectedImageName: "personSelected", itemContent: "视频相亲", selected: false,isTuber: false),
                TTTabbarViewControllerItemModel(normalImageName: "personUnselected", selectedImageName: "personSelected", itemContent: "消息", selected: false,isTuber: false),
                TTTabbarViewControllerItemModel(normalImageName: "personUnselected", selectedImageName: "personSelected", itemContent: "我的", selected: false,isTuber: false),
            ]

            // 导航栏结构是，tabbar 持有 5个 navigationController ,然后navigationController 各自持有一个viewController
            let tabbarVC = TabbarController.init(itemModels: models)

            var vcArray = [UIViewController]()

            //  主要的几个控制器
            let homeVC = UIViewController()

            let mineVC = UIViewController()
            mineVC.view.backgroundColor = .red

            // 数组控制vc的添加
            vcArray.append(homeVC)
            vcArray.append(mineVC)

            // 遍历数组，不用每次去写单独导航栏
            let _ = vcArray.map { (vc) in
                let nav = UINavigationController(rootViewController: vc)
                vc.hiddenLeftItem()
                vc.isTabbarChildrenVC = true
                tabbarVC.addChild(nav)
            }
            return tabbarVC
        }
    }

    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController(animated: true)
        }
    }

    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
