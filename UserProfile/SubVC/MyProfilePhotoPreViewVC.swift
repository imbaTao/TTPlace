//
//  MyProfilePhotoPreViewVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/3.
//

import UIKit
import RxGesture
import ZLPhotoBrowser


class MyProfilePhotoPreViewVC: ViewController {
    
    // 我的照片
    var items = [MyProfilePhotoPreViewItem]()
    
    // 数据源
    var datas = [URL]()
    
    var tips = UILabel.regular(size: 14, textColor: rgba(255, 255, 255, 0.6), text: "最多上传6张，点击可查看/删除照片", alignment: .center)
        
    // 网格容器
    var gridContainer = UIView.init()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar(barColor: rgba(0, 0, 1, 1),titleColr: .white,font: .medium(18))
    }
    
    
    override func viewDidLoad() {
        self.title = "我的照片"
        
        datas = [
            URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg")!,
            URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg")!,
            URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg")!
        ]
        
        creatPhotoItem(urls: datas)
        
        view.addSubview(tips)
        view.addSubview(gridContainer)
        
        gridContainer.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(hor(124 * 2 + 1))
        }
        tips.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(ver(-65))
        }

        view.backgroundColor = rgba(0, 0, 1, 1)
    }
    
    
    // 创建照片墙
    func creatPhotoItem(urls: [URL])  {
        
        items.removeAll()
        for url in urls {
            let item = MyProfilePhotoPreViewItem.init(url: url)
            
            // 点击直接进入预览页
            item.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
                self?.showPreview()
            }).disposed(by: rx.disposeBag)
            
            
            // 长按弹起面板
            item.rx.longPressGesture().subscribe(onNext: {[weak self] (_) in
                
            }).disposed(by: rx.disposeBag)
            
            items.append(item)
        }
        
       
        items.insert(MyProfilePhotoPreViewItem(url: nil, defaultItem: true), at: 0)
        gridContainer.addSubviews(items)
        
        items.snp.distributeSudokuViews(fixedLineSpacing: 1, fixedInteritemSpacing: 1, warpCount: 3, edgeInset: .zero)
        
    }
    
    
    
    
    
    func showPreview() {
        let vc = ZLImagePreviewController(datas: datas, index: 0, showSelectBtn: false) { (url) -> ZLURLType in
                return .image
        } urlImageLoader: { (url, imageView, progress, loadFinish) in
            imageView.kf.setImage(with: url) { (receivedSize, totalSize) in
                let percentage = (CGFloat(receivedSize) / CGFloat(totalSize))
//                debugPrint("\(percentage)")
                progress(percentage)
            } completionHandler: { (_) in
                loadFinish()
            }
        }
        
        vc.doneBlock = { (datas) in
            debugPrint(datas)
        }
        
        vc.modalPresentationStyle = .fullScreen
        self.showDetailViewController(vc, sender: nil)
    }
}


//MARK: - 照片预览控制器
class MyProfilePhotoPreViewItem: UIControl {
    var iconView = UIImageView.empty()
    var url: URL?
    
    init(url: URL?,defaultItem: Bool = false) {
        super.init(frame: .zero)
        self.url = url
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        iconView.clipsToBounds = true
    
        
        if url != nil {
            // 加载图片
            iconView.kf.setImage(with: url)
        }
        
        
        // 默认的添加item
        if defaultItem {
            let addIcon = UIImageView.name("TTAddPhotoBanner_defaultAddIcon")
            let tips = UILabel.regular(size: 14,textColor: .white, text: "添加照片",alignment: .center)
            iconView.image = UIImage.gradientImage(startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 0.28, y: 0.28), colors: [rgba(253, 120, 202, 1),rgba(143, 64, 246, 1)], size: ttSize(124))
            addSubviews([addIcon,tips])
            addIcon.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-ver(10))
                make.size.equalTo(ttSize(38))
            }
            
            tips.snp.makeConstraints { (make) in
                make.top.equalTo(addIcon.snp.bottom).offset(ver(12))
                make.centerX.equalToSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
