//
//  MyProfileDetailInfoVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/4.
//

import UIKit

// 自定义选择器
class MyProfileDetailPicker: TTPicker {
    // 数据源
    var data = [String]()
    

}

class MyProfileDetailInfoVC: ViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    // 升降板对象
    var elevator: TTElevatorView<UIView>?
    
    // 当前选中模型,点击完确定后更改当前模型数据
    var currentModel: TTMyProfieDetailListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        view.backgroundColor = rgba(247, 247, 248, 1)
        
        let list = TTStaticList()
    
        
        view.addSubview(list)
        list.snp.makeConstraints { (make) in
            make.left.equalTo(0)
                make.top.equalTo(ver(12))
                make.width.equalTo(SCREEN_W)
                make.height.equalToSuperview()
        }
        

        let headerItem = TTMyProfieDetailListHeaderItem()
        headerItem.mainLabel.text = "头像"
        headerItem.subLabel.text = "请上传看得到本人人脸的头像"
        headerItem.avatar.image = .name("TTTest")
        headerItem.itemclick = {
            // 点击头像事件
        }
        
        let nickNameItem = TTMyProfieNormalItem()
        nickNameItem.rightImageView.isHidden = true
        nickNameItem.mainLabel.text = "昵称"
        nickNameItem.segementLine.snp.remakeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
        nickNameItem.itemclick = {
            // 点击昵称事件
        }
        
        
  
        let mainContents = ["基本资料","性别","年龄"]
        let subContents = ["测试文字","测试文字","测试文字"]
        

        let dataSource = [
            ["1","2"],["1","2"],["1","2"],["1","2"]
        ]
        
        
        for index in 0..<3 {
            let itemModel = TTMyProfieDetailListModel()
            itemModel.mainContent = mainContents[index]
            itemModel.subContent = subContents[index]
            itemModel.type  = TTTableViewStaticListRowType(rawValue: index)!
            itemModel.dataSource = dataSource[index]
            
            
            
            let sectionItem = TTMyProfieNormalItem()
            sectionItem.mainLabel.text = itemModel.mainContent
            sectionItem.subLabel.text = itemModel.subContent
            sectionItem.itemclick = { [weak self] in
                // 点击行,弹出picker
                self?.showPicker(index: index,model: itemModel)
            }
            
            
            list.appendItems(items: [
              sectionItem
            ])
        }
        
        // 插入两个section
        let detaiInfoSectionItem = TTMyProfieSectionViewItem()
        detaiInfoSectionItem.mainLabel.text = "详细资料"
        
        let editInfoSectionItem = TTMyProfieSectionViewItem()
        editInfoSectionItem.mainLabel.text = "基本资料"

        list.insertItem(item: detaiInfoSectionItem, index: 2)
        list.insertItem(item: editInfoSectionItem, index: 3)
    


//        let editInfoSectionItem = TTMyProfieSectionViewItem()
//        editInfoSectionItem.mainLabel.text = "基本资料"
//
//
//        let genderItem = TTMyProfieNormalItem()
//        genderItem.mainLabel.text = "性别"
//        genderItem.subLabel.text = "测试文字"
//        genderItem.itemclick = {
//            // 点击昵称事件
//        }
//
//
//        let ageItem = TTMyProfieNormalItem()
//        ageItem.mainLabel.text = "年龄"
//        ageItem.itemclick = {
//            // 点击昵称事件
//        }
//
//        let seatItem = TTMyProfieNormalItem()
//        seatItem.mainLabel.text = "当前所在地"
//        seatItem.subLabel.text = "测试文字"
//        seatItem.itemclick = {
//            // 点击昵称事件
//        }
//
//        let statureItem = TTMyProfieNormalItem()
//        statureItem.mainLabel.text = "身高"
//        statureItem.subLabel.text = "测试文字"
//        statureItem.itemclick = {
//            // 点击昵称事件
//        }
//
//        let hometownItem = TTMyProfieNormalItem()
//        hometownItem.mainLabel.text = "老家"
//        hometownItem.subLabel.text = "测试文字"
//        hometownItem.itemclick = {
//            // 点击昵称事件
//        }
//
//        let incomeItem = TTMyProfieNormalItem()
//        incomeItem.mainLabel.text = "收入"
//        incomeItem.subLabel.text = "测试文字"
//        incomeItem.itemclick = {
//            // 点击昵称事件
//        }
//
//
//        let detaiInfoSectionItem = TTMyProfieSectionViewItem()
//        detaiInfoSectionItem.mainLabel.text = "详细资料"
//
//
//        let workItem = TTMyProfieNormalItem()
//        workItem.mainLabel.text = "职业"
//        workItem.subLabel.text = "测试文字"
//        workItem.itemclick = {
//            // 点击昵称事件
//        }
//
//        let marriageItem = TTMyProfieNormalItem()
//        marriageItem.mainLabel.text = "婚姻情况"
//        marriageItem.subLabel.text = "测试文字"
//        marriageItem.itemclick = {
//            // 点击昵称事件
//        }
//
//
//        let childrenItem = TTMyProfieNormalItem()
//        childrenItem.mainLabel.text = "有无孩子"
//        childrenItem.subLabel.text = "测试文字"
//        childrenItem.itemclick = {
//            // 点击昵称事件
//        }
//
//
//        let houseItem = TTMyProfieNormalItem()
//        houseItem.mainLabel.text = "住房情况"
//        houseItem.subLabel.text = "测试文字"
//        houseItem.itemclick = {
//            // 点击昵称事件
//        }
//
//        let carItem = TTMyProfieNormalItem()
//        carItem.mainLabel.text = "买车情况"
//        carItem.subLabel.text = "测试文字"
//        carItem.itemclick = {
//            // 点击昵称事件
//        }
//
//        let carItem1 = TTMyProfieNormalItem()
//        carItem1.mainLabel.text = "买车情况"
//        carItem1.subLabel.text = "测试文字"
//        carItem1.itemclick = {
//            // 点击昵称事件
//        }
//
//
//        let carItem2 = TTMyProfieNormalItem()
//        carItem2.mainLabel.text = "买车情况"
//        carItem2.subLabel.text = "测试文字"
//        carItem2.itemclick = {
//            // 点击昵称事件
//        }
//
//        let carItem3 = TTMyProfieNormalItem()
//        carItem3.mainLabel.text = "买车情况"
//        carItem3.subLabel.text = "测试文字"
//        carItem3.itemclick = {
//            // 点击昵称事件
//        }
//
//        let carItem4 = TTMyProfieNormalItem()
//        carItem4.mainLabel.text = "买车情况"
//        carItem4.subLabel.text = "测试文字"
//        carItem4.itemclick = {
//            // 点击昵称事件
//        }
//
//        let carItem5 = TTMyProfieNormalItem()
//        carItem5.mainLabel.text = "买车情况"
//        carItem5.subLabel.text = "测试文字"
//        carItem5.itemclick = {
//            // 点击昵称事件
//        }
//
//        let carItem6 = TTMyProfieNormalItem()
//        carItem6.mainLabel.text = "买车情况"
//        carItem6.subLabel.text = "测试文字"
//        carItem6.itemclick = {
//            // 点击昵称事件
//        }
        
        
        // 添加item
