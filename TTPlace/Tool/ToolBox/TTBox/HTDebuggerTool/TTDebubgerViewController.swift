//
//  TTDebubgerViewController.swift
//  TTSwiftLearn
//
//  Created by Mr.hong on 2019/8/22.
//  Copyright © 2019 Mr.hong. All rights reserved.
//

import UIKit

class TTDebubgerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "测试用控制器"
        self.view.backgroundColor = .red
        let blueView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        blueView.backgroundColor = .green
        view.addSubview(blueView)

    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let tempVC = TTChangePresentToPushTransitionsVC()
//        self.navigationController?.delegate = (tempVC as! UINavigationControllerDelegate)
//        tempVC.title = "临时控制器"
//        self.navigationController?.pushViewController(tempVC, animated: true)
//    }
}

