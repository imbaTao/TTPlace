//
//  ViewController1.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit

class ViewController2: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
     
        
        configRightItem(iconName: "back1")
        title = "1"
        
        configBarTranslucence(value: true)
        
        
//        if let item = self.navigationController?.navigationItem.leftBarButtonItem {
//                print("item 存在")
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        configBarTranslucence(value: false)
    }
}

class ViewController1: BaseViewController {
//    override func viewWillAppear(_ animated: Bool) {
        
        // 用这种方式隐藏tabbar
//        self.navigationController?.navigationBar.isHidden = true;
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = .darkGray
        

        
             let backButton = HTButton.init(text: "返回按钮啊", iconName: "back1", type: .navBarLeftItem, interval: 5) {
                 //点击事件
                 print("123123213")
             }
        
             self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        backButton.backgroundColor = .red
//        self.view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
//            make.center.equalTo(self.view)
            make.width.lessThanOrEqualTo(SCREEN_W * 0.25)
        }
        
//             backButton.snp.makeConstraints { (make) in
//                 make.width.height.equalTo(44)
//             }
        
        
//        baseTabbar()?.fetchItemWithIndex(index: 0).badge.changeBadgeNumb(numb: 123123123)
        
        
        
        
        
        
//        let tuberView = HTTbbarItemTuberView.init(drawSourceRect: CGRect.init(x: 0, y: 0, width:150, height: 150) drawFillColor: .white, drawBorderWidth: 1)
//           self.view.addSubview(tuberView)
//          tuberView.backgroundColor = .clear
//           tuberView.snp.makeConstraints { (make) in
//                make.center.equalToSuperview()
//                make.height.equalTo(150)
//                make.width.equalTo(150)
//           }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = ViewController2.init()
        vc.view.backgroundColor = .gray;
        navigationController?.pushViewController(vc, animated: true)
    }
}


