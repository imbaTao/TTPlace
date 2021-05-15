//
//  ViewController1.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import Kingfisher
import RxCocoa
import HandyJSON
import SwiftyJSON


class ViewController: TTViewController {
    
}

class TTButton1: UIButton {
    
}



protocol TTAlertProtocal {
    associatedtype T
    
}


class ViewController1: ViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)

     
        
       
//        configureView()

        showAlert(title: "系统坦克", message: "我是标题")
        showOriginalAlert(title: "系统坦克", message: "我是标题") { (index) in
            
        }
    }
    
    
    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        rootWindow().removeSubviews()
        
        
   
    
//        let alert = RoomAlert()
//        alert.backgroundColor = .orange
        
        
    
        
    
   }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alert = RoomAlert()
        alert.backgroudView.backgroundColor = .orange
    }

}


/**
 我想做什么？
 1.定义一个alert基类，子类去继承他，可以直接访问到其他属性就行
 2.content尺寸可以自适应，也可以自行限制
 3.最好应该有个alert栈管理，可以控制取消所有alert
 */



class RoomAlert: TTAlert2 {
  
    
    override func makeUI() {
        super.makeUI()
        title.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        
        subTitle.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(4)
        }
        
        mainButton.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(subTitle.snp.bottom).offset(20)
        }
    
        
        
        mainButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.event.onNext(1)
            print("111")
        }).disposed(by: rx.disposeBag)
        
        // config
        title.text = "我是标题啊"
        subTitle.text = "我是子标题啊"
    }
    
    override func setupConfig() {
        config.defalultMinSize = ttSize(200)
        config.touchHidden = true
        config.showAnimateStyle = .bottom
//        config.showAnimateStyle = .center

    }
}



extension UIView {
    var inset: CGFloat {
        return 12
    }
    
}

extension UIColor {
    // 性别颜色， 男1，女2
    class func genderColor(_ gender: Int = 1) -> UIColor {
        if gender == 1 {
            return rgba(124, 200, 255, 1)
        }else {
            return rgba(255, 127, 182, 1)
        }
    }
    
    // 主要文本颜色
    static var mainStyleColor: UIColor {
        return #colorLiteral(red: 0.5607843137, green: 0.2509803922, blue: 0.9647058824, alpha: 1)
    }
    
    // 主要文本颜色
    static var mainTextColor: UIColor {
        return rgba(51, 51, 51, 1)
    }
    
    // 主要文本颜色2
    static var mainTextColor2: UIColor {
        return rgba(102, 102, 102, 1)
    }
    
    
}
