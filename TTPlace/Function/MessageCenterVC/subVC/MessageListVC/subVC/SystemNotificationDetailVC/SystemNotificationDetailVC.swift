//
//  SystemNotificationDetailVC.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/19.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import UIKit

class SystemNotificationDetailVC: TTTableViewController {
    var data = [YuhunMessageModel]()
    
    init(data: [YuhunMessageModel]) {
        super.init(nil)
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = TTTableView.init(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets.init(top: 16, left: 0, bottom: 16, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 注册cell
        tableView.register(cellWithClass: SystemNotificationDetailCell.self)

        view.backgroundColor = rgba(249, 248, 251, 1)
        
        // 左侧按钮
       let item = configLeftItem(iconName: "back1", type: .iconOnTheLeft, interval: 5) { [weak self]  in guard let self = self else { return }
            self.navigationController?.popViewController()
        }
        item.titleLable.config(font: .medium(18), textColor: rgba(51, 51, 51, 1), text: "系统通知", alignment: .left, numberOfline: 1)
    }
    
    
    // dataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SystemNotificationDetailCell.self)
        let model = self.data[indexPath.section]
        cell.setDataModel(model)
        
        cell.checkButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
          // 点击查看跳转
            
            print("12313")
        }).disposed(by: cell.cellDisposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ver(283, 136)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.color(.clear)
        view.frame = .init(x: 0, y: 0, width: SCREEN_W, height: ver(283, 136))
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return inset
    }
}


class SystemNotificationDetailCell: TTTableViewCell {
    var whiteContainer = UIView.color(.white)
    var checkButton = UIButton.button(title: "点击查看 >", titleColor: rgba(69, 118, 168, 1), font: .regular(13))
    var model = YuhunMessageModel()
    override func makeUI() {
        addSubviews([avatar,whiteContainer])
        whiteContainer.addSubviews([mainLabel,subLabel,secondSubLabel,segementLine,checkButton])
        
        avatar.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(inset)
            make.size.equalTo(56)
        }
        
        whiteContainer.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(inset)
            make.right.equalToSuperview().inset(inset)
            make.height.equalTo(whiteContainer.snp.width).multipliedBy(136 / 283.0)
        }
        
        mainLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(inset)
            make.right.equalTo(secondSubLabel.snp.left).offset(inset)
        }
        
        secondSubLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mainLabel.snp.right).inset(inset)
            make.right.equalTo(-inset)
            make.centerY.equalTo(mainLabel)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mainLabel)
            make.top.equalTo(mainLabel.snp.bottom).offset(1)
            make.right.equalTo(secondSubLabel.snp.right)
        }
        
        segementLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-ver(48))
        }
        
        checkButton.snp.makeConstraints { (make) in
            make.top.equalTo(segementLine.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(inset)
        }
        
        // config
        mainLabel.config(font: .medium(16), textColor: rgba(51, 51, 51, 1), text: "我是昵称", alignment: .left, numberOfline: 1)
        subLabel.config(font: .regular(14), textColor: rgba(102, 102, 102, 1), text: "", alignment: .left, numberOfline: 0)
        secondSubLabel.config(font: .regular(12), textColor: rgba(102, 102, 102, 1), text: "", alignment: .right, numberOfline: 0)
        segementLine.backgroundColor = rgba(249, 248, 251, 1)
        whiteContainer.cornerRadius = 6
        backgroundColor = .clear
    }
    
    // 设置数据源
    func setDataModel(_ model: YuhunMessageModel) {
        self.model = model
        
        avatar.image = R.image.message_zhushouAvatar()
        mainLabel.text = "遇婚小助手"
        subLabel.text = model.content
        secondSubLabel.text = Int(model.sendTime).chatTime()
    }
}
