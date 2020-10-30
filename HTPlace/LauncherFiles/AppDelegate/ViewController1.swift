//
//  ViewController1.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
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
            
        
        

    }
    
    @objc func injected() {
        if let image =  UIImage.gradientImage(withColors: [rgba(253, 120, 202, 1),rgba(145, 64, 245, 1)], rect: CGRect.init(x: 0, y: 0, width: hor(156),height: hor(156)),cornerRadius:hor(156 / 2.0),opacity: 1) {
            image.hasAlphaChannel()
            image.byRoundCornerRadius(5)
            
 
            let imageView = UIImageView.init(image: image)
                   view.addSubview(imageView)
                   imageView.snp.makeConstraints { (make) in
                       make.center.equalToSuperview()
            }
        }
        
        
        
       
    }
    
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let vc = ViewController2.init()
//        vc.view.backgroundColor = .gray;
//        navigationController?.pushViewController(vc, animated: true)
        
        
        
        
 
        
        
        
        
        
        
        
//        test()
        
    }
}



// 对lable直接进行扩展,设置可以点击的attribute
//extension UILabel {
//
//}






// 我写的
class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        return Set<Int>(nums).intersection(Set<Int>(nums)).first!
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
    nums1 = [1,1,22,22,33,33,5]
    
    print(Solution().singleNumber(nums1))
}
