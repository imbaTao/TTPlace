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
    
    // 返回时的block 刷新
    var backActionBlock: ((_ images: [UIImage],_ allCount: Int) -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar(barColor: rgba(0, 0, 1, 1),titleColr: .white,font: .medium(18))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的照片"
        
        datas = [
            URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg")!,
            URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg")!,
            URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg")!,
//            URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg")!,
//            URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg")!
        ]
        
        creatPhotoItem(urls: datas)
        
        view.addSubview(tips)
        view.addSubview(gridContainer)
        
        gridContainer.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(SCREEN_W)
            make.bottom.equalToSuperview()
//            make.height.equalTo(hor(124 * 2) + 1)
            
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
        gridContainer.removeAllSubviews()
        for url in urls {
            let item = MyProfilePhotoPreViewItem.init(url: url)
            
            // 点击弹起alert
            item.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
                showEditPhotoAlert { [weak self] (index) in guard let self = self else { return }
                    switch index {
                    case 0:
                        // 查看大图
                        self.showPreview(index)
                    case 1:
                        // 删除
                        self.datas.remove(at: index - 1)
                        self.creatPhotoItem(urls: self.datas)
                    case 2:
                        break
                    default:
                        break
                    }
                }
            }).disposed(by: rx.disposeBag)
            
            items.append(item)
//            item.snp.makeConstraints { (make) in
////                make.height.equalTo(item.snp.width)
//                make.width.lessThanOrEqualTo(hor(124))
//            }
        }
        
        
        
        let defaultItem = MyProfilePhotoPreViewItem(url: nil, defaultItem: true)
        items.insert(defaultItem, at: 0)
        defaultItem.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self]  in guard let self = self else { return }
            
            if self.datas.count >= 6 {
                showError("最多上传六张!")
                return
            }
            
            // 跳转相册选择
            TTPhotoManager.chooseProfilePhotos(parentVC: topNav()!,maxCount: 1) {[weak self]  (images) in guard let self = self else { return }
                var model = images.first!
                
                model.imageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995403197&di=e37760a38644b49cb3a0719031ca3062&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg"
                self.appendImage(model)
            }
        }).disposed(by: rx.disposeBag)
        
        gridContainer.addSubviews(items)
        
        
        
        let itemWidth = (SCREEN_W - 2) / 3.0
        for index in 0..<items.count {
            let item = items[index]
            item.snp.makeConstraints { (make) in
                make.left.equalTo(Int(itemWidth + 1) * (index % 3))
                make.size.equalTo(itemWidth)
                make.top.equalTo(index > 2 ?  itemWidth + 1 : 0)
            }
        }
    }
    
    
    func reloadData() {
     
    }
    
    // 添加image
    func appendImage(_ model: TTAddPhotoBannerModel) {
        if let url = URL.init(string: model.imageUrl) {
            datas.append(url)
        }
        creatPhotoItem(urls: datas)
    }
    
    func showPreview(_ index: Int) {
        let vc = ZLImagePreviewController(datas: datas, index: index, showSelectBtn: false) { (url) -> ZLURLType in
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
    
    override func backAction() {
        var images = [UIImage]()
        for index in 1..<items.count {
            let item = items[index]
            images.append(item.iconView.image!)
        }
        
        if images.count > 3 {
            images = Array(images[0...2])
        }
        
        backActionBlock?(images,datas.count)
        super.backAction()
    }
}



func showEditPhotoAlert(buttonClick: @escaping (_ clickIndex: Int) -> ()) {
    // 内容
    let contentView = EditPhotoAlert()
    contentView.snp.makeConstraints { (make) in
        make.size.equalTo(ttSize(375, 170))
    }
    
    // 如果是嘉宾点击的事件
    let elevator =  TTElevatorView().creat(contentView: contentView,contentViewSize:ttSize(375, 170))
    
    // 查看大图
    contentView.bigPicButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {(_) in
        buttonClick(0)
        elevator.dismiss {
            
        }
    }).disposed(by: contentView.rx.disposeBag)
    
    // 送礼物
    contentView.deleteButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {(_) in
        buttonClick(1)
        elevator.dismiss {
            
        }
    }).disposed(by: contentView.rx.disposeBag)
    
    // 禁言
    contentView.cancleButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {(_) in
        buttonClick(2)
        elevator.dismiss {
            
        }
    }).disposed(by: contentView.rx.disposeBag)
}


class EditPhotoAlert: View {
    let bigPicButton = UIButton.title(title: "查看大图", titleColor: .mainTextColor, font: .medium(16))
    let deleteButton = UIButton.title(title: "删除", titleColor: .mainTextColor, font: .medium(16))
    let cancleButton = UIButton.title(title: "取消", titleColor: .mainTextColor, font: .medium(16))
    
    override func makeUI() {
        super.makeUI()
        addSubviews([bigPicButton,deleteButton,cancleButton])
        
        // layout
        bigPicButton.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(53)
        }
     
        deleteButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(bigPicButton.snp.bottom).offset(1)
            make.height.equalTo(bigPicButton)
        }
        
        cancleButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(deleteButton.snp.bottom).offset(inset)
            make.height.equalTo(bigPicButton)
        }
        
        // config
        backgroundColor = .white
        
        bigPicButton.addBorderWithPositon(direction: .bottom, color: rgba(245, 245, 245, 1), height: 1)
        deleteButton.addBorderWithPositon(direction: .bottom, color: rgba(245, 245, 245, 1), height: inset)
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
            let addIcon = UIImageView.name("Profile_ addPhoto")
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
        
        
        // config
//        iconView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
