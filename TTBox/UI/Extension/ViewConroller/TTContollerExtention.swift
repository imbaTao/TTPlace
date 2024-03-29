//
//  TTExtension_controller.swift
//  TTSwiftUILearn
//
//  Created by hong on 2020/1/17.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit

// 获取控制器
func fetchVCWithClassName(clasName: String) -> UIViewController {
    //1:动态获取命名空间, 没获取到直接返回错误空的控制器
    if let vcClass: AnyClass? = TTClassFromString(classNames: clasName) {

        // Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
        if let typeClass = vcClass as? UIViewController.Type {
            let myVC = typeClass.init()
            return myVC
        } else {
            debugPrint("vcClass不能当做UIViewController")
        }
    } else {
        debugPrint("获取命名空间失败")
    }

    let falilerStr = "获取不到对应类\(clasName)控制器"
    assertionFailure(falilerStr)
    return emptyErrorVC()
}

private func emptyErrorVC() -> UIViewController {
    let errorVC = UIViewController()
    errorVC.title = "控制器类型不存在,请检查类名"
    return errorVC
}

// 导航栏原来的shadowImage
var navigationBarSourceLineImage: UIImage?
extension UIViewController {

    // 关联属性添加自定义底部分割线
    private struct AssociatedKey {
        // tabbar 底部分割线
        static var navigationbarBottomLine: String = "navigationbarBottomLine"

        // 是否是tabbar控制器
        static var isTabbarChildrenVC: String = "isTabbarChildrenVC"
    }

