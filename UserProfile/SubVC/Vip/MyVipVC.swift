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

class MyVipVC: TTTableViewController {
    let vm = MyVipViewModel()
    let header = MyVipHeader()
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configBarTranslucence(value: true)
        hiddenLeftItem()
        padding = .init(top: 0, left: inset, bottom: inset, right: inset)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的会员"
        configNavigationBar(barColor: .clear, titleColr: .white, font: .medium(18))
    }
    
    
    
    override func makeUI() {
        super.makeUI()
    
        
        tableView = TTTableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellWithClass: MyVipCell.self)
//        tableView.bounces = false
        
        header.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: ttSize(351, 279).height + 12)
        tableView.tableHeaderView = header
        contentView.addSubview(tableView)
        
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(NavigationBarHeight)
            make.left.right.bottom.equalToSuperview()
        }

        backGroundImageView.snp.remakeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(backGroundImageView.snp.width).multipliedBy(281.0 / 375)
        }
        
        // config
//        view.addSubview(backGroundImageView)
//        view.sendSubviewToBack(backGroundImageView)
//        backGroundImageView.contentMode = .scaleAspectFit
        backGroundImageView.image = R.image.profile_vip_background()

//        backGroundImageView.snp.remakeConstraints { (make) in
//            make.left.right.top.equalToSuperview()
//        }
        
        
        view.backgroundColor = rgba(250, 251, 250, 1)
        
    }
    
    
    // dataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return vm.data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MyVipCell.self)
        let model = vm.data[indexPath.section]
        cell.mainLabel.text = model.mainContent
        cell.subLabel.text = model.subContent
        cell.leftImageView.image = UIImage.name(model.iconName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 60))
            label.config(font: .medium(17), textColor: .mainTextColor, text: "会员特权", backgroundColor: .white, alignment: .center, numberOfline: 1)
//            label.roundCorners([.topLeft,.topRight], radius: 14)
            label.cornerRadius = 14
            return label
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.color(.white)
        view.frame = .init(x: 0, y: 0, width: SCREEN_W, height: ver(283, 136))
        
        if section == vm.data.count - 1 {
            
            // 倒圆角
            rx.methodInvoked(#selector(viewDidLayoutSubviews)).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                view.roundCorners([.bottomLeft,.bottomRight], radius: 14)
            }).disposed(by: rx.disposeBag)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
    

}








