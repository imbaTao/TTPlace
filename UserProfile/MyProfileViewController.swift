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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configBarTranslucence(value: true)
        hiddenLeftItem()
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    // dataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let tTableView = tableView as! TTTableView
        // vip 红包组
        if section == 0 {
            if row == 0 {
                // Vip行
                let cell = tTableView.dequeueReusableCell(withIdentifier: "TTTableViewCell")!
                return cell
            }else {
                let cell = tTableView.dequeueReusableCell(withIdentifier: "TTTableViewCell")!
                return cell
            }
        }else {
            let cell = tTableView.dequeueReusableCell(withIdentifier: "MyProfileCell") as!  MyProfileCell
            let model = vm.data[row]
            cell.mainLabel.text = model.mainContent
            cell.subLabel.text = model.subContent
            
            // 如果是第三行,显示自定义view
            switch model.type {
            case .one:
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    cell.roundCorners([.topLeft,.topRight], radius: 10)
                }
            case .tree:
                cell.verifyView.isHidden = false
                cell.itemClickBlock = { [weak self] index in
                    print("点击了了 第\(index + 1)个")
                }
            case .four:
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    cell.roundCorners([.bottomLeft,.bottomRight], radius: 10)
                }
            default:break
            }
            return cell
        }
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
    
    
    
    @objc func injected () {
        
        contentView.removeAllSubviews()
        
        
        tableView = TTTableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.register(cellWithClass: MyProfileCell.self)
        tableView.register(cellWithClass: TTTableViewCell.self)
        tableView.bounces = false
        
        
        let header = ProfileHeader.init(model: Profile())
        header.backgroundColor = .lightGray
        tableView.tableHeaderView = header
//        tableView.isScrollEnabled = false
        header.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 215)
        
        
        // 设置头像
        header.avatar.image = R.image.profile_default_avatar()
        header.mainTitle.text = "禅悟"
        header.subTitle.text = "ID: \(239475)"
        
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalToSuperview()
            make.top.equalTo(0)
        }
        
//  padding = .init(inset: inset)
        
        // config
        backGroundImageView.image = UIImage.gradientImage(startPoint: CGPoint(x: 0.5, y: 0), endPoint:  CGPoint(x: 0.5, y: 1), colors: [rgba(238, 232, 255, 1),rgba(247, 247, 248, 1)], size: ttScreenSize())!
        
        // 选中item
        header.addPhotoBanner.selectedItem = { [weak self] (model,cell) in guard let self = self else { return }
            
            print("点击了相册")
        }
    }

}










