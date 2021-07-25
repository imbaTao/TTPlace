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

class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
        configureView()
    }
    
    

    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        let view1 = TestView()
        view1.title = "View1"
        let view2 = TestView()
        view2.title = "View2"
        view1.backgroundColor = .red
        view2.backgroundColor = .green
        
        
        addSubviews([view1,view2])

        view1.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        
        view2.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
        
//        view1.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
//            print("我是view1")
//        }).disposed(by: rx.disposeBag)
   }
}

class TestView: View {
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        
    }
    
    var title = ""
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        print(event?.type.rawValue)
        print(title + "hitTest")
        print(Date().timeIntervalSince1970)
        self.layer.delegate = self
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        print(event?.type.rawValue)
        print(Date().timeIntervalSince1970)
        print(title + "hitPoint")
        return super.point(inside: point, with: event)
    }
    
    override func display(_ layer: CALayer) {
        super.display(layer)
        //
    }
}


class TestButton: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print(event?.type.rawValue)
        print(titleLabel!.text! + "hitTest")
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print(titleLabel!.text! + "hitPoint")
        return super.point(inside: point, with: event)
    }
}

