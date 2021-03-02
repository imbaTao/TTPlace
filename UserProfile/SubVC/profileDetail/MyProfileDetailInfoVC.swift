////
////  MyProfileDetailInfoVC.swift
////  Yuhun
////
////  Created by Mr.hong on 2020/12/4.
////
//
//import UIKit
//
// 自定义选择器
class MyProfileDetailPicker: TTPicker {
    // 数据源
    var data = [String]()


}

//
//class MyProfileDetailInfoVC: ViewController,UIPickerViewDelegate, UIPickerViewDataSource {
//
//    // 升降板对象
//    var elevator: TTElevatorView<UIView>?
//
//    // 当前选中模型,点击完确定后更改当前模型数据
//    var currentModel: TTMyProfieDetailListModel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = rgba(247, 247, 248, 1)
//
//        let list = TTStaticList()
//        view.addSubview(list)
//        list.snp.makeConstraints { (make) in
//            make.left.equalTo(0)
//                make.top.equalTo(ver(12))
//                make.width.equalTo(SCREEN_W)
//                make.height.equalToSuperview()
//        }
//
//
//        let headerItem = TTMyProfieDetailListHeaderItem()
//        headerItem.mainLabel.text = "头像"
//        headerItem.subLabel.text = "请上传看得到本人人脸的头像"
//        headerItem.avatar.image = .name("TTTest")
//        headerItem.itemclick = {
//            // 点击头像事件
//        }
//
//        let nickNameItem = TTMyProfieNormalItem()
//        nickNameItem.rightImageView.isHidden = true
//        nickNameItem.mainLabel.text = "昵称"
//        nickNameItem.segementLine.snp.remakeConstraints { (make) in
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.bottom.equalTo(0)
//            make.height.equalTo(1)
//        }
//
//        nickNameItem.itemclick = {
//            // 点击昵称事件
//        }
//
//
//        let mainContents = ["基本资料","性别","年龄"]
//        let subContents = ["测试文字","测试文字","测试文字"]
//        let dataSource = [
//            ["1","2"],["1","2"],["1","2"],["1","2"]
//        ]
//
//
//        for index in 0..<3 {
//            let itemModel = TTMyProfieDetailListModel()
//            itemModel.mainContent = mainContents[index]
//            itemModel.subContent = subContents[index]
//            itemModel.type  = TTTableViewStaticListRowType(rawValue: index)!
//            itemModel.dataSource = dataSource[index]
//
//
//
//            let sectionItem = TTMyProfieNormalItem()
//            sectionItem.mainLabel.text = itemModel.mainContent
//            sectionItem.subLabel.text = itemModel.subContent
//            sectionItem.itemclick = { [weak self] in
//                // 点击行,弹出picker
//                self?.showPicker(index: index,model: itemModel)
//            }
//
//
//            list.appendItems(items: [
//              sectionItem
//            ])
//        }
//
//        // 插入两个section
//        let detaiInfoSectionItem = TTMyProfieSectionViewItem()
//        detaiInfoSectionItem.mainLabel.text = "详细资料"
//
//        let editInfoSectionItem = TTMyProfieSectionViewItem()
//        editInfoSectionItem.mainLabel.text = "基本资料"
//
//        list.insertItem(item: detaiInfoSectionItem, index: 2)
//        list.insertItem(item: editInfoSectionItem, index: 3)
//
//
//
////        let editInfoSectionItem = TTMyProfieSectionViewItem()
////        editInfoSectionItem.mainLabel.text = "基本资料"
////
////
////        let genderItem = TTMyProfieNormalItem()
////        genderItem.mainLabel.text = "性别"
////        genderItem.subLabel.text = "测试文字"
////        genderItem.itemclick = {
////            // 点击昵称事件
////        }
////
////
////        let ageItem = TTMyProfieNormalItem()
////        ageItem.mainLabel.text = "年龄"
////        ageItem.itemclick = {
////            // 点击昵称事件
////        }
////
////        let seatItem = TTMyProfieNormalItem()
////        seatItem.mainLabel.text = "当前所在地"
////        seatItem.subLabel.text = "测试文字"
////        seatItem.itemclick = {
////            // 点击昵称事件
////        }
////
////        let statureItem = TTMyProfieNormalItem()
////        statureItem.mainLabel.text = "身高"
////        statureItem.subLabel.text = "测试文字"
////        statureItem.itemclick = {
////            // 点击昵称事件
////        }
////
////        let hometownItem = TTMyProfieNormalItem()
////        hometownItem.mainLabel.text = "老家"
////        hometownItem.subLabel.text = "测试文字"
////        hometownItem.itemclick = {
////            // 点击昵称事件
////        }
////
////        let incomeItem = TTMyProfieNormalItem()
////        incomeItem.mainLabel.text = "收入"
////        incomeItem.subLabel.text = "测试文字"
////        incomeItem.itemclick = {
////            // 点击昵称事件
////        }
////
////
////        let detaiInfoSectionItem = TTMyProfieSectionViewItem()
////        detaiInfoSectionItem.mainLabel.text = "详细资料"
////
////
////        let workItem = TTMyProfieNormalItem()
////        workItem.mainLabel.text = "职业"
////        workItem.subLabel.text = "测试文字"
////        workItem.itemclick = {
////            // 点击昵称事件
////        }
////
////        let marriageItem = TTMyProfieNormalItem()
////        marriageItem.mainLabel.text = "婚姻情况"
////        marriageItem.subLabel.text = "测试文字"
////        marriageItem.itemclick = {
////            // 点击昵称事件
////        }
////
////
////        let childrenItem = TTMyProfieNormalItem()
////        childrenItem.mainLabel.text = "有无孩子"
////        childrenItem.subLabel.text = "测试文字"
////        childrenItem.itemclick = {
////            // 点击昵称事件
////        }
////
////
////        let houseItem = TTMyProfieNormalItem()
////        houseItem.mainLabel.text = "住房情况"
////        houseItem.subLabel.text = "测试文字"
////        houseItem.itemclick = {
////            // 点击昵称事件
////        }
////
////        let carItem = TTMyProfieNormalItem()
////        carItem.mainLabel.text = "买车情况"
////        carItem.subLabel.text = "测试文字"
////        carItem.itemclick = {
////            // 点击昵称事件
////        }
////
////        let carItem1 = TTMyProfieNormalItem()
////        carItem1.mainLabel.text = "买车情况"
////        carItem1.subLabel.text = "测试文字"
////        carItem1.itemclick = {
////            // 点击昵称事件
////        }
////
////
////        let carItem2 = TTMyProfieNormalItem()
////        carItem2.mainLabel.text = "买车情况"
////        carItem2.subLabel.text = "测试文字"
////        carItem2.itemclick = {
////            // 点击昵称事件
////        }
////
////        let carItem3 = TTMyProfieNormalItem()
////        carItem3.mainLabel.text = "买车情况"
////        carItem3.subLabel.text = "测试文字"
////        carItem3.itemclick = {
////            // 点击昵称事件
////        }
////
////        let carItem4 = TTMyProfieNormalItem()
////        carItem4.mainLabel.text = "买车情况"
////        carItem4.subLabel.text = "测试文字"
////        carItem4.itemclick = {
////            // 点击昵称事件
////        }
////
////        let carItem5 = TTMyProfieNormalItem()
////        carItem5.mainLabel.text = "买车情况"
////        carItem5.subLabel.text = "测试文字"
////        carItem5.itemclick = {
////            // 点击昵称事件
////        }
////
////        let carItem6 = TTMyProfieNormalItem()
////        carItem6.mainLabel.text = "买车情况"
////        carItem6.subLabel.text = "测试文字"
////        carItem6.itemclick = {
////            // 点击昵称事件
////        }
//
//
//        // 添加item
////        list.appendItems(items: [
////            headerItem,
////            nickNameItem,
////            editInfoSectionItem,
////            genderItem,
////            ageItem,
////            seatItem,
////            statureItem,
////            hometownItem,
////            incomeItem,
////            detaiInfoSectionItem,
////            workItem,
////            marriageItem,
////            childrenItem,
////            houseItem,
////            carItem
////        ])
//
//    }
//
//
//
//