//        list.appendItems(items: [
//            headerItem,
//            nickNameItem,
//            editInfoSectionItem,
//            genderItem,
//            ageItem,
//            seatItem,
//            statureItem,
//            hometownItem,
//            incomeItem,
//            detaiInfoSectionItem,
//            workItem,
//            marriageItem,
//            childrenItem,
//            houseItem,
//            carItem
//        ])
        
    }
    
    

        
    //MARK: - 显示picerk
    func showPicker(index: Int,model: TTMyProfieDetailListModel) {
        // 赋值标记当前模型
        currentModel = model
        
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
        
        toolBar.title.text = "选择收入"
        
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
}




// item数据模型
class TTMyProfieDetailListModel: TTTableViewStaticListModel {
    var dataSource = [Any]()
}


//MARK: - 自定义item
class TTMyProfieDetailListHeaderItem: TTStaticListSectionItem {
    override func setupItem() {
        super.setupItem()
        
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: ver(66)))
        }
        
        addSubviews([mainLabel,subLabel,avatar,segementLine])
        
        // layout
        mainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(hor(11))
            make.top.equalTo(ver(13))
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mainLabel)
            make.bottom.equalTo(segementLine.snp.top).offset(ver(-14))
        }
        
        avatar.snp.makeConstraints { (make) in
            make.right.equalTo(hor(-12))
            make.size.equalTo(ttSize(48))
            make.centerY.equalToSuperview()
        }
        
        segementLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.equalTo(mainLabel)
            make.right.equalTo(avatar)
        }
        
        // config
        mainLabel.font = .medium(14)
        mainLabel.textColor = .mainTextColor
        
        subLabel.font = .regular(13)
        subLabel.textColor = .mainTextColor2
        
        segementLine.backgroundColor = rgba(238, 238, 238, 1)
    }
}


class TTMyProfieNormalItem: TTStaticListSectionItem {
    
    override func setupItem() {
        super.setupItem()
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: ver(49)))
        }
        
        addSubviews([mainLabel,subLabel,rightImageView,segementLine])
        
        // layout
        mainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(hor(11))
            make.centerY.equalToSuperview()
        }
        
        
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(hor(-12))
            make.centerY.equalToSuperview()
            make.size.equalTo(ttSize(13))
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.left).offset(-hor(5))
            make.centerY.equalToSuperview()
        }
        
        segementLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.equalTo(mainLabel)
            make.right.equalTo(rightImageView)
        }

       
        
        
        // config
        mainLabel.font = .medium(14)
        mainLabel.textColor = .mainTextColor
        
        subLabel.font = .regular(14)
        subLabel.textColor = .mainTextColor2
        
        segementLine.backgroundColor = rgba(238, 238, 238, 1)
        
        rightImageView.image = .testImage()
    }
}


class TTMyProfieSectionViewItem: TTStaticListSectionItem {
    override func setupItem() {
        super.setupItem()
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: ver(43)))
        }
        
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(hor(12))
            make.centerY.equalToSuperview()
        }
        
        mainLabel.textColor =  rgba(153, 153, 153, 1)
        mainLabel.font = .regular(14)
        backgroundColor = .clear
    }
}

