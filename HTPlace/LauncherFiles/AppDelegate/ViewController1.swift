//
//  ViewController1.swift
//  HTPlace
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
    
    
    var tableView = HTTableView.init(cellClassNames: ["TTTableViewCell"], style: .grouped)
    
    var lable = UILabel.regular(size: 15, textColor: .black)
//    override func viewWillAppear(_ animated: Bool) {
        
        // 用这种方式隐藏tabbar
//        self.navigationController?.navigationBar.isHidden = true;
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = .darkGray
        
        
        DispatchQueue.once {
            creatList()
        }
    
        
        
//             let tempView1 = UIView.fetchContainerViewWithRadius(radius: 8, color: .red,size: htSize(100,100))
//             self.view.addSubview(tempView1)
//             tempView1.backgroundColor = .red
//             tempView1.snp.makeConstraints { (make) in
//                 make.center.equalToSuperview()
////                 make.size.equalTo(htSize(100))
//             }
//
//
//             self.lable.text = "0"
//             self.view.addSubview(lable)
//             lable.snp.makeConstraints { (make) in
//                make.left.equalTo(tempView1.snp_right).offset(10)
//                 make.centerY.equalTo(tempView1)
//             }
        
        
            
        
        
        
//        let tempView2 = UIView.fetchContainerViewWithRadius(radius: 8, color: .red,size: htSize(50,50))
//                     self.view.addSubview(tempView2)
//                     tempView2.backgroundColor = .red
//                     tempView2.snp.makeConstraints { (make) in
//                        make.left.equalTo(lable.snp.right)
//                        make.centerY.equalTo(tempView1)
//        //                 make.size.equalTo(htSize(100))
//                     }
        
        
        
    }
    
    @objc func injected() {
        

//        let backGround = UIView.init()
//        backGround.backgroundColor = .green
//        self.view.addSubview(backGround)
//        backGround.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.size.equalTo(htSize(246, 49))
//        }
//
//        let textField = HTTextFiled.init()
//        textField.backgroundColor = .red
//        textField.text = "我是测试文字"
//        backGround.addSubview(textField)
//           textField.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
////            make.size.equalTo(htSize(100))
//        }
    
//        textField.placeholderLable.text = "我是占位符"
        
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.reloadData()
        
     
    }
    
    
    
    
    
    
    func creatList() {
        tableView.register(HTClassFromString(classNames: "TTTableViewCell"), forCellReuseIdentifier: "TTTableViewCell")
        
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        Observable.just(models).bind(to: tableView.rx.items){ (tableview, row, element) in
            let cell = tableview.dequeueReusableCell(withIdentifier: "TTTableViewCell") as! TTTableViewCell
//            cell?.accessoryType = .detailDisclosureButton
//            cell.titleLable.text = "\(row): \(element)"
            
            
            cell.userInfo.icon.image = .name(element.iconName)
            cell.userInfo.nickName.text = "倩倩爱搜打飞机奥束带结发你塞得发送佛山反扒水电费"
            
            cell.userInfo.detailInfo.text = "45 | 上海"
            
            cell.content.text = "啊；了解啊老实交代福利卡就少得可怜附件啊；克鲁赛德就发了开机是的分类；卡机水电费啦卡机阿斯利康的激发了；开机是的分类；卡机单身快乐；附件阿里；可点击分类；阿昆达健身房了；卡件大事了；开房间阿里；看到房价阿里说；快递费就"
            
            
            
            
            cell.backgroundColor = randomColor()
            return cell
        }.disposed(by: rx.disposeBag)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.estimatedRowHeight = 50
    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.lable.text == "0" {
            self.lable.text = "1"
        }else {
            self.lable.text = "0"
        }
    }
}



struct HTCellModel {
    var iconName = "性别女2"
    var content = ""
}



