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


extension UIViewController {
    
    
    
    // 顶部导航
    func topNav() -> UINavigationController? {
       // 如果跟控制器是 UINavigationController
       if (rootWindow().rootViewController?.isKind(of: UINavigationController.self)) != nil {
           if let tabbar: UITabBarController = (rootWindow().rootViewController as? UITabBarController) {
                   let nav =  tabbar.children[tabbar.selectedIndex] as! UINavigationController
                   return nav
               }
          }
          return nil
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

        // 设置一个透明的背景图
        if value {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
        }else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
        }
        
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
    //MARK: - 设置导航栏阴影
    
    //1.设置阴影颜色

    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;

    //2.设置阴影偏移范围

    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 10);

    //3.设置阴影颜色的透明度

    self.navigationController.navigationBar.layer.shadowOpacity = 0.2;

    //4.设置阴影半径

    self.navigationController.navigationBar.layer.shadowRadius = 16;

    //5.设置阴影路径

    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;

    作者：KKWong
    链接：https://www.jianshu.com/p/29c53b512a08
    来源：简书
    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
    
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



