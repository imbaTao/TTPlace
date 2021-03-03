//
//  MyProfileViewController.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/3.
//

import UIKit
import RxSwift
import Kingfisher

class MyProfileViewController: TTTableViewController {
    let vm = ProfileViewModel()
    let header = ProfileHeader.init(model: Profile())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configBarTranslucence(value: true)
        hiddenLeftItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        injected()
    }
    
    // dataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 4
        default:
            break
        }
        
        return 0
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let tTableView = tableView as! TTTableView
        // vip 红包组
        if section == 0 {
            if row == 0 {
                // Vip行
                let cell = tTableView.dequeueReusableCell(withClass: MyProfileVipCell.self)
                cell.setModelData()
                cell.checkButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                    // 跳转vip详情行
                }).disposed(by: rx.disposeBag)
                
                
                
                return cell
            }else {
                let cell = tTableView.dequeueReusableCell(withClass: MyProfileWalletCell.self)
                return cell
            }
        }else {
            let cell = tTableView.dequeueReusableCell(withIdentifier: "MyProfileCell") as!  MyProfileCell
            let model = vm.data[row]
            cell.mainLabel.text = model.mainContent
            cell.subLabel.text = model.subContent
            
            // 如果是第三行,显示自定义view
            switch model.type {
            case 0:
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    cell.roundCorners([.topLeft,.topRight], radius: 10)
                }
            case 2:
                cell.verifyView.isHidden = false
                cell.itemClickBlock = { [weak self] index in
                    print("点击了了 第\(index + 1)个")
                }
            case 3:
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    cell.roundCorners([.bottomLeft,.bottomRight], radius: 10)
                }
            default:break
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        switch section{
        case 0:
            if row == 0 {
                return 54
            }else {
                return 78
            }
        case 1:
            return 58
        case 2:
            return 58
        default:
            break
        }
        
        return 300
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
    
    
    @objc func injected () {
        contentView.removeAllSubviews()
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        self.padding = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        tableView = TTTableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.register(cellWithClass: MyProfileCell.self)
        tableView.register(cellWithClass: TTTableViewCell.self)
        tableView.register(cellWithClass: MyProfileVipCell.self)
        tableView.register(cellWithClass: MyProfileWalletCell.self)
        
        
        tableView.bounces = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        
        }
        

      
//        header.backgroundColor = .lightGray
        tableView.tableHeaderView = header
//        tableView.isScrollEnabled = false
        header.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 215)
        
        
        // 设置头像
        header.avatar.image = R.image.profile_default_avatar()
        header.mainTitle.text = "禅悟"
        header.subTitle.text = "ID: \(239475)"
        
        
        
        // config
        backGroundImageView.image = UIImage.gradientImage(startPoint: CGPoint(x: 0.5, y: 0), endPoint:  CGPoint(x: 0.5, y: 1), colors: [rgba(238, 232, 255, 1),rgba(247, 247, 248, 1)], size: ttScreenSize())!
        
        // 选中item
        header.addPhotoBanner.selectedItem = { [weak self] (model,cell) in guard let self = self else { return }
            
            
            let photoInfoVC = MyProfilePhotoPreViewVC()
            self.navigationController?.pushViewController(photoInfoVC)
            photoInfoVC.backActionBlock = { [weak self] (images,allCount) in guard let self = self else { return }
                self.header.addPhotoBanner.reload(images)
                
                // 遍历最一个
                for index in 0..<self.header.addPhotoBanner.arrangedSubviews.count {
                    // 是最后一个
                    if index == 2 && allCount > 3 {
                        let countLable = UILabel.regular(size: 12, textColor: .white, text: "+\(allCount - 3)", alignment: .center)
                        countLable.backgroundColor = rgba(0, 0, 0, 0.5)
                        countLable.isUserInteractionEnabled = false
                        cell.extendView.addSubview(countLable)
                        countLable.snp.makeConstraints { (make) in
                            make.edges.equalToSuperview()
                        }
                        cell.extendView.isHidden = false
                    }else {
                        cell.extendView.isHidden = true
                    }
                }
            }
        }
        
        
        header.addPhotoBanner.renderItem = { [weak self] (model,cell) in guard let self = self else { return }
            cell.cornerRadius = 2
        }
        
        
    }
}








