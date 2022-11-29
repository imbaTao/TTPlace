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
import Hero

protocol Navigatable {
    var navigator: Navigator! { get set }
}

let navigator = Navigator.default
class Navigator {
    static var `default` = Navigator()

    // MARK: - segues list, all app scenes
    enum Scene {
        case login
        case tabs
    }
    
    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
        

    // MARK: - get a single VC
    private func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .login:
            let nav = NavigationController.init(rootViewController: LoginViewController())
            return nav
        case .tabs:
            // tabbar 模型数量
            let models = [
                TTTabbarViewControllerItemModel(normalImageName: "homeUnselected", selectedImageName: "homeSelected", itemContent: "首页", selected: false,isTuber: false),
                TTTabbarViewControllerItemModel(normalImageName: "homeUnselected", selectedImageName: "homeSelected", itemContent: "相亲资料", selected: false,isTuber: false),
            ]
            // 导航栏结构是，tabbar 持有 5个 navigationController ,然后navigationController 各自持有一个viewController
            let tabbarVC = TabbarController.init(itemModels: models)

            // 控制器数组
            var vcArray = [UIViewController]()

            // 数组控制vc的添加
//            vcArray.append(homeVC)
//            vcArray.append(blindDateInfoVC)
//            vcArray.append(blindDateVideoVC)
//            vcArray.append(massegeCenterVC)
//            vcArray.append(mineVC)
            
            
            // 如果数量不对等
            if vcArray.count != models.count {
                assert(false, "item和vc数量不对等")
            }
            

            // 遍历数组，不用每次去写单独导航栏
            let _ = vcArray.map { (vc) in
                let nav = NavigationController(rootViewController: vc)
                vc.hiddenLeftItem()
                vc.isTabbarChildrenVC = true
                tabbarVC.addChild(nav)
                
            }
            return tabbarVC
        default:
            break
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
    
    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            window.rootViewController = target
//            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
//
//            }, completion: nil)
            return
        case .custom: return
        default: break
        }

        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }

        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }

        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                // push controller to navigation stack
                target.hidesBottomBarWhenPushed = true
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        case .customModal(let type):
            // present modally with custom animation
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                nav.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(nav, animated: true, completion: nil)
            }
        case .modal:
            // present modally
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
    }
}

class NavigationController: UINavigationController {

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return globalStatusBarStyle.value
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        interactivePopGestureRecognizer?.delegate = nil // Enable default iOS back swipe gesture

        if #available(iOS 13.0, *) {
            hero.isEnabled = false
        } else {
            hero.isEnabled = true
        }
        hero.modalAnimationType = .autoReverse(presenting: .fade)
        hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))

        navigationBar.isTranslucent = false
        
//        navigationBar.backIndicatorImage = R.image.icon_navigation_back()
//        navigationBar.backIndicatorTransitionMaskImage = R.image.icon_navigation_back()
//
//        themeService.rx
//            .bind({ $0.secondary }, to: navigationBar.rx.tintColor)
//            .bind({ $0.primaryDark }, to: navigationBar.rx.barTintColor)
//            .bind({ [NSAttributedString.Key.foregroundColor: $0.text] }, to: navigationBar.rx.titleTextAttributes)
//            .disposed(by: rx.disposeBag)
    }
}
