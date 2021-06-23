////
////  TabbarController.swift
////  TTPlace
////
////  Created by Mr.hong on 2020/10/22.
////  Copyright © 2020 Mr.hong. All rights reserved.
////
//
//import Foundation
//import RAMAnimatedTabBarController
//
//enum YuhunTabBarItem: Int {
//    case blindate, message, mine
//
//    private func controller() -> UIViewController {
//        switch self {
//        case .blindate:
//            let vc = BlindDateListVC.init(BlindDateListViewModel())
//            return NavigationController(rootViewController: vc)
//        case .message:
//            let vc = MessageCenterVC()
//            return NavigationController(rootViewController: vc)
//        case .mine:
//            let vc = MyProfileViewController()
//            return NavigationController(rootViewController: vc)
//        }
//    }
//
//
//    func getController() -> UIViewController {
//        let vc = controller()
//        let item = YuhunTabbarItem(title: title, image: image, selectedImage: selectedImage)
//
//        item.textColor = .mainTextColor
//        vc.hiddenLeftItem()
//        item.animation = animation
//        item.badgeColor = rgba(254, 64, 61, 1)
//        item.setBadgeTextAttributes(
//            [NSAttributedString.Key.foregroundColor : UIColor.white,
//             NSAttributedString.Key.font : UIFont.regular(10)
//            ], for: .normal)
//        vc.tabBarItem = item
//
//
//        return vc
//    }
//
//    class YuhunTabbarItem: RAMAnimatedTabBarItem {
//        /// The current badge value
//        open override var badgeValue: String? {
//            get {
//                return badge?.text
//            }
//            set(newValue) {
//                if newValue == nil,newValue?.count == 0 {
//                    badge?.removeFromSuperview()
//                    badge = nil
//                    return
//                }
//
//                if let iconView = iconView, let contanerView = iconView.icon.superview, badge == nil {
//                    badge = YuhunTabbarBadge.init(frame: .init(x: 0, y: 0, width: 16, height: 16))
//                    badge?.addBadgeOnView(contanerView)
//                }
//
//                // <=0就不显示
//                badge?.isHidden = (newValue?.int ?? 0) <= 0
//                badge?.text = newValue
//            }
//        }
//    }
//    
//
//    class YuhunTabbarBadge: RAMBadge {
////        override var intrinsicContentSize: CGSize {
////            return .init(width: 16, height: 16)
////        }
//
//
//
//    }
//
//
//    var image: UIImage? {
//        switch self {
//        case .blindate: return R.image.homeUnselected()
//        case .message: return R.image.messageUnselected()
//        case .mine: return R.image.personUnselected()
//        }
//    }
//
//    var selectedImage: UIImage? {
//        switch self {
//        case .blindate: return R.image.homeSelected()
//        case .message: return R.image.messageSelected()
//        case .mine: return R.image.personSelected()
//        }
//    }
//
//
//
//    var title: String {
//        switch self {
//        case .blindate:
//            return "视频相亲"
//        case .message:
//            return "消息"
//        case .mine:
//            return "我的"
//        }
//    }
//
//    var animation: RAMItemAnimation {
//        var animation: RAMItemAnimation
//        switch self {
//        case .blindate: animation = YuhunTabbarAnimation()
//        case .message: animation = YuhunTabbarAnimation()
//        case .mine: animation = YuhunTabbarAnimation()
//        }
//        return animation
//    }
//
//
//    class YuhunTabbarAnimation: RAMBounceAnimation {
//        // method call when Tab Bar Item is selected
//        override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
//            // add animation
//            super.playAnimation(icon, textLabel: textLabel)
//            icon.isHighlighted = true
//        }
//        // method call when Tab Bar Item is deselected
//        override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
//            // add animation
//            super.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: defaultTextColor, defaultIconColor: defaultTextColor)
//            icon.isHighlighted = false
//        }
//
//        // method call when TabBarController did load
//        override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
//            // set selected state
//            super.selectedState(icon, textLabel: textLabel)
//            icon.isHighlighted = true
//        }
//
//    }
//}
//
//
//
//func fetchTabbarItem(index: Int) -> RAMAnimatedTabBarItem {
//    let tabbarVC = topTabbarVC() as! TabbarController
//    return tabbarVC.animatedItems[index]
//}
//
//
//class TabbarController: RAMAnimatedTabBarController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.changeSelectedColor(.mainStyleColor, iconSelectedColor: .mainStyleColor)
//        }
//
//        bottomLineHeight = 0.5
//        bottomLineColor = rgba(232, 232, 232, 1)
//
//        // 设置不透明
//        tabBar.isTranslucent = false
//        tabBar.backgroundImage = UIImage.init(color: .white, size: tabBar.size)
//    }
//}
