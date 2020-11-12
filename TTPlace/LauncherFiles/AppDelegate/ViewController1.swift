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
    
    
    var tableView = TTTableView.init(cellClassNames: ["TTTableViewCell"], style: .grouped)
    
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
        
        
        baseTabbar()?.fetchItemWithIndex(index: 0).badge.changeBadgeNumb(numb: 99)
        
        

        
                let  dic = ["region":"86",
                          "phone": "13067922737",
                        "password": "xiaosage"]
            
        AF.request("http://hl.requjiaoyou.com:8585/user/login", method: .post, parameters: dic, encoder: JSONParameterEncoder.default).responseJSON { (response) in
        
            print("jSon是\(JSON.init(response.data))")
//                switch response.result{
//
//                                   case .success:
//                                       print("jSon是\(response)")
////                                    if let dic:NSDictionary = (response.value as! NSDictionary){
////                                           print("jSon是\(response)")
////                                       }
//                                   case .failure(let error):
//                                       print(error)
//                                   }
//
//
//
//                }
                
            }
            
 
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
//        let textField = TTTextFiled.init()
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
        tableView.register(TTClassFromString(classNames: "TempCell"), forCellReuseIdentifier: "TempCell")
        
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        Observable.just(models).bind(to: tableView.rx.items){ (tableview, row, element) in
            let cell = tableview.dequeueReusableCell(withIdentifier: "TempCell") as! TempCell
//            cell?.accessoryType = .detailDisclosureButton
//            cell.titleLable.text = "\(row): \(element)"
            
            
            cell.userInfo.icon.image = .name(element.iconName)
            cell.userInfo.nickName.text = "倩倩爱搜打飞机奥束带结发你塞得发送佛山反扒水电费"
            
            cell.userInfo.detailInfo.text = "45 | 上海"
            
            
            
            let contentText = NSMutableAttributedString(string: element.content)
            contentText.setLineSpacing(3, range: NSRange.init(location: 0, length: contentText.length))
//            contentText.setKern(NSNumber.init(value: 1), range: NSRange.init(location: 0, length: contentText.length))
//            contentText.setTailIndent(0, range: NSRange.init(location: 0, length: contentText.length))
//            contentText.headIndent = 0
//            contentText.tailIndent = 1000
            contentText.alignment = .justified
            cell.content.attributedText = contentText
            
            cell.backgroundColor = randomColor()
            return cell
        }.disposed(by: rx.disposeBag)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
         tableView.rx.itemSelected.subscribe(onNext: { [weak self] (index) in
            let cell:TempCell  = self!.tableView.cellForRow(at: index)! as! TempCell
            let data = YBIBImageData()
            data.projectiveView = cell.userInfo.icon
            data.thumbImage = cell.userInfo.icon.image
            data.imageName = "it"
            
            
            let browser = YBImageBrowser()
            browser.dataSourceArray = [data]
            browser.currentPage = 0
            browser.show()
            
//              YBImageBrowser *browser = [YBImageBrowser new];
//                // 自定义工具栏
//            //    browser.toolViewHandlers = @[TestToolViewHandler.new];
//                browser.dataSourceArray = datas;
//                browser.currentPage = index;
//                [browser show];
            
            
        //                     print("\(index.row)")
        //        //            self?.showAlert(title: "点击第几行", message: "\(index.row)")
        }).disposed(by: rx.disposeBag)
        
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



let models = [HTCellModel(iconName: "it", content: "      英雄联盟手游终于迎来了大规模测试，这次测试加入了IOS版本，很多没能参加测试的小伙伴也都非常激动，安卓用户可以直接在谷歌商店进行预约下载，但是IOS的玩家由于国内苹果商店并没有上架，所以无法下载，为了能够让更多的玩家体验到英雄联盟手游，下面由我游小编为大家介绍一下英雄联盟手游ios安装教程"),HTCellModel(iconName: "性别女2", content: "英雄联盟手游终于迎来了大规模测试，这次测试加入了IOS版本，很多没能参加测试的小伙伴也都非常激动，安卓用户可以直接在谷歌商店进行预约下载"),HTCellModel(iconName: "性别女2", content: "123490823190481209348390128"),HTCellModel(iconName: "性别女2", content: "英雄联盟手游终于迎来了大规模测试，这次测试加入了IOS版本"),]




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


class TempCell: UITableViewCell {
    // cell 本身是个stackView承载
    
    let stackView = UIStackView()
    
    
    let userInfo = TTUserInfoView()
    
    let content = YYLabel.regular(size: 12, textColor: .black)
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
        
//        content.snp.makeConstraints { (make) in
//            make.width.equalTo(SCREEN_W)
//        }
        
        content.numberOfLines = 0
        content.preferredMaxLayoutWidth = SCREEN_W
        content.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)
//        content.textContainerInset = UIEdgeInsets.zero
        stackView.addArrangedSubview(userInfo)
        stackView.addArrangedSubview(content)
        
        content.textAlignment = .justified
        
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
        
    
        return result
    }
}


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





fileprivate func validateNumber(_ textField: UITextField, range: NSRange, string: String, limit: Int = 11) -> Bool {
    
    guard let text = textField.text else { return false }

    ///拼接了参数string的afterStr
//        let afterStr = text.replacingCharacters(in: text.ext2Range(range)!, with: string)
//        DebugLog(afterStr)
    let afterStr = (text as NSString).replacingCharacters(in: range, with: string)
//    DebugLog(afterStr)
    
    ///限制长度
    if afterStr.count > limit {
        textField.text = (afterStr as NSString).substring(to: limit)
        return false
    }
    
    ///是否都是数字
    let set = CharacterSet(charactersIn: "0123456789").inverted
    let filteredStr = string.components(separatedBy: set).joined(separator: "")
    
    if filteredStr == string {
        return true
    }
    
    return false
}