    public var navigationbarBottomLine: UIView {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.navigationbarBottomLine) as? UIView
                ?? UIView()
        }
        set {
            objc_setAssociatedObject(
                self, &AssociatedKey.navigationbarBottomLine, newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // 是否是导航栏上的
    public var isTabbarChildrenVC: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.isTabbarChildrenVC) as? Bool
                ?? false
        }
        set {
            objc_setAssociatedObject(
                self, &AssociatedKey.isTabbarChildrenVC, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    //MARK: - 左侧
    // 设置导航栏左侧Item
    @discardableResult
    func configLeftItem(
        text: String = "", iconName: String,interval: CGFloat = 0, padding: UIEdgeInsets = .zero, clickAction: @escaping () -> Void
    ) -> TTButton {
        // 返回按钮
        let item = TTButton.singleStatus(font: .regular(16), titleColor: .white, title: text, image: UIImage.name(iconName), type: text.count > 0 ? .iconOnTheLeft : .justIcon, interval: interval)
        item.refreshConfig { config in
            config.padding = padding
        }
        item.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            clickAction()
        }).disposed(by: rx.disposeBag)
        // 设置左边item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: item)
        item.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
        
      
        return item
    }

    @discardableResult
    func configLeftItem(
        text: String = "", iconImage: UIImage?, type: TTButtonType = .iconOnTheLeft,
        interval: CGFloat = 0, padding: UIEdgeInsets = .zero, clickAction: @escaping () -> Void
    ) -> TTButton {
        // 返回按钮
        let item = TTButton.singleStatus(font: .regular(16), titleColor: .white, title: text, image: iconImage, type: text.count > 0 ? .iconOnTheLeft : .justIcon, interval: interval)
        item.refreshConfig { config in
            config.padding = padding
        }
        item.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            clickAction()
        }).disposed(by: rx.disposeBag)

        // 设置左边item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: item)
        item.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
        
        return item
    }

    //MARK: - 设置导航栏右侧Item
    func configRightItem(
        text: String, textColor: UIColor = rgba(51, 51, 51, 1), font: UIFont = .regular(15),
        iconName: String = "", interval: CGFloat = 0,
        clickAction: @escaping () -> Void
    ) -> TTButton {
        let item = TTButton.singleStatus(font: .regular(16), titleColor: .white, title: text, image: UIImage.name(iconName), type: text.count > 0 ? .iconOnTheRight : .justIcon, interval: interval)
        item.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            clickAction()
        }).disposed(by: rx.disposeBag)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: item)
        item.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(44)
            make.width.greaterThanOrEqualTo(44)
        }

        return item
    }

    @discardableResult
    func configRightItem(
        text: String = "", iconImage: UIImage?, type: TTButtonType = .iconOnTheRight,
        interval: CGFloat = 0, padding: UIEdgeInsets = .zero, clickAction: @escaping () -> Void
    ) -> TTButton {
        // 返回按钮
        let item = TTButton.singleStatus(font: .regular(16), titleColor: .white, title: text, image: iconImage, type: text.count > 0 ? .iconOnTheRight : .justIcon, interval: interval)
        item.refreshConfig { config in
            config.padding = padding
        }
        item.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            clickAction()
        }).disposed(by: rx.disposeBag)

        // 设置左边item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: item)
        item.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
        
        return item
    }

    // 隐藏左侧导航栏按钮
    func hiddenLeftItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem()]
    }

    @objc func leftItemAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 右侧按钮点击事件
    @objc func rightItemAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    // 隐藏右侧导航栏按钮
    func hiddenRightItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem()]
    }

    //MARK: - 设置导航栏透明
    func configBarTranslucence(value: Bool, keepHeight: Bool = false) {

        // 储存下原来的shadow
        if navigationBarSourceLineImage == nil {
            navigationBarSourceLineImage = self.navigationController?.navigationBar.shadowImage
        }

        // 设置一个透明的背景图
        if value {
            self.navigationController?.navigationBar.setBackgroundImage(
                UIImage.init(
                    color: .clear, size: CGSize(width: SCREEN_W, height: kNavigationBarHeight)),
                for: .default)

            self.navigationController?.navigationBar.shadowImage = UIImage()

            // 取消阴影，不然有影响
            self.hiddenNavigationBarShadow()
        } else {
            //            self.navigationController?.navigationBar.setBackgroundImage(UIImage.qmui_image(with: .red), for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
        }

        self.navigationController?.navigationBar.isTranslucent = !keepHeight
    }

    //MARK: - 设置颜色，标题样式等
    func configNavigationBar(
        barColor: UIColor? = nil, titleColr: UIColor = .black, font: UIFont = .regular(18)
    ) {

        if barColor != nil {
            self.navigationController?.navigationBar.setBackgroundImage(
                UIImage.init(
                    color: barColor!, size: CGSize(width: SCREEN_W, height: kNavigationBarHeight)),
                for: .default)

            if barColor == UIColor.clear {
                configBarTranslucence(value: true)
            }
        }

        // 设置导航栏文字
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: titleColr,
            NSAttributedString.Key.font: font,
        ]
    }

    //MARK: - 设置导航栏阴影
    func configNavigationBarShadow() {
        //1.设置阴影颜色
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor

        //2.设置阴影偏移范围

        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1)

        //3.设置阴影颜色的透明度
        navigationController?.navigationBar.layer.shadowOpacity = 0.2

        //4.设置阴影半径
        navigationController?.navigationBar.layer.shadowRadius = 2

        //5.设置阴影路径
        navigationController?.navigationBar.layer.shadowPath =
            UIBezierPath(rect: navigationController?.navigationBar.bounds ?? CGRect.zero).cgPath
    }

    func addBootomLine() {
        self.navigationbarBottomLine = UIView.init(
            frame: CGRect(x: 0, y: 44 - 0.33, width: SCREEN_W, height: 0.33))
        self.navigationbarBottomLine.backgroundColor = rgba(151, 151, 151, 1)
        navigationController?.navigationBar.addSubview(self.navigationbarBottomLine)
    }

    // 隐藏导航栏底部阴影
    func hiddenNavigationBarShadow() {
        navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navigationController?.navigationBar.layer.shadowOpacity = 0
        navigationController?.navigationBar.layer.shadowRadius = 0
        navigationController?.navigationBar.layer.shadowPath =
            UIBezierPath(rect: navigationController?.navigationBar.bounds ?? CGRect.zero).cgPath

    }

    // 默认是不隐藏导航栏的
    @objc func navigationBarDefaultConfig() {
        //        self.navigationController?.navigationBar.isHidden = false
        //        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.isHidden = false
        //        self.fd_prefersNavigationBarHidden = false;
    }

    // 隐藏导航栏
    @objc func hiddenNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = true

        //        self.fd_prefersNavigationBarHidden = true;
    }

    // 方便添加视图
    func addSubview(_ subView: UIView) {
        self.view.addSubview(subView)
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }

    // 是否禁用手势返回
    //    navigationController?.interactivePopGestureRecognizer?.enabled =  false
}
