//
//  MyProfileScreeningConditionVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/7.
//

import UIKit



class MyProfileScreeningConditionModel: TTTableViewStaticListModel {
    var oneLineData = [String]()
    var twoLineData = [String]()
    
    var secondLevelData = [[String]]()
    var workData = [MyProfileDetailWorkInfoModel]()
    var isEmpty: Bool {
        return subContent.isEmpty
    }
}


class MyProfileScreeningConditionViewModel: NSObject {
    var data = [MyProfileScreeningConditionModel]()
    
    override init() {
        super.init()
        fetchData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData() {
        let model1 =  MyProfileScreeningConditionModel.init()
        model1.mainContent = "他的年龄"
        model1.subContent = "21-29岁"
        model1.iconName = "Profile_screeing_age"
        model1.type = 0
        for age in 18...60 {
            model1.oneLineData.append("\(age)岁")
            model1.twoLineData.append("\(age)岁")
        }
        
        
        let model2 =  MyProfileScreeningConditionModel.init()
        model2.mainContent = "他的当前所在地"
        model2.subContent = "上海"
        model2.type = 1
        model2.iconName = "Profile_screeing_location"
        model2.oneLineData = ["上海"]
        
        let model3 =  MyProfileScreeningConditionModel.init()
        model3.mainContent = "他的老家"
        model3.subContent = "上海"
        model3.type = 2
        model3.iconName = "Profile_screeing_hometown"
        model2.oneLineData = ["上海"]
      
        data = [
            model1,model2,model3
        ]
    }
}


//MARK: - 条件筛选控制器
class MyProfileScreeningConditionVC: ViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    let vm = MyProfileScreeningConditionViewModel()
    
    // 静态列表
    var list = TTStaticList()
    
    // tips
    var tips = TTButton.init(text: "填写完后优先推荐符合条件用户", textColor: rgba(153, 153, 153, 1), font: .regular(13), iconImage: R.image.profile_screeing_tips(), type: .iconOnTheLeft, intervalBetweenIconAndText: 0) {
        
    }
    
    // 升降板对象
    var elevator: TTElevatorView<UIView>?
    
    lazy var picker: TTPicker = {
        let  picker = TTPicker(segmentLineWidth: SCREEN_W)
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: ver(160))
        picker.backgroundColor = .white
        return picker
    }()
    
    // 当前选中模型,点击完确定后更改当前模型数据
    var currentModel: MyProfileScreeningConditionModel!
    
    // picker当前选中的Index
    var pickerIndexPath = IndexPath.init(row: 0, section: 0)

    // 保存按钮
    var saveButton = UIButton.button(title: "保存", titleColor: .white, font: .regular(16),backGroundColor: .mainStyleColor, cornerRadius: 24)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatItem()
        addSubview(list)
        addSubview(tips)
        addSubview(saveButton)
        
        
        // layout
        list.snp.makeConstraints { (make) in
            make.top.equalTo(inset)
            make.left.right.equalToSuperview()
            make.height.equalTo(88 * 3 + 12 * 3)
        }

        
        tips.snp.makeConstraints { (make) in
            make.right.equalTo(-inset)
            make.top.equalTo(list.snp.bottom).offset(0)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tips.snp.bottom).offset(ver(36))
            make.size.equalTo(CGSize.init(width: 169, height: 48))
        }
        

        list.isScrollEnabled = false
        title = "筛选条件"
        
        // rx
        saveButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            // 保存事件
            
            
        }).disposed(by: rx.disposeBag)
        
    }
    
    func creatItem() {
        var items = [TTMyProfieDetailListHeaderItem]()
        for index in 0..<3 {
            let model  = vm.data[index]
            let item = TTMyProfieDetailListHeaderItem()
            item.mainLabel.text = model.mainContent
            item.leftImageView.image = .name(model.iconName)
            item.subLabel.text = model.subContent
            items.append(item)
            
            // 点击编辑
            item.rightImageView.rx.tap().subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                self.showPicker(model: model)
            }).disposed(by: rx.disposeBag)
        }
        
        list.appendItems(items: items)
    
        // 反选设置
//        list.appendItems(items: items)
//        let selectedItem = Observable.from(items.map{ item in item.backGroundView.rx.controlEvent(.touchUpInside).map{item}}).merge()
//        for item in items {
//            selectedItem.map{$0 == item}.bind(to: item.backGroundView.rx.isSelected).disposed(by: rx.disposeBag)
//        }
    }
    

    
    //MARK: - 显示picerk
    func showPicker(model: MyProfileScreeningConditionModel) {
        // 赋值标记当前模型
        currentModel = model
        
        // 选中第一行
        picker.selectRow(0, inComponent: 0, animated: false)

        let toolBar = TTPickerToolBar()
        toolBar.rightButton.setTitle("完成", for: .normal)
        toolBar.rightButton.setTitleColor(rgba(254, 64, 61, 1), for: .normal)
        toolBar.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: 50))
        }

    

        // 点击后完成
        toolBar.rightButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self]  in guard let self = self else { return }
            
            // 网络请求完成后
//            switch currentModel.type {
//               case 2:
//
//                default:
//                    break
//            }
            
            
            // 年龄取两列 section为首列,row为副列
            if self.currentModel.type == 0 {
                
            }else {
                // 其他只取row的下标
                
            }
            
//            print(self?.pickerIndexPath)
             
            self.elevator?.dismiss {
                
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
        switch model.type {
        case 0:
            toolBar.title.text = "选择年龄"
        case 1:
            toolBar.title.text = "选择他的当前所在地"
        case 2:
            toolBar.title.text = "选择他的老家"
        default:
            break
        }
                
        // 升降板弹出picker
        elevator = TTElevatorView<UIView>().creat(contentView: pickerBoardView, contentViewSize: CGSize.init(width: SCREEN_W, height: 264))
    }
    
    
    //MARK: - pickerDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 是选择收入或者职业的时候返回两行
        if currentModel.type == 0 {
            return 2
        }else {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 是选择收入或者职业的时候返回两行
        if currentModel.type == 0 {
            if component == 0 {
                return currentModel.oneLineData.count
            }else {
                return currentModel.twoLineData.count
            }
        }else {
            return currentModel.oneLineData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 是选择收入或者职业
        if currentModel.type == 0 {
            if component == 0 {
                return currentModel.oneLineData[row]
            }else {
                return currentModel.twoLineData[row]
            }
        }else {
            return currentModel.oneLineData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        // 7,8行需要联动刷新
        if currentModel.type == 0 {
            if component == 0 {
                // 变更选中行
                pickerIndexPath.section = row
            }else {
                pickerIndexPath.row = row
            }
        }else {
            pickerIndexPath.row = row
        }
    }
}