//}
//
//
//
//
//// item数据模型
//class TTMyProfieDetailListModel: TTTableViewStaticListModel {
//    var dataSource = [Any]()
//}
//
//
////MARK: - 自定义item
//class TTMyProfieDetailListHeaderItem: TTStaticListSectionItem {
//    override func setupItem() {
//        super.setupItem()
//
//        self.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize.init(width: SCREEN_W, height: ver(66)))
//        }
//
//        addSubviews([mainLabel,subLabel,avatar,segementLine])
//
//        // layout
//        mainLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(hor(11))
//            make.top.equalTo(ver(13))
//        }
//
//        subLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(mainLabel)
//            make.bottom.equalTo(segementLine.snp.top).offset(ver(-14))
//        }
//
//        avatar.snp.makeConstraints { (make) in
//            make.right.equalTo(hor(-12))
//            make.size.equalTo(ttSize(48))
//            make.centerY.equalToSuperview()
//        }
//
//        segementLine.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview()
//            make.height.equalTo(1)
//            make.left.equalTo(mainLabel)
//            make.right.equalTo(avatar)
//        }
//
//        // config
//        mainLabel.font = .medium(14)
//        mainLabel.textColor = .mainTextColor
//
//        subLabel.font = .regular(13)
//        subLabel.textColor = .mainTextColor2
//
//        segementLine.backgroundColor = rgba(238, 238, 238, 1)
//    }
//}
//
//
//class TTMyProfieNormalItem: TTStaticListSectionItem {
//
//    override func setupItem() {
//        super.setupItem()
//        self.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize.init(width: SCREEN_W, height: ver(49)))
//        }
//
//        addSubviews([mainLabel,subLabel,rightImageView,segementLine])
//
//        // layout
//        mainLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(hor(11))
//            make.centerY.equalToSuperview()
//        }
//
//
//        rightImageView.snp.makeConstraints { (make) in
//            make.right.equalTo(hor(-12))
//            make.centerY.equalToSuperview()
//            make.size.equalTo(ttSize(13))
//        }
//
//        subLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(rightImageView.snp.left).offset(-hor(5))
//            make.centerY.equalToSuperview()
//        }
//
//        segementLine.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview()
//            make.height.equalTo(1)
//            make.left.equalTo(mainLabel)
//            make.right.equalTo(rightImageView)
//        }
//
//
//
//
//        // config
//        mainLabel.font = .medium(14)
//        mainLabel.textColor = .mainTextColor
//
//        subLabel.font = .regular(14)
//        subLabel.textColor = .mainTextColor2
//
//        segementLine.backgroundColor = rgba(238, 238, 238, 1)
//
//        rightImageView.image = .testImage()
//    }
//}
//
//
//class TTMyProfieSectionViewItem: TTStaticListSectionItem {
//    override func setupItem() {
//        super.setupItem()
//        self.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize.init(width: SCREEN_W, height: ver(43)))
//        }
//
//        addSubview(mainLabel)
//        mainLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(hor(12))
//            make.centerY.equalToSuperview()
//        }
//
//        mainLabel.textColor =  rgba(153, 153, 153, 1)
//        mainLabel.font = .regular(14)
//        backgroundColor = .clear
//    }
//}
//
//
//
//


