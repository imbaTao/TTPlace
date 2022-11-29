//
//  TTTabbarItem.swift
//  TTBox
//
//  Created by Mr.hong on 2021/2/1.
//

import Foundation

// itemCell
class TTTabbarItem: TTCollectionViewCell {
    // 图标
    let itemIcon = UIImageView.empty()

    // 内容
    let itemContent = UILabel()

    // 渲染模型
    var model: TTTabbarViewControllerItemModel?

    // badage
    lazy var badge: TTBadge = {
        var badge = TTBadge.init(padding: .init(inset: 1))
        addSubview(badge)
        badge.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.itemIcon.snp.right)
            make.centerY.equalTo(self.itemIcon.snp.top)

        }
        return badge
    }()

    // 突起视图
    lazy var tuberView: TTTbbarItemTuberView = {

        var tuberView = TTTbbarItemTuberView.init(
            drawSourceRect: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 12),
            drawFillColor: .white, drawBorderWidth: 0.5)
        self.contentView.addSubview(tuberView)
        tuberView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.contentView.snp.top)
            make.height.equalTo(12)
            make.width.equalTo(self.bounds.width)
        }

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            //            // 遮挡用的视图
            //            var keepOutView = UIView.init()
            //            keepOutView.backgroundColor = .white
            //            self.contentView.addSubview(keepOutView)
            //            self.contentView.sendSubviewToBack(keepOutView)
            //            keepOutView.snp.makeConstraints { (make) in
            //                make.top.equalTo(baseTabbar()!.segementLine)
            //                make.left.right.equalToSuperview()
            //                make.bottom.equalTo(baseTabbar()!.segementLine)
            //            }
        }

        return tuberView
    }()

    // 初始化UI
    override func makeUI() {

        self.clipsToBounds = false
        self.layer.masksToBounds = false

        // 不可点击,点击事件由cell完成
        itemIcon.isUserInteractionEnabled = false
        itemContent.textAlignment = .center

        contentView.addSubview(itemIcon)
        contentView.addSubview(itemContent)

        // layout
        itemIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)

            // 默认不给size，需要UI给好图的尺寸
            //            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.top.equalTo(tabbarConfiguration.iconTopInteval)
        }

        itemContent.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(itemIcon.snp.bottom).offset(
                tabbarConfiguration.spacingBetweenImageAndTitle)
        }
    }

    // 渲染模型
    func rendModel(_ itemModel: TTTabbarViewControllerItemModel) {
        model = itemModel
        var imageName = ""
        if itemModel.selected {
            imageName = itemModel.selectedImageName
            self.itemContent.textColor = tabbarConfiguration.selectedColor
            self.itemContent.font = tabbarConfiguration.selectedFont
        } else {
            imageName = itemModel.normalImageName
            self.itemContent.textColor = tabbarConfiguration.normalClor
            self.itemContent.font = tabbarConfiguration.normalFont
        }

        // 如果包含网页
        if imageName.contains("http") {
            self.itemIcon.kf.setImage(with: URL.init(string: imageName))
        } else {
            let image = UIImage.name(imageName)
            self.itemIcon.image = image
        }

        // 如果没有icon
        if imageName.isEmpty {
            // layout
            itemContent.snp.remakeConstraints { (make) in
                make.center.equalTo(self)
            }

            itemIcon.snp_removeConstraints()
        }

        // 如果没有内容，纯图标tabbarItem，得重新布局
        if itemModel.itemContent.isEmpty {
            // layout
            itemIcon.snp.remakeConstraints { (make) in
                make.center.equalTo(self)
            }

            itemContent.snp_removeConstraints()
        } else {
            self.itemContent.text = itemModel.itemContent
        }

        if itemModel.isTuber {
            tuberView.isHidden = false
        }
    }

    // 播放动画
    func playAnimationIcon(_ iconNames: [String]) {
        // 如果为没有图片名称，那么就不执行
        guard iconNames.count == 0 else {
            return
        }

        var iconImages = [UIImage]()
        for i in 0...12 {
            iconImages.append(UIImage.name(iconNames[i]))
        }

        itemIcon.animationImages = iconImages  // 装图片的数组(需要做动画的图片数组)
        itemIcon.animationDuration = 2  // 动画时间
        itemIcon.animationRepeatCount = 1  // 重复次数 0 表示重复
        itemIcon.startAnimating()  // 开始序列帧动画
    }
}
