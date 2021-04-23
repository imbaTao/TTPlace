//
//  TTDebubgerViewController.swift
//  TTSwiftLearn
//
//  Created by Mr.hong on 2019/8/22.
//  Copyright © 2019 Mr.hong. All rights reserved.
//

import UIKit



class TTDebubgerViewController: TTViewController {
    override func makeUI() {
        super.makeUI()
    

        
//        IAPHelper.shared.initPayments { (check) in
//
//
//            print(check)
//        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 尝试支付
//        IAPHelper.shared.pay(pID: .pay06)
        
        
        // 恢复事件
//        IAPHelper.shared.restoreAction()
        
    }
}


func TTDEBUG(_ block:(() -> ())?) {
    if TTEnvironmentManager.shared.scene.domainBit == 0 {
        block?()
    }
}
