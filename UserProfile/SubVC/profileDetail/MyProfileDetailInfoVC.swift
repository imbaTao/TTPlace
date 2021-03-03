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


// 自定义选择器
class MyProfileDetailPicker: TTPicker {
    // 数据源
    var data = [String]()


}


class MyProfileDetailInfoVC: TTTableViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    let vm = MyProfileDetailInfoViewModel()
    
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
    var currentModel: MyProfileDetailInfoModel!
    
    // picker当前选中的Index
    var pickerIndexPath = IndexPath.init(row: 0, section: 0)
    
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
        toolBar.rightButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            
            // 网络请求完成后
//            switch currentModel.type {
//               case 2:
//
//                default:
//                    break
//            }
            
            
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
        // 是选择收入或者职业的时候返回两行
        if currentModel.type == 7 || currentModel.type == 8 {
            return 2
        }else {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 是选择收入或者职业的时候返回两行
        if currentModel.type == 7 || currentModel.type == 8 {
            if currentModel.type == 7 {
                if component == 0 {
                    return currentModel.oneLineData.count
                }else {
                    return currentModel.twoLineData.count
                }
            }else {
                if component == 0 {
                    return currentModel.workData.count
                }else {
                    let mainWorkModel =  currentModel.workData[pickerIndexPath.section]
                    return mainWorkModel.subModels.count
                }
           
            }
        }else {
            return currentModel.oneLineData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 是选择收入或者职业
        switch currentModel.type {
        case 7,8:
            if currentModel.type == 7 {
                if component == 0 {
                    return currentModel.oneLineData[row]
                }else {
                    return currentModel.twoLineData[row]
                }
            }else {
                if component == 0 {
                    let mainWorkModel =  currentModel.workData[row]
                    return mainWorkModel.name
                }else {
                    let mainWorkModel =  currentModel.workData[pickerIndexPath.section]
                    let subWorkModel = mainWorkModel.subModels[row]
                    return subWorkModel.name
                }
            }
        default:
            break
        }
        
        return currentModel.oneLineData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
     
        pickerIndexPath.row = row
        
        
        // 7,8行需要联动刷新
        if currentModel.type == 7 || currentModel.type == 8 {
            
            if component == 0 {
                // 变更选中行
                pickerIndexPath.section = row
                
                
                pickerView.reloadComponent(1)
                pickerView.selectRow(0, inComponent: 1, animated: false)
            }

        }
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
            
            
            if row != 2 {
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
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 43
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








