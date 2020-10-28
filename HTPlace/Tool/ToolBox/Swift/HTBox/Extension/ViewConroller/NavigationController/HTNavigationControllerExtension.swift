//
//  HTNavigationControllerExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/9/2.
//  Copyright © 2020 刘超. All rights reserved.
//

import UIKit


// 导航栏左侧按钮
class HTNavitaionLeftButtonItem: UIView {
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
    func configLeftItem(iconName: String) {
        let backButton = UIButton.iconName("back1")
        configLeftItem(item: backButton)
    }

    // 设置导航栏左侧Item
    func configLeftItem(item: UIButton) {
        item.addTarget(self, action: #selector(leftItemAction(_ :)), for: .touchUpInside)

        // 设置左边item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: item)
        item.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -22, bottom: 0, right: 0)
        item.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
        }
     }

    // 左侧按钮点击事件
    @objc func leftItemAction(_ sender: UIButton) {
         navigationController?.popViewController(animated: true)
    }

    // 隐藏左侧导航栏按钮
    func hiddenLeftItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem()]
    }

    

    //MARK: - 右侧
    func configRightItem(iconName: String) {
        let rightItem = UIButton.iconName("back1")
        configRightItem(item: rightItem)
    }

    // 设置导航栏右侧Item
    func configRightItem(item: UIButton) {
        item.addTarget(self, action: #selector(rightItemAction(_ :)), for: .touchUpInside)

        // 设置右边item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: item)
        item.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -22)
        item.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
        }
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
    func configBarTranslucence(value: Bool) {
        
        // 储存下原来的shadow
        if navigationBarSourceLineImage == nil {
            navigationBarSourceLineImage = self.navigationController?.navigationBar.shadowImage
        }
        
        // 设置一个透明的背景图
        if value {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            
            // 取消阴影，不然有影响
            self.cancleBarShadow()
        }else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.qmui_image(with: .red), for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.backgroundColor = .red
        }
        
        self.navigationController?.navigationBar.isTranslucent = value
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
        self.navigationbarBottomLine = UIView.init(frame: CGRectFlatMake(0, 44 - 0.33, SCREEN_W, 0.33))
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



