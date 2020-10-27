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
//                self.view.removeAllSubviews()
                let b = HTBadge.init(edge: UIEdgeInsets.init(sameValue: 2))
                         self.view.addSubview(b)
                         b.snp.makeConstraints { (make) in
                             make.center.equalTo(self.view)
                         }
        //      b.contentLable.font = UIFont.regular(30)
                         
              b.changeBadgeNumb(numb: 10)
     
    }
    
//   @objc func injected() {
//
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = ViewController2.init()
        vc.view.backgroundColor = .gray;
        navigationController?.pushViewController(vc, animated: true)
    }
}