//
//  MyVipVC.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/1.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

class MyProfileDetailInfoVC: TTTableViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    let vm = MyProfileDetailInfoViewModel()
    
    // 升降板对象
    var elevator: TTElevatorView<UIView>?

    // 当前选中模型,点击完确定后更改当前模型数据
    var currentModel: MyProfileDetailInfoModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人资料"

    }
    
    
    override func makeUI() {
        super.makeUI()

        tableView = TTTableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellWithClass: MyProfileDetailInfoCell.self)
        tableView.register(cellWithClass: MyProfileDetailAvatarCell.self)
//        tableView.bounces = false
        contentView.addSubview(tableView)
        
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }

        backGroundImageView.snp.remakeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(backGroundImageView.snp.width).multipliedBy(281.0 / 375)
        }
        
        // config
//        view.addSubview(backGroundImageView)
//        view.sendSubviewToBack(backGroundImageView)
//        backGroundImageView.contentMode = .scaleAspectFit
//        backGroundImageView.image = R.image.profile_vip_background()

//        backGroundImageView.snp.remakeConstraints { (make) in
//            make.left.right.top.equalToSuperview()
//        }
        
        
        view.backgroundColor = rgba(247, 247, 248, 1)
    }
    
    
    
    
    //MARK: - 显示picerk
    func showPicker(indexPath: IndexPath,model: MyProfileDetailInfoModel) {
        // 赋值标记当前模型
//        currentModel = model

        let  picker = TTPicker(segmentLineWidth: SCREEN_W)
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: ver(160))
        picker.backgroundColor = .white


        let toolBar = TTPickerToolBar()
        toolBar.rightButton.setTitle("完成", for: .normal)
        toolBar.rightButton.setTitleColor(rgba(254, 64, 61, 1), for: .normal)
        toolBar.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: 50))
        }

    

        // 点击后完成
        toolBar.rightButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            self?.elevator?.dismiss {

            }
        }).disposed(by: rx.disposeBag)


        let pickerBoardView = UIStackView()
        pickerBoardView.axis = .vertical
        pickerBoardView.distribution = .fill
        pickerBoardView.addArrangedSubviews([toolBar,picker])

        view.addSubview(pickerBoardView)
        pickerBoardView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(0)
        }

        
        
        
        
        // config
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            break
        case 1:
            switch row {
            case 0:
                toolBar.title.text = "选择性别"
            case 1:
                toolBar.title.text = "选择年龄"
            case 2:
                return
            case 3:
                toolBar.title.text = "选择身高"
            case 4:
                toolBar.title.text = "选择老家"
            case 5:
                toolBar.title.text = "选择收入"
            default:
                break
            }
        case 2:
            switch row {
            case 0:
                toolBar.title.text = "选择职业"
            case 1:
                toolBar.title.text = "婚姻状况"
            case 2:
                toolBar.title.text = "有无孩子"
            case 3:
                toolBar.title.text = "住房情况"
            case 4:
                toolBar.title.text = "买车情况"
            default:
                break
            }
        default:
            break
        }
        


        // 升降板弹出picker
        elevator = TTElevatorView<UIView>().creat(contentView: pickerBoardView, contentViewSize: CGSize.init(width: SCREEN_W, height: 264))
    }


    //MARK: - pickerDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)行"
    }

    
    // TableViewDeleagte
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        let model = vm.data[section][row]
        
        switch section {
        case 0:
            if row == 0 {
                // 头像
            }else {
                // 跳转昵称
                navigationController?.pushViewController(MyProfileEditNickNameVC())
            }
        case 1:
            switch row {
            case 0:
                print("")
            case 1:
                print("")
            case 2:
                print("")
            default:
                break
            }
            
            
            if row != 1 {
                showPicker(indexPath: indexPath, model: model)
            }
        case 2:
            switch row {
            case 0:
                print("")
            case 1:
                print("")
            case 2:
                print("")
            default:
                break
            }
            
            showPicker(indexPath: indexPath, model: model)
        default:
            break
        }
    }
    
    // dataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 6
        case 2:
            return 5
        default:
            break
        }
        return 0
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MyProfileDetailInfoCell.self)
        
        let section = indexPath.section
        let row = indexPath.row
        
        
        let sectionModel = vm.data[section]
        let model = sectionModel[row]

        cell.mainLabel.text = model.mainContent
        cell.subLabel.text = model.subContent
    
        switch section {
        case 0:
            if row == 0 {
                let avatarCell = tableView.dequeueReusableCell(withClass: MyProfileDetailAvatarCell.self)
//                avatarCell.avatar.netImage("")
                avatarCell.mainLabel.text = model.mainContent
                avatarCell.subLabel.text = model.subContent
                return avatarCell
            }else {
                cell.lastCellReLayoutSegmentLine()
            }
        case 1:
            if row == 5 {
                cell.lastCellReLayoutSegmentLine()
            }
            
        case 2:
            if row == 4 {
                cell.lastCellReLayoutSegmentLine()
            }
   
        default:
            break
        }
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 67
        }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = UIView.color(rgba(247, 247, 248, 1))
            view.frame = .init(x: 0, y: 0, width: SCREEN_W, height: inset)
            return view
        case 1:
            let container = View()
            let label = UILabel.regular(size: 14, textColor: rgba(153, 153, 153, 1), text: "基本资料", alignment: .left)
            container.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.left.equalTo(inset)
                make.centerY.equalToSuperview()
            }
            container.backgroundColor = .clear
            container.frame = .init(x: 0, y: 0, width: SCREEN_W, height: 43)
            return container
        case 2:
            let container = View()
            let label = UILabel.regular(size: 14, textColor: rgba(153, 153, 153, 1), text: "详细资料", alignment: .left)
            container.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.left.equalTo(inset)
                make.centerY.equalToSuperview()
            }
            container.backgroundColor = .clear
            container.frame = .init(x: 0, y: 0, width: SCREEN_W, height: 43)
            return container
        default:
            break
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return inset
        }
        return 43
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    

}








