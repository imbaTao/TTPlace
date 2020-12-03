//
//  TTNavigationControllerExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/9/2.
//  Copyright © 2020 刘超. All rights reserved.
//

import UIKit


// 导航栏左侧按钮
class TTNavitaionLeftButtonItem: UIView {
    // 因为平时的按钮需要设置偏移，且位置不对,且点击作用域也太小
    
    // 把按钮包一下
    init(button: UIButton) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
              return objc_getAssociatedObject(self, &AssociatedKey.navigationbarBottomLine) as? UIView ?? UIView()
          }
          set {
              objc_setAssociatedObject(self, &AssociatedKey.navigationbarBottomLine, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
          }
      }
    
    // 是否是导航栏上的
    public var isTabbarChildrenVC: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.isTabbarChildrenVC) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.isTabbarChildrenVC, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    

    
    //MARK: - 左侧
    // 根据图片名直接设置item
    func configLeftItem(iconName: String,clickAction: @escaping ()->()) {
        configLeftItem(text: "", iconName: iconName, type: .navBarRightItem, interval: 0, clickAction: clickAction)
    }
    
    
    // 根据自定义视图设置左侧Item
    func configLeftItem<T: UIView>(customView: T)  {
        let stackView = UIStackView.init(arrangedSubviews: [customView])
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: stackView)
        customView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.greaterThanOrEqualTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
    }

    
    // 设置导航栏左侧Item
    func configLeftItem(text: String,iconName: String, type: TTButtonType,interval: CGFloat,clickAction: @escaping ()->()) {
        // 返回按钮
        let item = TTButton.init(text: text, iconName: iconName, type: .navBarLeftItem, intervalBetweenIconAndText: interval,clickAction: clickAction)
        
        // 设置左边item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: item)
        item.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
    }
    
  //MARK: - 设置导航栏右侧Item
   func configRightItem(text: String,iconName: String, type: TTButtonType,interval: CGFloat,clickAction: @escaping ()->()) {
       let item = TTButton.init(text: text, iconName: iconName, type: .navBarLeftItem, intervalBetweenIconAndText: interval,clickAction: clickAction)
       self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: item)
       item.snp.makeConstraints { (make) in
           make.height.greaterThanOrEqualTo(44)
           make.width.greaterThanOrEqualTo(44)
       }
   }
    
    
    // 设置导航栏右侧Item
    func configRightItem(text: String,clickAction: @escaping ()->()) {
        configRightItem(text: text, iconName: "", type: .navBarRightItem, interval: 0, clickAction: clickAction)
    }
    
    
   // 隐藏左侧导航栏按钮
    func hiddenLeftItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem()]
    }

    // 右侧按钮点击事件
    @objc func rightItemAction(_ sender: UIButton) {
         
    }

    // 隐藏右侧导航栏按钮
    func hiddenRightItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem()]
    }
    
    //MARK: - 设置导航栏透明
    func configBarTranslucence(value: Bool,keepHeight: Bool = false) {
        
        // 储存下原来的shadow
        if navigationBarSourceLineImage == nil {
            navigationBarSourceLineImage = self.navigationController?.navigationBar.shadowImage
        }
        
        // 设置一个透明的背景图
        if value {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(color: .clear, size: CGSize(width: SCREEN_W, height: kNavigationBarHeight)), for: .default)
            
            self.navigationController?.navigationBar.shadowImage = UIImage()

            // 取消阴影，不然有影响
            self.cancleBarShadow()
        }else {
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage.qmui_image(with: .red), for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.backgroundColor = .white
        }
        
  
        self.navigationController?.navigationBar.isTranslucent = !keepHeight
    }
    
    //MARK: - 设置颜色，标题样式等
    func configNavigationBar(barColor: UIColor,titleColr: UIColor = .black,font: UIFont = .regular(18))  {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(color: barColor, size: CGSize(width: SCREEN_W, height: kNavigationBarHeight)), for: .default)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : titleColr,
            NSAttributedString.Key.font : font
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
           navigationController?.navigationBar.layer.shadowPath = UIBezierPath(rect: navigationController?.navigationBar.bounds ?? CGRect.zero).cgPath
      }
    
    
    func addBootomLine() {
        self.navigationbarBottomLine = UIView.init(frame: CGRect(x: 0, y: 44 - 0.33, width: SCREEN_W, height: 0.33))
        self.navigationbarBottomLine.backgroundColor = rgba(151, 151, 151, 1);
        navigationController?.navigationBar.addSubview(self.navigationbarBottomLine)
    }
    
    
    // 取消阴影
    func cancleBarShadow() {
        navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navigationController?.navigationBar.layer.shadowOpacity = 0
        navigationController?.navigationBar.layer.shadowRadius = 0
        navigationController?.navigationBar.layer.shadowPath = UIBezierPath(rect: navigationController?.navigationBar.bounds ?? CGRect.zero).cgPath
        
    }
}

extension UIImageView {
    func removeAllAutoLayout() {
          removeConstraints(constraints)
        for constraint in superview!.constraints {
            
            let item = constraint.firstItem as! UIView
            
              if item == self {
                superview!.removeConstraint(constraint)
              }
          }
      }
}



extension UINavigationController {

}