let models = [HTCellModel(iconName: "it", content: "12312324198374918734098172304981723908471092834908172309471890237489017239087489123412341231232419837491873409817230498172390847109283490817230947189023748901723908748912341234"),HTCellModel(iconName: "性别女2", content: "123213091483290481029348019238409812034"),HTCellModel(iconName: "性别女2", content: "123490823190481209348390128"),HTCellModel(iconName: "性别女2", content: "3453405238509385902359082340985923"),]




class TTUserInfoView: UIView {
    // 头像
    lazy var icon: UIImageView = {
        var icon = UIImageView.empty()
        addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.bottom.equalTo(0)
            make.width.equalTo(icon.snp.height)
        }
        
        
        
        icon.rx.observe(UIImage.self, "image").subscribe(onNext: {[weak self] (newImage) in
            
            
            
            if  icon.size.height != 0.0 {
                 icon.settingCornerRadius(icon.size.height / 2)
            }else {
                self!.layoutIfNeeded()
                 icon.settingCornerRadius(icon.size.height / 2)
            }
            
            print("赋值了")
           
            
             print("高度为\(icon.size.height)")
        }).disposed(by: rx.disposeBag)
        
        return icon
    }()
    
    
    // 昵称
    lazy var nickName: UILabel = {
        var nickName = UILabel.medium(size: 15, textColor: .black)
        addSubview(nickName)
        nickName.snp.makeConstraints { (make) in
            make.top.equalTo(self.icon)
            make.left.equalTo(self.icon.snp.right).offset(10)
            make.right.equalTo(0)
        }
        return nickName
    }()
    
    // 详细信息
    lazy var detailInfo: UILabel = {
        var detailInfo = UILabel.regular(size: 10, textColor: .gray)
        addSubview(detailInfo)
        detailInfo.snp.makeConstraints { (make) in
            make.left.equalTo(self.nickName)
            make.lastBaseline.equalTo(self.icon)
        }
        return detailInfo
    }()
    
    
}


class TTTableViewCell: UITableViewCell {
    // cell 本身是个stackView承载
    
    let stackView = UIStackView()
    
    
    let userInfo = TTUserInfoView()
    
    let content = UILabel.regular(size: 15, textColor: .black)
//    let mImageView = UIImageView.empty()
    
    
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        userInfo.snp.makeConstraints { (make) in
            make.height.equalTo(40)

        }
        
        stackView.addArrangedSubview(userInfo)
        stackView.addArrangedSubview(content)

        
        content.numberOfLines = 0
        content.textAlignment = .left
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}











// 我写的
class Solution {
    // 交集
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
//        let tempNums = nums1.count < nums2.count ? nums1 : nums2
//
//        let tempNum2 = nums1.count < nums2.count ? nums2 : nums1
        
        var result = [Int]()
        
        // 遍历
        
        for a in nums1 {
            for b in nums2 {
//                let number1 = tempNums[index]
//                   let number2 = tempNum2[index]
                
                   if a == b {
                       result.append(b)
                }
            }
        }
        
//        for index in 0..<tempNums.count {
//            let number1 = tempNums[index]
//            let number2 = tempNum2[index]
//
//            if number1 == number2 {
//                result.append(number1)
//            }
//        }
    
        return result
    }
}

//// 大佬的
//class Solution {
//    func containsDuplicate(_ nums: [Int]) -> Bool {
//        return Set<Int>(nums).count != nums.count
//    }
//}


//var nums1 =  [Int]()
//var nums2 =  [Int]()
//func test() {
//    nums1 = [1,2,2,1]
//    nums2 = [2,2]
//    print(Solution().intersect(nums1, nums2))
//}

class HTTextFiled: UITextField {
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





class HTTextView: UITextView {

}

//
///**
// A type that has Kingfisher extensions.
// */
//public protocol HTCompatible {
//    associatedtype CompatibleType
//    var placeHodlerLable: CompatibleType { get }
//}
//
// extension HTCompatible {
//     var placeHodlerLable: HTLable<Self> {
//        return HTLable(self)
//    }
//}
//
//class HTLable<T>: UILabel {
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
