//
//  SettingViewController.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/3.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation


class SettingViewController: TTTableViewController {
    let logoutButton = UIButton.title(title: "退出登录", titleColor: .mainStyleColor, font: .medium(16))
    let data = [
        "邀请码",
        "平台规则",
        "关于遇婚",
        "版本信息",
        "清理缓存",
        "隐私政策",
        "用户协议",
        "意见反馈",
    ]
    
    
    
    override func makeUI() {
        super.makeUI()
        title = "设置"
        
        tableView = TTTableView.init(style: .grouped)
        tableView.register(cellWithClass: SettingViewCell.self)
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        
        logoutButton.frame = .init(x: 0, y: 0, width: SCREEN_W, height: 48)
        tableView.tableFooterView = logoutButton
        
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // config
        view.backgroundColor = rgba(247, 247, 248, 1)
        logoutButton.backgroundColor = .white
        
        tableView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        // 退出登录点击事件
        logoutButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            print("登出")
        }).disposed(by: rx.disposeBag)
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SettingViewCell.self)
        cell.mainLabel.text = data[indexPath.section]
        
        if indexPath.section == 3 || indexPath.section == 4  {
            if indexPath.section == 3 {
                cell.subLabel.text = "v1.4.1.1"
            }else {
                cell.subLabel.text = "29.02MB"
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = View()
            view.frame = .init(x: 0, y: 0, width: SCREEN_W, height: 12)
            view.backgroundColor = .clear
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return inset
        }
        return 0.0001
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == data.count - 1 {
            let view = View()
            view.frame = .init(x: 0, y: 0, width: SCREEN_W, height: 12)
            view.backgroundColor = .clear
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == data.count - 1 {
            return inset
        }
        return 0.0001
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}


class SettingViewCell: TTTableViewCell {
    override func makeUI() {
        super.makeUI()
        backgroundColor = .white
        addSubviews([mainLabel,subLabel,rightImageView])
        
        mainLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(inset)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(rightImageView.snp.left).offset(-inset)
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-inset)
            make.size.equalTo(9)
        }
        
        
        // config
        mainLabel.config(font: .medium(15), textColor: .mainTextColor)
        subLabel.config(font: .regular(15), textColor: rgba(102, 102, 102, 1))
        rightImageView.image = R.image.ttTest1()
    }
}

