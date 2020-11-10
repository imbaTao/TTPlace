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
        
//             let backButton = TTButton.init(text: "返回按钮啊", iconName: "back1", type: .navBarLeftItem, interval: 5) {
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
        
        let alert =  TTAlert.show(maxSize: .zero,title: "标题", message: "内容121231212349012u349017823049812309481902389081341234,内容121231212349012u349017823049812309481902389081341234,内容121231212349012u349017823049812309481902389081341234内容121231212349012u349017823049812309481902389081341234内容121231212349012u349017823049812309481902389081341234内容121231212349012u349017823049812309481902389081341234内容121231212349012u349017823049812309481902389081341234,内容121231212349012u34901782304981230948190238908134123", buttonTitles: ["取消","完成"], click: { (index) in

                      })
//
        alert.mainContentTextView.textAlignment = .left
     
//        showOriginalAlert(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>, buttonTitles: <#T##[String]#>, click: <#T##(Int) -> ()#>)
        
//                showOriginalAlert(title: "标题", message: "内容", preferredStyle: .alert, buttonTitles: ["cancle","sure"]) { (index) in
//                    print( "click the \(index)")
//                }
                
    }
    
    @objc func injected() {
        
        viewDidLoad()
//        if let image = UIImage.init(color: .red) {
//            let imageView = UIImageView.init(image: image)
//                   view.addSubview(imageView)
//                   imageView.snp.makeConstraints { (make) in
//                    make.center.equalToSuperview()
//                    make.size.equalTo(htSize(100))
//            }
//        }

        
//        let backGround = UIView.init()
//        backGround.backgroundColor = .green
//        self.view.addSubview(backGround)
//        backGround.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.size.equalTo(htSize(246, 49))
//        }
//
//        let textField = TTTextFiled.init()
//        textField.backgroundColor = .red
//        textField.text = "我是测试文字"
//        backGround.addSubview(textField)
//           textField.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
////            make.size.equalTo(htSize(100))
//        }
    
//        textField.placeholderLable.text = "我是占位符"
        
        
       
       
    }
    
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let vc = ViewController2.init()
//        vc.view.backgroundColor = .gray;
//        navigationController?.pushViewController(vc, animated: true)
        
        
        
        

       
        
        
        
        
        TTAlert.show(maxSize: .zero,title: "标题", message: "内容", buttonTitles: ["取消","完成"], click: { (index) in
                                
                     })
        
        
//        test()
    }
}


















// 我写的
//class Solution {
//    // 交集
//    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
//        var tempNums = nums1.count > nums2.count ? nums1 : nums2
//
//
//
//        var tempSet = Set<Int>tempNum2
//
//        // 遍历
//        for index in 0..<tempNums.count {
//            let number1 = tempNums[index]
//
//            if tempSet.insert(number2) == false {
//                result.append(number1)
//            }
//        }
//
//        return result
//    }
//}
//
////// 大佬的
////class Solution {
////    func containsDuplicate(_ nums: [Int]) -> Bool {
////        return Set<Int>(nums).count != nums.count
////    }
////}
//
//
//var nums1 =  [Int]()
//var nums2 =  [Int]()
//func test() {
//    nums1 = [1,2,2,1]
//    nums2 = [2,2]
//    print(Solution().intersect(nums1, nums2))
//}



class TTTextFiled: UITextField {
    // 自定义占位文字
    var placeholderLabel = UILabel.regular(size: 12, textColor: rgba(151, 151, 151, 1))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(placeholderLabel)

        
        
        
        
        // 塞
        self.rx.text.subscribe(onNext: { (text) in
            
        }).disposed(by: rx.disposeBag)
    }
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





class TTTextView: UITextView {

}

//
///**
// A type that has Kingfisher extensions.
// */
//public protocol TTCompatible {
//    associatedtype CompatibleType
//    var placeHodlerLable: CompatibleType { get }
//}
//
// extension TTCompatible {
//     var placeHodlerLable: TTLable<Self> {
//        return TTLable(self)
//    }
//}
//
//class TTLable<T>: UILabel {
//    let base: T
//     init(_ base: T) {
//
//        self.base = base
//         super.init(frame: .zero)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//
//




//public final class Kingfisher<Base> {
//    public let base: Base
//    public init(_ base: Base) {
//        self.base = base
//    }
//}
//
///**
// A type that has Kingfisher extensions.
// */
//public protocol KingfisherCompatible {
//    associatedtype CompatibleType
//    var kf: CompatibleType { get }
//}
//
//public extension KingfisherCompatible {
//    public var kf: Kingfisher<Self> {
//        return Kingfisher(self)
//    }
//}
