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


class ViewController1: UIViewController,UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
    }
    
    

    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        view.backgroundColor = .gray
        
        
        let button = UIButton.init()
        button.backgroundColor = .red
        button.setImage(UIImage.name("test"), for: .normal)
        button.cornerRadius = 8
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        
        button.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            print("111")
            
//       self.shakeAnimate(view: button, fromY: 0, toY: 0)
            
        }).disposed(by: rx.disposeBag)
   }
}

















//private func get3DTransformation(angle: Double) -> CATransform3D {
//
//var transform = CATransform3DIdentity
//transform.m34 = -1.0 / 500.0
//transform = CATransform3DRotate(transform, CGFloat(angle * Double.pi / 180.0), 0, 1, 0.0)
//
//return transform
//}
//
//private func flipAnimation(view: UIView, completion: @escaping (() -> Void) = {}) {
//
//let angle = 180.0
//view.layer.transform = get3DTransformation(angle: angle)
//
////            .TransitionNone
//UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .transitionCrossDissolve, animations: { () -> Void in
//    view.layer.transform = CATransform3DIdentity
//    }) { (finished) -> Void in
//        completion()
//}
//}
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
