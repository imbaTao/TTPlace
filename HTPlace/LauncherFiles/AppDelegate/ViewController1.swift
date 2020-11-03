//
//  ViewController1.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
import RXSwift
class ViewController2: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
     
        
        configRightItem(text: "测试", iconName: "back1", type: .navBarRightItem, interval: 5) {
            print("123123123")
        }
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
        
        
//             let backButton = HTButton.init(text: "返回按钮啊", iconName: "back1", type: .navBarLeftItem, interval: 5) {
//                 //点击事件
//                 print("123123213")
//             }
        
//             self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        
//           let lable = YYLabel.regular(size: 12, textColor: .red)
//
//            self.view.addSubview(lable)
//            lable.snp.makeConstraints { (make) in
//                make.center.equalToSuperview()
//                make.height.equalTo(200)
//            }
            
//        let a = 0
        
        
//        let image = UIImage.name("12312313")
//
//             print("")
    }
    
    @objc func injected() {
        
//        if let image = UIImage.init(color: .red) {
//            let imageView = UIImageView.init(image: image)
//                   view.addSubview(imageView)
//                   imageView.snp.makeConstraints { (make) in
//                    make.center.equalToSuperview()
//                    make.size.equalTo(htSize(100))
//            }
//        }
//
//
        
        
        let backGround = UIView.init()
        backGround.backgroundColor = .green
        self.view.addSubview(backGround)
        backGround.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(htSize(246, 49))
        }
        
        let textField = HTTextFiled.init()
        textField.backgroundColor = .red
        textField.text = "我是测试文字"
        backGround.addSubview(textField)
           textField.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
//            make.size.equalTo(htSize(100))
        }
    
//        textField.placeholderLable.text = "我是占位符"
        
     
    }
    
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let vc = ViewController2.init()
//        vc.view.backgroundColor = .gray;
//        navigationController?.pushViewController(vc, animated: true)
        
        
        
        
 
        
        
        
        
        
        
        
//        test()
        
        var array = [1,2,3,4]
        array =  array.map({$0 * $0}).filter { (item) -> Bool in
            return item > 1000
        }
        print(array)
    }
}



extension UITextField {
   
    
    
}


class HTTextFiled: UITextField {
    // 自定义占位文字
    var placeholderLabel = UILabel.regular(size: 12, textColor: rgba(151, 151, 151, 1))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(placeholderLabel)
        
        
//        self.rx.text.map{text}
        
        
        
        
        // 塞
        self.rx.text.subscribe(onNext: { (text) in
            
        }).disposed(by: rx.disposeBag)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HTTextView: UITextView {
   
    
    
}
















// 我写的
class Solution {
     func singleNumber(_ nums: [Int]) -> Int {
        var result: Int = 0
        for number in nums {
           result = result ^ number
        }
        return result
    }
}

//// 大佬的
//class Solution {
//    func containsDuplicate(_ nums: [Int]) -> Bool {
//        return Set<Int>(nums).count != nums.count
//    }
//}


var nums1 =  [Int]()
func test() {
    nums1 = [1,1,22,22,33,33,5,5,7,1341234,54545,456456,1234]
    
    print(Solution().singleNumber(nums1))
}
