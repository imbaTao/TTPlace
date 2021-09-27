//
//  TTTableViewCell.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit
//
class TTTableViewCell: UITableViewCell {

    var cellDisposeBag = DisposeBag()
    
    var isSelection = false
    
    lazy var containerView: View = {
        let containerView = View()
        containerView.backgroundColor = .clear
        stackView.addArrangedSubview(containerView)
//        containerView.snp.makeConstraints({ (make) in
////            make.size.lessThanOrEqualToSuperview()
//            make.edges.equalToSuperview()
//        })
        return containerView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView.empty()
        containerView.insertSubview(view, at: 0)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }()

    lazy var stackView: TTStackView = {
        let subviews: [UIView] = []
        let stackView = TTStackView(arrangedSubviews: subviews)
//        stackView.axis = .vertical
//        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
//            make.top.left.equalToSuperview()
//            make.size.lessThanOrEqualToSuperview()
            make.edges.equalToSuperview()
        }
        
        return stackView
    }()
    
  
    
    lazy var avatar: TTAvatar = {
        var avatar = TTAvatar()
        return avatar
    }()
    

    lazy var leftImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()
    
    lazy var centerImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()
    
    lazy var rightImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()


    lazy var mainLabel: UILabel = {
        let view = UILabel.regular()
        return view
    }()
    

    lazy var subLabel: UILabel = {
        
        let view = UILabel.regular()
        return view
    }()

    lazy var secondSubLabel: UILabel = {
        let view = UILabel.regular()
        return view
    }()

//    lazy var attributeLabel: YYLabel = {
//        let view = YYLabel.regular(size: 16, text: "", textColor: .white, alignment: .left)
//        return view
//    }()

  
    lazy var segementLine: UIView = {
        let view = UIView.color(TTBoxColor.shard.segmentColor)
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
        return view
    }()

    func makeUI() {
        layer.masksToBounds = true
//        selectionStyle = .none
        backgroundColor = .clear
        updateUI()
        bindViewModel()
        stackView.backgroundColor = .clear
    }
    
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    func bindViewModel() {
        
    }
    
    func bind(to viewModel: TTTableViewCellViewModel) {
        // 释放之前的绑定
        cellDisposeBag = DisposeBag()
        
        
        // 赋值，没有值就隐藏
        viewModel.mainContent.asDriver().drive(mainLabel.rx.text).disposed(by: cellDisposeBag)
        viewModel.mainContent.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(mainLabel.rx.isHidden).disposed(by: cellDisposeBag)

        // 是子内容
        viewModel.subContent.asDriver().drive(subLabel.rx.text).disposed(by: cellDisposeBag)
        viewModel.subContent.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(subLabel.rx.isHidden).disposed(by: cellDisposeBag)

        //  第二条子内容
        viewModel.secondSubContent.asDriver().drive(secondSubLabel.rx.text).disposed(by: cellDisposeBag)
        viewModel.secondSubContent.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(secondSubLabel.rx.isHidden).disposed(by: cellDisposeBag)

    
//        viewModel.hidesDisclosure.asDriver().drive(rightImageView.rx.isHidden).disposed(by: cellDisposeBag)

        // 头像
        viewModel.avatarImage.asDriver().filterNil()
            .drive(avatar.rx.image).disposed(by: cellDisposeBag)
        viewModel.avatarImageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(avatar.rx.imageURL).disposed(by: cellDisposeBag)
        viewModel.avatarImageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.avatar.hero.id = url
            }).disposed(by: cellDisposeBag)
     
        
        
        // 左侧图片
        viewModel.leftImage.asDriver().filterNil()
            .drive(leftImageView.rx.image).disposed(by: cellDisposeBag)
        viewModel.leftImageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(leftImageView.rx.imageURL).disposed(by: cellDisposeBag)
        viewModel.leftImageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.leftImageView.hero.id = url
            }).disposed(by: cellDisposeBag)
        viewModel.hideLeftImage.bind(to: leftImageView.rx.isHidden).disposed(by: cellDisposeBag)
        
        
        // 中心图片
        viewModel.centerImage.asDriver().filterNil()
            .drive(centerImageView.rx.image).disposed(by: cellDisposeBag)
        viewModel.centerImageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(centerImageView.rx.imageURL).disposed(by: cellDisposeBag)
        viewModel.centerImageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.centerImageView.hero.id = url
            }).disposed(by: cellDisposeBag)
        viewModel.hideCenterImage.bind(to: centerImageView.rx.isHidden).disposed(by: cellDisposeBag)
        
        // 右侧图片
        viewModel.rightImage.asDriver().filterNil()
            .drive(rightImageView.rx.image).disposed(by: cellDisposeBag)
        viewModel.rightImageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(rightImageView.rx.imageURL).disposed(by: cellDisposeBag)
        viewModel.rightImageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.rightImageView.hero.id = url
            }).disposed(by: cellDisposeBag)
        viewModel.hideRightImage.bind(to: rightImageView.rx.isHidden).disposed(by: cellDisposeBag)
        
        // 是否隐藏分割线
        viewModel.hasBottomLine.map{!$0}.bind(to: segementLine.rx.isHidden).disposed(by: cellDisposeBag)
    }
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.isHidden = false
        makeUI()

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    // 复用的时候释放所有监控
    override func prepareForReuse() {
        super.prepareForReuse()
        cellDisposeBag = DisposeBag()
    }
}
